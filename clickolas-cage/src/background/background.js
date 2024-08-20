import { sendMessageToContentScript, sleep } from '../utils'
import { getNextStepFromLLM, promptToFirstStep, initializeOpenAI } from '../llm-utils'

chrome.storage.local.set({ logs: [] })
console.log('background is running')

let state = {
  currentPlan: [],
  targetTab: null,
  currentStep: 0,
  originalPrompt: '',
  currentURL: '',
  allowedTabs: new Set(),
  currentModel: 'gemini-1.5-flash-latest',
  currentProvider: 'google',
  currentApiKey: null,
  isExecuting: false,
  stopRequested: false,
}

// Function to get the current state
const getState = () => ({ ...state })

// Function to update the state
const updateState = (newState) => {
  state = { ...state, ...newState }
  // console.log('State updated:', state)
}

/**
 * Navigates to a specified URL in a new tab and adds the tab to the allowedTabs set.
 * @param {string} url - The URL to navigate to.
 * @returns {Promise<chrome.tabs.Tab>} A promise that resolves with the created tab object.
 */
const navURL = (url) => {
  console.log('navigating to', url)
  updateState({ currentURL: url })
  //Needs http otherwise does not go to absolute URL
  if (url.indexOf('http') !== 0) {
    url = 'http://' + url
  }
  return new Promise((resolve, reject) => {
    chrome.tabs.create({ url: url }, (tab) => {
      if (chrome.runtime.lastError) {
        // If there's an error during tab creation, reject the promise
        reject(new Error(chrome.runtime.lastError))
      } else {
        const newAllowedTabs = new Set(getState().allowedTabs)
        newAllowedTabs.add(tab.id)
        updateState({
          allowedTabs: newAllowedTabs,
          targetTab: tab.id,
        })
        updateState({ isExecuting: true })
        sendMessageToTab(tab.id, { type: 'execution_started' })
        resolve(tab) // Resolve the promise with the tab object
      }
    })
  })
}

/**
 * Marks the current task as completed and sends a message to the target tab to proceed with the next step.
 */
const completedTask = async () => {
  const currentState = getState()
  console.log('Completed task. Step:', currentState.currentStep)
  updateState({ currentStep: currentState.currentStep + 1 })
  console.log('sleeping 1s...')
  await sleep(1000)
  const updatedState = getState()
  console.log('Moving to next step:', updatedState.currentStep)

  // Check if the last action was GOAL_ACHIEVED
  const lastAction = updatedState.currentPlan[updatedState.currentStep - 1]
  if (lastAction && lastAction.action === 'GOAL_ACHIEVED') {
    console.log('Goal achieved. Stopping execution.')
    return
  }

  if (updatedState.currentStep >= updatedState.currentPlan.length) {
    console.log('Current plan completed. Generating next step.')
    sendMessageToTab(updatedState.targetTab, {
      type: 'generateNextStep',
      currentStep: updatedState.currentStep,
      plan: updatedState.currentPlan,
    })
  } else {
    console.log('Executing next step in current plan.')
    await executeCurrentStep()
  }
}

/**
 * Adds a new step to the current plan and executes it.
 * @param {Object} step - The step to add to the plan.
 */
const addStepToPlan = async (step) => {
  const currentState = getState()
  if (currentState.stopRequested) {
    console.log('Execution stopped, not adding new step to plan')
    updateState({ isExecuting: false, stopRequested: false })
    return
  }
  const newPlan = [...currentState.currentPlan, step]
  console.log('new plan', newPlan)
  updateState({ currentPlan: newPlan })
  if (!currentState.isExecuting) {
    updateState({ isExecuting: true })
    sendMessageToTab(currentState.targetTab, { type: 'execution_started' })
  }
  await executeCurrentStep()
}

/**
 * Executes the current step in the plan based on its action type.
 */
const executeCurrentStep = async () => {
  const currentState = getState()
  if (!currentState.isExecuting) {
    console.log('Execution is not in progress')
    return
  }
  if (currentState.stopRequested) {
    console.log('Execution stopped due to user request')
    updateState({ isExecuting: false, stopRequested: false })
    sendMessageToTab(currentState.targetTab, { type: 'execution_completed' })
    return
  }
  console.log('Executing current step')
  console.log('Current step:', currentState.currentStep)
  console.log('Current plan:', JSON.stringify(currentState.currentPlan))
  try {
    const currentAction = currentState.currentPlan[currentState.currentStep]
    if (!currentAction) {
      console.error('No action found for current step')
      updateState({ isExecuting: false })
      return
    }
    console.log('Current action:', currentAction.action)
    if (currentAction.action === 'NAVURL') {
      await navURL(currentAction.param)
      await completedTask()
    } else if (currentAction.action === 'CLICKBTN') {
      console.log('Executing CLICKBTN action:', currentAction.ariaLabel)
      await sendMessageToTab(currentState.targetTab, {
        type: 'locateElement',
        ariaLabel: currentAction.ariaLabel,
        action: currentAction.action,
      })
    } else if (currentAction.action === 'TYPETEXT') {
      console.log('Executing TYPETEXT action:', currentAction.text)
      await sendMessageToTab(currentState.targetTab, {
        type: 'locateElement',
        ariaLabel: currentAction.ariaLabel,
        action: currentAction.action,
        text: currentAction.text,
      })
    } else if (currentAction.action === 'GOAL_ACHIEVED') {
      console.log('Goal achieved. Execution completed.')
      await sendMessageToTab(currentState.targetTab, {
        type: 'goalCompleted',
        message: currentAction.thought,
      })
      // Don't call completedTask() here, as we want to stop execution
    } else if (currentAction.action === 'ASKUSER') {
      // TODO: Handle ASKUSER
    } else {
      console.error('Unknown action type:', currentAction.action)
    }
  } catch (error) {
    console.error('Error executing current step:', error)
    updateState({ isExecuting: false })
    sendMessageToTab(currentState.targetTab, { type: 'execution_completed' })
  }
}

/**
 * Processes messages received from content scripts or other parts of the extension.
 * @param {Object} request - The request object received.
 * @param {MessageSender} sender - An object containing information about the sender of the message.
 * @param {function} sendResponse - Function to call when you have a response. The argument should be any JSON-ifiable object.
 * @returns {Promise<string>} A promise that resolves with a string indicating the completion status.
 */
const processResponse = async (request, sender, sendResponse) => {
  console.log('received', JSON.stringify(request))
  let currentState = getState()
  try {
    switch (request.type) {
      case 'checkTabAllowed':
        const isAllowed = currentState.allowedTabs.has(sender.tab.id)
        return sendResponse({ isAllowed: isAllowed })
      case 'completed_task':
        completedTask()
        break
      case 'new_goal':
        updateState({
          currentStep: 0,
          currentPlan: [],
          originalPrompt: request.prompt,
          isExecuting: true,
          stopRequested: false,
        })
        sendMessageToTab(currentState.targetTab, { type: 'execution_started' })
        const responseJSON = await promptToFirstStep(
          request.prompt,
          currentState.currentModel,
          currentState.currentProvider,
        )
        //TODO: if failed to give valid json retry
        responseJSON.action = 'NAVURL' // Hard coded for now
        await addStepToPlan(responseJSON)
        break
      case 'click_element':
        clickElement(state.targetTab, request.selector)
        break
      case 'press_tab_key':
        await pressTabKey(state.targetTab)
        break
      case 'next_step_with_elements':
        if (currentState.currentStep < currentState.currentPlan.length) {
          await executeCurrentStep()
        } else {
          console.log('Generating next step')
          const nextStepWithElements = await getNextStepFromLLM(
            currentState.originalPrompt,
            currentState.currentURL,
            currentState.currentPlan,
            request.elements,
            request.focusedElement,
            null, // notFoundElement
            currentState.currentModel,
            currentState.currentProvider,
          )
          console.log('Next step from LLM:', JSON.stringify(nextStepWithElements))
          await addStepToPlan(nextStepWithElements)
        }
        break
      case 'element_located':
        if (request.action === 'CLICKBTN') {
          await clickElement(currentState.targetTab, request.selector)
        } else if (request.action === 'TYPETEXT') {
          await typeText(currentState.targetTab, request.selector, request.text)
          completedTask()
        }
        break
      case 'element_not_found':
        // Handle the case when an element is not found
        updateState({ currentStep: currentState.currentStep + 1 })
        console.log('Element not found:', request.ariaLabel)
        updateState({ currentStep: currentState.currentStep + 1 })
        const nextStepAfterFailure = await getNextStepFromLLM(
          currentState.originalPrompt,
          currentState.currentURL,
          currentState.currentPlan,
          request.elements,
          request.focusedElement,
          request.ariaLabel, // Pass the aria-label of the element that wasn't found
          currentState.currentModel,
          currentState.currentProvider,
        )
        console.log('Next step from LLM:', JSON.stringify(nextStepAfterFailure))
        await addStepToPlan(nextStepAfterFailure)
        break
      case 'updateModelAndProvider':
        await updateModelAndProvider(request.model, request.provider, request.apiKey)
        break
      case 'getModelAndProvider':
        const apiKey = await getApiKey()
        await initializeOpenAI(apiKey, currentState.currentModel, currentState.currentProvider)
        sendResponse({
          currentModel: currentState.currentModel,
          currentProvider: currentState.currentProvider,
          currentApiKey: apiKey,
        })
        return true // Indicate that we're sending a response asynchronously
      case 'user_message':
        if (!currentState.isExecuting) {
          updateState({ isExecuting: true, stopRequested: false })
          sendMessageToTab(currentState.targetTab, { type: 'execution_started' })
        }
        console.log('Generating next step based on user message')
        const nextStepWithElements = await getNextStepFromLLM(
          currentState.originalPrompt,
          currentState.currentURL,
          request.plan,
          request.elements,
          request.focusedElement,
          null, // notFoundElement
          currentState.currentModel,
          currentState.currentProvider,
          request.message, // Add the user's message to the LLM input
        )
        // Check if stop was requested while waiting for LLM response
        if (getState().stopRequested) {
          console.log('Execution stopped, discarding LLM response')
          updateState({ stopRequested: false })
          break
        }
        console.log('Next step from LLM:', JSON.stringify(nextStepWithElements))
        await addStepToPlan(nextStepWithElements)
        break
      case 'stop_execution':
        updateState({ isExecuting: false, stopRequested: true })
        // Cancel any ongoing tasks or timers here
        sendMessageToTab(currentState.targetTab, { type: 'execution_completed' })
        break
    }
    if (sendResponse) sendResponse('completed')
  } catch (error) {
    console.error('Error in processResponse:', error)
    updateState({ isExecuting: false, stopRequested: false })
    sendMessageToTab(currentState.targetTab, { type: 'execution_completed' })
    return sendResponse('error')
  }
}

// Add these functions for handling secure storage
const saveApiKey = (apiKey) => {
  return new Promise((resolve) => {
    chrome.storage.sync.set({ apiKey: apiKey }, resolve)
  })
}

const getApiKey = () => {
  return new Promise((resolve) => {
    chrome.storage.sync.get(['apiKey'], (result) => {
      resolve(result.apiKey || null)
    })
  })
}

// Modify the updateModelAndProvider function
const updateModelAndProvider = async (model, provider, apiKey) => {
  updateState({ currentModel: model, currentProvider: provider })
  if (apiKey) {
    await saveApiKey(apiKey)
    updateState({ currentApiKey: apiKey })
  }
  console.log(apiKey, 'apiKey - updated')
  await initializeOpenAI(apiKey, model, provider)
}

// Initialize the state with the API key on startup
;(async () => {
  const apiKey = await getApiKey()
  updateState({ currentApiKey: apiKey })
})()

chrome.commands.onCommand.addListener((command) => {
  if (command === 'open-extension') {
    chrome.tabs.create({ url: 'popup.html' })
  }
})

chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  if (request.type === 'getModelAndProvider') {
    processResponse(request, sender, sendResponse)
    return true // Indicate that we will send a response asynchronously
  } else {
    processResponse(request, sender, sendResponse)
      .then(() => {
        sendResponse('completed')
      })
      .catch((error) => {
        console.error('Error processing response:', error)
        sendResponse('error')
      })
    return true // Indicate that the response is asynchronous
  }
})

/**
 * Sends a message to a specific tab and retries if necessary.
 * @param {number} tabId - The ID of the tab to send the message to.
 * @param {Object} message - The message to send to the tab.
 */
async function sendMessageToTab(tabId, message) {
  let retries = 3
  const currentState = getState()
  await checkTabReady(currentState.targetTab)
  while (retries > 0) {
    try {
      const response = await new Promise((resolve, reject) => {
        console.log('sending message', message)
        chrome.tabs.sendMessage(tabId, message, function (response) {
          if (chrome.runtime.lastError) {
            console.log('reject')
            console.log(chrome.runtime.lastError.message)
            reject(new Error(chrome.runtime.lastError.message))
          } else {
            console.log('resolve')
            processResponse(response)
            resolve(response)
          }
        })
      })
      return
    } catch (error) {
      console.error('Error in sending message:', error)
      retries--
      if (retries === 0) throw error
      await new Promise((resolve) => setTimeout(resolve, 1000)) // Wait a bit before retrying
    }
  }
}

/**
 * Checks if a tab is ready by listening for the 'complete' status update.
 * @param {number} tabId - The ID of the tab to check.
 */
function checkTabReady(tabId) {
  return new Promise((resolve, reject) => {
    console.log('waiting tab ready...')
    chrome.tabs.sendMessage(tabId, { type: 'ping' }, function (response) {
      if (chrome.runtime.lastError) {
        console.log('Content script not ready:', chrome.runtime.lastError.message)
        setTimeout(() => checkTabReady(tabId).then(resolve).catch(reject), 1000) // Retry after a delay
      } else {
        console.log('Content script ready:', response)
        resolve('complete')
      }
    })
  })
}

/**
 * Attaches the debugger to a tab.
 * @param {number} tabId - The ID of the tab to attach the debugger to.
 * @returns {Promise<void>} A promise that resolves when the debugger is attached.
 */
async function attachDebugger(tabId) {
  return new Promise((resolve, reject) => {
    chrome.debugger.attach({ tabId }, '1.2', () => {
      if (chrome.runtime.lastError) {
        reject(chrome.runtime.lastError.message)
      } else {
        resolve()
      }
    })
  })
}

/**
 * Retrieves the root DOM node of a tab.
 * @param {number} tabId - The ID of the tab to get the root DOM node from.
 * @returns {Promise<Object>} A promise that resolves with the root DOM node.
 */
async function getDocumentRoot(tabId) {
  return new Promise((resolve, reject) => {
    chrome.debugger.sendCommand({ tabId }, 'DOM.getDocument', {}, (result) => {
      if (chrome.runtime.lastError) {
        reject(chrome.runtime.lastError.message)
      } else {
        resolve(result.root)
      }
    })
  })
}

/**
 * Finds a DOM node by its selector.
 * @param {number} tabId - The ID of the tab to search within.
 * @param {Object} root - The root node to start the search from.
 * @param {string} selector - The CSS selector of the node to find.
 * @returns {Promise<number>} A promise that resolves with the node ID of the found element.
 */
async function querySelectorNode(tabId, root, selector) {
  return new Promise((resolve, reject) => {
    chrome.debugger.sendCommand(
      { tabId },
      'DOM.querySelector',
      { nodeId: root.nodeId, selector },
      (result) => {
        if (chrome.runtime.lastError) {
          reject(chrome.runtime.lastError.message)
        } else {
          resolve(result.nodeId)
        }
      },
    )
  })
}

/**
 * Retrieves the box model information for a given DOM node.
 * @param {number} tabId - The ID of the tab that contains the node.
 * @param {number} nodeId - The ID of the node to get the box model for.
 * @returns {Promise<Object>} A promise that resolves with the box model of the node.
 */
async function getBoxModelForNode(tabId, nodeId) {
  return new Promise((resolve, reject) => {
    chrome.debugger.sendCommand({ tabId }, 'DOM.getBoxModel', { nodeId }, (result) => {
      if (chrome.runtime.lastError) {
        reject(chrome.runtime.lastError.message)
      } else {
        resolve(result.model)
      }
    })
  })
}

/**
 * Dispatches a mouse event to a specific location in a tab.
 * @param {number} tabId - The ID of the tab to dispatch the event to.
 * @param {string} type - The type of mouse event (e.g., 'mousePressed', 'mouseReleased').
 * @param {number} x - The x coordinate of the event location.
 * @param {number} y - The y coordinate of the event location.
 * @param {string} button - The mouse button (e.g., 'left', 'right').
 * @param {number} clickCount - The number of times the button is clicked.
 * @returns {Promise<void>} A promise that resolves when the event has been dispatched.
 */
async function dispatchMouseEvent(tabId, type, x, y, button, clickCount) {
  return new Promise((resolve, reject) => {
    chrome.debugger.sendCommand(
      { tabId },
      'Input.dispatchMouseEvent',
      {
        type,
        x,
        y,
        button,
        clickCount,
      },
      () => {
        if (chrome.runtime.lastError) {
          reject(chrome.runtime.lastError.message)
        } else {
          resolve()
        }
      },
    )
  })
}

/**
 * Simulates a click event at a specific location within a tab.
 * @param {number} tabId - The ID of the tab to perform the click in.
 * @param {number} x - The x coordinate of the click location.
 * @param {number} y - The y coordinate of the click location.
 */
async function clickElementAt(tabId, x, y) {
  await dispatchMouseEvent(tabId, 'mousePressed', x, y, 'left', 1)
  await dispatchMouseEvent(tabId, 'mouseReleased', x, y, 'left', 1)
  const messagePayload = {
    type: 'showClick',
    x,
    y,
  }
  sendMessageToTab(getState().targetTab, messagePayload)
}

/**
 * Performs a click action on an element identified by a CSS selector.
 * @param {number} tabId - The ID of the tab where the element resides.
 * @param {string} selector - The CSS selector of the element to click.
 */
async function clickElement(tabId, selector) {
  try {
    console.log('Clicking element with selector:', selector)
    await attachDebugger(tabId)
    const root = await getDocumentRoot(tabId)
    const nodeId = await querySelectorNode(tabId, root, selector)
    const model = await getBoxModelForNode(tabId, nodeId)
    const { content } = model
    const x = (content[0] + content[2]) / 2
    const y = (content[1] + content[5]) / 2

    await clickElementAt(tabId, x, y)
    chrome.debugger.detach({ tabId })
    await sleep(2000)
  } catch (e) {
    console.error('Error in clickElement:', e)
  }
}

/**
 * Simulates pressing the Tab key within a tab.
 * @param {number} tabId - The ID of the tab to press the Tab key in.
 */
async function pressTabKey(tabId) {
  try {
    await attachDebugger(tabId)
    await dispatchTabKeyPress(tabId)
    chrome.debugger.detach({ tabId })
  } catch (e) {
    console.log(e, 'e')
  }
}

/**
 * Dispatches a Tab key press event to a tab.
 * @param {number} tabId - The ID of the tab to dispatch the Tab key press to.
 * @returns {Promise<void>} A promise that resolves when the Tab key press event has been dispatched.
 */
async function dispatchTabKeyPress(tabId) {
  return new Promise((resolve, reject) => {
    chrome.debugger.sendCommand(
      { tabId },
      'Input.dispatchKeyEvent',
      {
        type: 'keyDown',
        key: 'Tab',
        code: 'Tab',
        windowsVirtualKeyCode: 9,
        nativeVirtualKeyCode: 9,
      },
      () => {
        if (chrome.runtime.lastError) {
          reject(chrome.runtime.lastError.message)
        } else {
          // Since TAB is a key press, we might want to ensure keyUp is also sent to simulate a complete key press
          chrome.debugger.sendCommand(
            { tabId },
            'Input.dispatchKeyEvent',
            {
              type: 'keyUp',
              key: 'Tab',
              code: 'Tab',
              windowsVirtualKeyCode: 9,
              nativeVirtualKeyCode: 9,
            },
            () => {
              if (chrome.runtime.lastError) {
                reject(chrome.runtime.lastError.message)
              } else {
                resolve()
              }
            },
          )
        }
      },
    )
  })
}

async function typeText(tabId, selector, text) {
  try {
    if (selector) {
      console.log('Typing text into element with selector:', selector)
      await attachDebugger(tabId)
      const root = await getDocumentRoot(tabId)
      const nodeId = await querySelectorNode(tabId, root, selector)
      // Focus the element
      await chrome.debugger.sendCommand({ tabId }, 'DOM.focus', { nodeId })
    }

    // Type each character
    for (const char of text) {
      await dispatchKeyEvent(tabId, 'keyDown', char)
      await dispatchKeyEvent(tabId, 'keyUp', char)
      await sleep(100) // Add a small delay between keystrokes
    }

    chrome.debugger.detach({ tabId })
  } catch (e) {
    console.error('Error in typeText:', e)
  }
}

async function dispatchKeyEvent(tabId, type, key) {
  return new Promise((resolve, reject) => {
    chrome.debugger.sendCommand(
      { tabId },
      'Input.dispatchKeyEvent',
      {
        type,
        text: key,
        unmodifiedText: key,
        key,
        code: `Key${key.toUpperCase()}`,
        windowsVirtualKeyCode: key.charCodeAt(0),
        nativeVirtualKeyCode: key.charCodeAt(0),
      },
      () => {
        if (chrome.runtime.lastError) {
          reject(chrome.runtime.lastError.message)
        } else {
          resolve()
        }
      },
    )
  })
}

// --- We only allow content script to execute on tabs created by background script
// Listen for when a tab is closed and remove it from the set
/**
 * Listens for tab removal events and removes the closed tab from the allowedTabs set.
 */
chrome.tabs.onRemoved.addListener(function (tabId) {
  const currentState = getState()
  const newAllowedTabs = new Set(currentState.allowedTabs)
  newAllowedTabs.delete(tabId)
  updateState({ allowedTabs: newAllowedTabs })
})
