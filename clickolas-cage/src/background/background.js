import { sendMessageToContentScript, sleep } from '../utils'

import { getNextStepFromLLM, promptToFirstStep } from '../llm-utils'

chrome.storage.local.set({ logs: [] })

let state = {
  currentPlan: [],
  targetTab: null,
  currentStep: 0,
  originalPrompt: '',
  currentURL: '',
  allowedTabs: new Set(),
  focusedElements: [],
}

const getState = () => ({ ...state })

const updateState = (newState) => {
  state = { ...state, ...newState }
}

const navURL = (url) => {
  updateState({ currentURL: url })
  if (url.indexOf('http') !== 0) {
    url = 'http://' + url
  }
  return new Promise((resolve, reject) => {
    chrome.tabs.create({ url: url }, (tab) => {
      if (chrome.runtime.lastError) {
        reject(new Error(chrome.runtime.lastError))
      } else {
        const newAllowedTabs = new Set(getState().allowedTabs)
        newAllowedTabs.add(tab.id)
        updateState({
          allowedTabs: newAllowedTabs,
          targetTab: tab.id,
        })
        resolve(tab)
      }
    })
  })
}

const completedTask = async () => {
  const currentState = getState()
  updateState({ currentStep: currentState.currentStep + 1 })
  await sleep(3000)
  const updatedState = getState()
  if (updatedState.currentStep >= updatedState.currentPlan.length) {
    sendMessageToTab(updatedState.targetTab, {
      type: 'generateNextStep',
      currentStep: updatedState.currentStep,
      plan: updatedState.currentPlan,
    })
  } else {
    await executeCurrentStep()
  }
}

const addStepToPlan = (step) => {
  const currentState = getState()
  const newPlan = [...currentState.currentPlan, step]
  updateState({ currentPlan: newPlan })
  executeCurrentStep()
}

const executeCurrentStep = async () => {
  const currentState = getState()
  try {
    const currentAction = currentState.currentPlan[currentState.currentStep]
    if (!currentAction) {
      return
    }
    if (currentAction.action === 'NAVURL') {
      await navURL(currentAction.param)
      await completedTask()
    } else if (currentAction.action === 'CLICKBTN') {
      await sendMessageToTab(currentState.targetTab, {
        type: 'locateElement',
        ariaLabel: currentAction.ariaLabel,
        plan: currentState.currentPlan,
        currentStep: currentState.currentStep,
      })
    } else if (currentAction.action === 'ASKUSER') {
    } else {
    }
  } catch (error) {
  }
}

const processResponse = async (request, sender, sendResponse) => {
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
        })
        const responseJSON = await promptToFirstStep(request.prompt)
        responseJSON.action = 'NAVURL'
        addStepToPlan(responseJSON)
        break
      case 'click_element':
        clickElement(state.targetTab, request.selector)
        break
      case 'press_tab_key':
        await pressTabKey(state.targetTab)
        break
      case 'new_focused_element':
        updateState({
          focusedElements: [...state.focusedElements, request.element],
        })
        break
      case 'next_step_with_elements':
        if (currentState.currentStep < currentState.currentPlan.length) {
          await executeCurrentStep()
        } else {
          const nextStepWithElements = await getNextStepFromLLM(
            currentState.originalPrompt,
            currentState.currentURL,
            currentState.currentPlan,
            currentState.currentStep,
            request.elements,
          )
          addStepToPlan(nextStepWithElements)
        }
        break
      case 'next_step':
        const nextStepData = await getNextStepFromLLM(
          state.originalPrompt,
          state.currentURL,
          state.currentPlan,
          state.currentStep,
          state.focusedElements.map((item) => item.cleanLabel),
        )
        sendMessageToTab(state.targetTab, {
          type: 'updatePlan',
          plan: state.currentPlan,
          currentStep: state.currentStep
        })
        addStepToPlan(nextStepData)
        break
    }
    if (sendResponse) sendResponse('completed')
  } catch (error) {
    return sendResponse('error')
  }
}
chrome.runtime.onMessage.addListener((request, sender, sendResponse) => {
  processResponse(request, sender, sendResponse)
    .then(() => {
      sendResponse('completed')
    })
    .catch((error) => {
      sendResponse('error')
    })
  return true
})

async function sendMessageToTab(tabId, message) {
  let retries = 3
  const currentState = getState()
  await checkTabReady(currentState.targetTab)
  while (retries > 0) {
    try {
      await new Promise((resolve, reject) => {
        chrome.tabs.sendMessage(tabId, message, function (response) {
          if (chrome.runtime.lastError) {
            reject(new Error(chrome.runtime.lastError.message))
          } else {
            processResponse(response)
            resolve(response)
          }
        })
      })
      return
    } catch (error) {
      retries--
      if (retries === 0) throw error
      await new Promise((resolve) => setTimeout(resolve, 1000))
    }
  }
}

function checkTabReady(tabId) {
  return new Promise((resolve, reject) => {
    chrome.tabs.sendMessage(tabId, { type: 'ping' }, function (response) {
      if (chrome.runtime.lastError) {
        setTimeout(() => checkTabReady(tabId).then(resolve).catch(reject), 1000)
      } else {
        resolve('complete')
      }
    })
  })
}

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

async function clickElement(tabId, selector) {
  try {
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
  }
}

async function pressTabKey(tabId) {
  try {
    await attachDebugger(tabId)
    await dispatchTabKeyPress(tabId)
    chrome.debugger.detach({ tabId })
  } catch (e) {
  }
}

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

chrome.tabs.onRemoved.addListener(function (tabId) {
  const currentState = getState()
  const newAllowedTabs = new Set(currentState.allowedTabs)
  newAllowedTabs.delete(tabId)
  updateState({ allowedTabs: newAllowedTabs })
})
