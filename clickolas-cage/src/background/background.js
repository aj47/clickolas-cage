import { getDomain, sendMessageToContentScript, sleep } from '../utils'

import {
  checkCandidatePrompts,
  getNextStepFromLLM,
  promptToFirstStep,
  sendPromptToPlanner,
} from '../llm-utils'

chrome.storage.local.set({ logs: [] })
console.log('background is running')

let currentPlan = []
let targetTab = null
let currentStep = 0
let originalPrompt = ''
let currentURL = ''
let allowedTabs = new Set()
let focusedElements = []

/**
 * Navigates to a specified URL in a new tab and adds the tab to the allowedTabs set.
 * @param {string} url - The URL to navigate to.
 * @returns {Promise<chrome.tabs.Tab>} A promise that resolves with the created tab object.
 */
const navURL = (url) => {
  console.log(url, 'url')
  currentURL = url
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
        allowedTabs.add(tab.id) //allowed tabs enables content script
        targetTab = tab.id // Store the tab ID for later use
        resolve(tab) // Resolve the promise with the tab object
      }
    })
  })
}

/**
 * Marks the current task as completed and sends a message to the target tab to proceed with the next step.
 */
const completedTask = () => {
  if (currentStep >= currentPlan.length) {
    console.log('plan complete.')
    return
  }
  console.log(currentStep, 'before')
  currentStep++
  const messagePayload = {
    currentStep: currentStep - 1,
    originalPlan: currentPlan,
    originalPrompt,
  }
  console.log(currentStep)
  sendMessageToTab(targetTab, messagePayload)
}

/**
 * Adds a new step to the current plan and executes it.
 * @param {Object} step - The step to add to the plan.
 */
const addStepToPlan = (step) => {
  currentPlan.push(step)
  executeCurrentStep()
}

/**
 * Executes the current step in the plan based on its action type.
 */
const executeCurrentStep = async () => {
  console.log('inside execute current step')
  try {
    if (currentPlan[currentStep].action === 'NAVURL') {
      await navURL(currentPlan[currentStep].param)
    } else if (currentPlan[currentStep].action === 'CLICKBTN') {
      //Send message to Content Script to get the element
      //Then it's sent back to Background script to execute click in debug mode
      await sendMessageToTab(targetTab, {
        type: 'clickElement',
        ariaLabel: currentPlan[currentStep].ariaLabel,
      })
      // await clickElement(targetTab, currentPlan[currentStep].ariaLabel)
    } else if (currentPlan[currentStep].action === 'ASKUSER') {
      // if the action is ASKUSER
      // TODO: Handle ASKUSER
    }
    console.log(currentStep, 'step')
    currentStep++
    await getNextStep()
  } catch (error) {
    console.error('Error executing current step:', error)
  }
}

/**
 * Checks if the next step can be executed and sends a message to the target tab to generate the next step.
 */
const getNextStep = async () => {
  console.log('inside next step ting')
  // Check if the tab is completely loaded before sending a message
  console.log(targetTab)
  console.log(currentStep, 'step')
  const messagePayload = {
    type: 'generateNextStep',
    currentStep: currentStep,
    originalPlan: currentPlan,
    originalPrompt,
  }
  try {
    console.log('Sending message payload:', JSON.stringify(messagePayload))
    await sendMessageToTab(targetTab, messagePayload)
    console.log('Message successfully sent to generateNextStep', JSON.stringify(messagePayload))
  } catch (error) {
    console.error('Failed to send message from getNextStep:', error)
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
  console.log('recieved', JSON.stringify(request))
  try {
    switch (request.type) {
      case 'checkTabAllowed':
        const isAllowed = allowedTabs.has(sender.tab.id)
        return sendResponse({ isAllowed: isAllowed })
      case 'nav_url':
        navURL(request.url)
        break
      case 'completed_task':
        completedTask()
        break
      case 'new_goal':
        currentStep = 0
        currentPlan = []
        originalPrompt = request.prompt
        const responseJSON = await promptToFirstStep(request.prompt)
        //TODO: if failed to give valid json retry
        responseJSON.action = 'NAVURL' // Hard coded for now
        addStepToPlan(responseJSON)
        break
      case 'click_element':
        clickElement(targetTab, request.selector)
        break
      case 'press_tab_key':
        await pressTabKey(targetTab)
        break
      case 'new_focused_element':
        focusedElements.push(request.element)
        break
      case 'next_step_with_elements':
        console.log('-------------------------------------')
        const nextStepWithElements = await getNextStepFromLLM(
          originalPrompt,
          currentURL,
          currentPlan,
          currentStep,
          request.elements,
        )
        // sendMessageToTab(targetTab, { type: 'addThought', originalPlan: currentPlan })
        console.log('next step', nextStepWithElements)
        addStepToPlan(nextStepWithElements)
        break
      case 'next_step':
        console.log('-------------------------------------')
        console.log(focusedElements, 'focusedElements')
        const nextStep = await getNextStepFromLLM(
          originalPrompt,
          currentURL,
          currentPlan,
          currentStep,
          focusedElements.map((item) => item.cleanLabel),
        )
        sendMessageToTab(targetTab, { type: 'addThought', originalPlan: currentPlan })
        addStepToPlan(nextStep)
        break
    }
    if (sendResponse) sendResponse('completed')
  } catch (error) {
    console.error('Error in processResponse:', error)
    return sendResponse('error')
  }
}
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  processResponse(request, sender, sendResponse)
    .then(() => {
      sendResponse('completed')
    })
    .catch((error) => {
      console.error('Error processing response:', error)
      sendResponse('error')
    })
  return true // Indicate that the response is asynchronous
})

/**
 * Sends a message to a specific tab and retries if necessary.
 * @param {number} tabId - The ID of the tab to send the message to.
 * @param {Object} message - The message to send to the tab.
 */
async function sendMessageToTab(tabId, message) {
  let retries = 3
  await checkTabReady(targetTab)
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
      // processResponse(response)
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
 * @param {function} callback - The callback to execute once the tab is ready.
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
  sendMessageToTab(targetTab, messagePayload)
}

/**
 * Performs a click action on an element identified by a CSS selector.
 * @param {number} tabId - The ID of the tab where the element resides.
 * @param {string} selector - The CSS selector of the element to click.
 */
async function clickElement(tabId, selector) {
  try {
    console.log(selector, 'selector')
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
    completedTask()
  } catch (e) {
    console.log(e, 'e')
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

// --- We only allow content script to execute on tabs created by background script
// Listen for when a tab is closed and remove it from the set
/**
 * Listens for tab removal events and removes the closed tab from the allowedTabs set.
 */
chrome.tabs.onRemoved.addListener(function (tabId) {
  allowedTabs.delete(tabId)
})
