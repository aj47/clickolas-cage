import {
  getDomain,
  sendMessageToContentScript,
  sleep,
} from '../utils'

import {
  checkCandidatePrompts,
  getNextStepFromLLM,
  promptToFirstStep,
  sendPromptToPlanner,
} from '../llm-utils'

console.log('background is running')

let currentPlan = []
let targetTab = null
let currentStep = 0
let originalPrompt = ''
let currentURL = ''
let allowedTabs = new Set()
let focusedElements = []

const askUserConfirmation = async () => {
  return new Promise((resolve) => {
    chrome.tabs.sendMessage(targetTab, { type: 'askUserConfirmation' }, (response) => {
      resolve(response.confirmation);
    });
  });
};

const navURL = (url) => {
  console.log(url, 'url')
  currentURL = url
  if (url.indexOf('http') !== 0) {
    url = 'http://' + url
  }
  return new Promise((resolve, reject) => {
    chrome.tabs.create({ url: url }, (tab) => {
      if (chrome.runtime.lastError) {
        reject(new Error(chrome.runtime.lastError))
      } else {
        allowedTabs.add(tab.id)
        targetTab = tab.id
        resolve(tab)
      }
    })
  })
}

const completedTask = async () => {
  if (currentStep >= currentPlan.length) {
    console.log('plan complete.')
    return
  }
  const userConfirmed = await askUserConfirmation();
  if (userConfirmed) {
    currentStep++
    const messagePayload = {
      currentStep: currentStep - 1,
      originalPlan: currentPlan,
      originalPrompt,
    }
    sendMessageToTab(targetTab, messagePayload)
  } else {
    console.log('User did not confirm task completion. Retrying...');
    // Optionally, implement retry logic here
  }
}

const addStepToPlan = (step) => {
  currentPlan.push(step)
  executeCurrentStep()
}

const executeCurrentStep = async () => {
  console.log('inside execute current step')
  if (currentPlan[currentStep].action === 'NAVURL') {
    await navURL(currentPlan[currentStep].param)
  } else if (currentPlan[currentStep].action === 'CLICKBTN') {
    sendMessageToTab(targetTab, {
      type: 'clickElement',
      ariaLabel: currentPlan[currentStep].ariaLabel,
    })
  } else if (currentPlan[currentStep].action === 'ASKUSER') {
  }
  currentStep++
  getNextStep()
}

const getNextStep = () => {
  console.log('inside next step ting')
  console.log(targetTab, 'targetTab')
  checkTabReady(targetTab, async function () {
    console.log('sending message to generate next step')
    const messagePayload = {
      type: 'generateNextStep',
      currentStep: currentStep - 1,
      originalPlan: currentPlan,
      originalPrompt,
    }
    await sendMessageToTab(targetTab, messagePayload)
  })
}

chrome.runtime.onMessage.addListener(processResponse)

async function sendMessageToTab(tabId, message) {
  let retries = 3
  while (retries > 0) {
    try {
      const response = await new Promise((resolve, reject) => {
        console.log('sending message', message)
        chrome.tabs.sendMessage(tabId, message, function (response) {
          if (chrome.runtime.lastError) {
            reject(new Error(chrome.runtime.lastError.message))
          } else {
            resolve(response)
          }
        })
      })
      return
    } catch (error) {
      console.error('Error in sending message:', error)
      retries--
      if (retries === 0) throw error
      await new Promise((resolve) => setTimeout(resolve, 1000))
    }
  }
}

function checkTabReady(tabId, callback) {
  console.log('waiting tab ready...')
  chrome.tabs.onUpdated.addListener(function listener(tabIdUpdated, changeInfo, tab) {
    if (tabIdUpdated === tabId && changeInfo.status === 'complete') {
      chrome.tabs.onUpdated.removeListener(listener)
      console.log('tab ready')
      callback(tab)
    }
  })
}

chrome.tabs.onRemoved.addListener(function (tabId) {
  allowedTabs.delete(tabId)
})
