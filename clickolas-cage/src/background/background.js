import {
  checkCandidatePrompts,
  getDomain,
  promptToFirstStep,
  sendMessageToContentScript,
  sendPromptToPlanner,
} from '../utils'
console.log('background is running')

let currentPlan = []
let targetTab = null
let currentStep = 0
let originalPrompt = ''
let currentURL = ''
let recipes = null

fetch(chrome.runtime.getURL('src/recipes.json'))
  .then((response) => response.json()) // parse the JSON from the response
  .then((jsonData) => {
    recipes = jsonData
  })
  .catch((error) => {
    console.error('Error:', error)
  })

const navURL = (url) => {
  console.log(url, 'url')
  currentURL = url
  chrome.tabs.create({ url: url }, async function (tab) {
    targetTab = tab.id // Store the tab ID for later use
    currentStep++
    // Check if the tab is completely loaded before sending a message
    checkTabReady(targetTab, async function () {
      chrome.tabs.query({ active: true, currentWindow: true }, ([tab]) => {
        chrome.sidePanel.open({ tabId: targetTab })
      })
      console.log('tab ready')
      if (currentStep >= currentPlan.length) {
        const recipeCandidates = recipes[getDomain(url)]
        let matchingRecipe = null
        if (recipeCandidates) {
          const responseJSON = await checkCandidatePrompts(
            originalPrompt,
            Object.keys(recipeCandidates),
          )
          matchingRecipe = recipeCandidates[responseJSON.match]
          console.log(matchingRecipe, 'matchingRecipe')
        }
        const responseJSON = await sendPromptToPlanner(originalPrompt, url, matchingRecipe)
        currentPlan = responseJSON.plan
        currentStep = 1
      }
      const messagePayload = {
        currentStep: currentStep - 1,
        originalPlan: currentPlan,
        originalPrompt,
      }
      await sendMessageToTab(targetTab, messagePayload)
    })
  })
}

// const retryTask = () => {
//   const messagePayload = {
//     currentStep: currentStep - 1,
//     originalPlan: currentPlan,
//     originalPrompt,
//   }
//   sendMessageToTab(targetTab, messagePayload)
// }

const completedTask = () => {
  console.log('inside completed task')
  console.log(targetTab, 'targetTab')
  console.log(currentPlan[currentStep], 'currentPlan[currentStep]')
  if (currentStep >= currentPlan.length) {
    console.log('plan complete.')
    return
  }
  currentStep++
  const messagePayload = {
    currentStep: currentStep - 1,
    originalPlan: currentPlan,
    originalPrompt,
  }
  sendMessageToTab(targetTab, messagePayload)
}

chrome.runtime.onMessage.addListener((request) => {
  // make an event in my google calendar on friday 12pm labeled "hello world"
  if (request.type === 'new_plan') {
    console.log('new plan received')
    currentPlan = request.data.plan
    currentStep = 1
    const messagePayload = {
      currentStep: 0,
      originalPlan: currentPlan,
      originalPrompt,
    }
    sendMessageToTab(targetTab, messagePayload)
  } else if (request.type === 'nav_url') {
    navURL(request.url)
  } else if (request.type === 'completed_task') {
    completedTask()
  } else if (request.type === 'goal') {
    currentStep = 0
    console.log(JSON.stringify(request))
    console.log('received request in background', request.prompt)
    originalPrompt = request.prompt
    promptToFirstStep(request.prompt).then((responseJSON) => {
      console.log(responseJSON, 'response')
      responseJSON.action = 'NAVURL'
      if (responseJSON.action === 'NAVURL') navURL(responseJSON.param)
      else if (responseJSON.action === 'ASKUSER') alert('TODO: Handle ASKUSER')
    })
  } else if (request.type === 'click_element') {
    clickElement(targetTab, request.selector)
  }
  return true
})

async function sendMessageToTab(tabId, message) {
  let retries = 3
  while (retries > 0) {
    try {
      const response = await new Promise((resolve, reject) => {
        console.log('sending message')
        chrome.tabs.sendMessage(tabId, message, function (response) {
          if (chrome.runtime.lastError) {
            reject(new Error(chrome.runtime.lastError.message))
          } else {
            resolve(response)
          }
        })
      })
      console.log('Received response:', response)
      return
    } catch (error) {
      console.error('Error in sending message:', error)
      retries--
      if (retries === 0) throw error
      await new Promise((resolve) => setTimeout(resolve, 1000)) // Wait a bit before retrying
    }
  }
}

function checkTabReady(tabId, callback) {
  console.log('waiting tab ready...')
  chrome.tabs.onUpdated.addListener(function listener(tabIdUpdated, changeInfo, tab) {
    if (tabIdUpdated === tabId && changeInfo.status === 'complete') {
      // Remove the listener after we found the right tab and it has finished loading
      chrome.tabs.onUpdated.removeListener(listener)
      callback(tab)
    }
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

async function callElementClick(tabId, nodeId) {
  return new Promise((resolve, reject) => {
    chrome.debugger.sendCommand({ tabId }, 'DOM.resolveNode', { nodeId }, ({ object }) => {
      chrome.debugger.sendCommand(
        { tabId },
        'Runtime.callFunctionOn',
        {
          functionDeclaration: 'function() { this.click(); }',
          objectId: object.objectId,
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
  })
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

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

    // await callElementClick(tabId, nodeId)
    await clickElementAt(tabId, x, y)
    chrome.debugger.detach({ tabId })
    await sleep(2000)
    completedTask()
  } catch (e) {
    console.log(e, 'e')
  }
}
