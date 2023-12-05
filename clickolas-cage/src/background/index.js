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
