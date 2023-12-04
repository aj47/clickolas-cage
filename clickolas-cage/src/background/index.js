import {
  checkCandidatePrompts,
  getDomain,
  promptToFirstStep,
  sendMessageToContentScript,
  sendPromptToPlanner,
  sendPromptToPlanner2,
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
        const responseJSON = await sendPromptToPlanner2(originalPrompt, url, matchingRecipe)
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
  } else if (request.type === 'goal') {
    currentStep = 0
    console.log(JSON.stringify(request))
    console.log('received request in background', request.prompt)
    originalPrompt = request.prompt
    promptToFirstStep(request.prompt).then((responseJSON) => {
      console.log(responseJSON, 'response')
      if (responseJSON.action === 'NAVURL') navURL(responseJSON.param)
      else if (responseJSON.action === 'ASKUSER') alert('TODO: Handle ASKUSER')
    })
  } else if (request.type === 'click_element') {
    clickElementEvent(request.selector)
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

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

// This function would be part of your background script
async function dispatchMouseEventCDP(x, y, clickCount) {
  console.log(x, 'x')
  console.log(y, 'y')
  for (let i = 0; i < clickCount; i++) {
    // Example of how you might send a command to CDP
    chrome.debugger.attach({ tabId: targetTab }, '1.3', async () => {
      chrome.debugger.sendCommand({ tabId: targetTab }, 'Input.dispatchMouseEvent', {
        type: 'mousedown',
        x,
        y,
        button: 'left',
        clickCount,
      })
      await sleep(300) // Wait between clicks
      chrome.debugger.sendCommand({ tabId: targetTab }, 'Input.dispatchMouseEvent', {
        type: 'mouseup',
        x,
        y,
        button: 'left',
        clickCount,
      })
      // Detach the debugger after the operation
      chrome.debugger.detach({ tabId: targetTab }, () => {})
    })

    await sleep(800) // Wait between clicks
  }
}

async function clickElementEvent(selector, clickCount) {
  chrome.debugger.attach({ tabId: targetTab }, '1.3', () => {
    if (chrome.runtime.lastError) {
      console.error('Error attaching debugger:', chrome.runtime.lastError.message)
    }
    chrome.debugger.sendCommand({ tabId: targetTab }, 'DOM.getDocument', {}, (doc) => {
      if (chrome.runtime.lastError) {
        console.error('Error getting document:', chrome.runtime.lastError.message)
      }
      chrome.debugger.sendCommand(
        { tabId: targetTab },
        'DOM.querySelector',
        {
          nodeId: doc.root.nodeId,
          selector: selector,
        },
        (result) => {
          if (chrome.runtime.lastError) {
            console.error('Error querying selector:', chrome.runtime.lastError.message)
          }
          chrome.debugger.sendCommand(
            { tabId: targetTab },
            'DOM.getBoxModel',
            {
              nodeId: result.nodeId,
            },
            (boxModel) => {
              if (chrome.runtime.lastError) {
                console.error('Error getting box model:', chrome.runtime.lastError.message)
                reject(chrome.runtime.lastError.message)
              }
              const [x1, y1, x2, y2, x3, y3, x4, y4] = boxModel.model.border
              const x = (x1 + x3) / 2
              const y = (y1 + y3) / 2
              chrome.debugger.detach({ tabId: targetTab }, () => {})
              dispatchMouseEventCDP(x, y, clickCount)
            },
          )
        },
      )
    })
  })
}
