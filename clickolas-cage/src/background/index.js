import { sendMessageToContentScript, sendPromptToPlanner } from '../helpers'
console.log('background is running')
console.log('help :(')

let currentPlan = null
let targetTab = null
let currentStep = 0
chrome.runtime.onMessage.addListener(async (request) => {
  // make an event in my google calendar on friday 12pm labeled "hello world"

  if (request.type === 'goal') {
    console.log('received request in background', request.prompt)
    currentPlan = await sendPromptToPlanner(request.prompt)
    console.log(currentPlan, 'currentPlan')
    console.log(typeof currentPlan, 'currentPlan')
    currentPlan = JSON.parse(currentPlan)
    console.log(currentPlan, 'currentPlan')
    currentPlan = currentPlan.plan
    // Assumed first step is always NAVURL,
    // TODO: handle the case where it isn't
    console.log(currentStep, "currentStep");
    console.log("navigate to URL: ", currentPlan[currentStep].param)
    chrome.tabs.create({ url: currentPlan[currentStep].param }, async function (tab) {
      targetTab = tab.id // Store the tab ID for later use
      currentStep++
      // await sendMessageToTab(targetTab, currentPlan[currentStep])
      // Check if the tab is completely loaded before sending a message
      checkTabReady(targetTab, async function () {
        console.log(targetTab, 'targetTab')
        console.log(currentPlan[currentStep], 'currentPlan[currentStep]')
        await sendMessageToTab(targetTab, currentPlan[currentStep])
        currentStep++
      })
    })
    // let { actionName, actionParams, currentTask, currentStep } = getNextAction(currentPlan, currentStep)
    // console.log({ actionName, actionParams, currentTask, currentStep })
    // }
  }
  return true
})

async function sendMessageToTab(tabId, message) {
  try {
    const response = await new Promise((resolve, reject) => {
      chrome.tabs.sendMessage(tabId, message, function (response) {
        if (chrome.runtime.lastError) {
          reject(new Error(chrome.runtime.lastError.message))
        } else {
          resolve(response)
        }
      })
    })
    console.log('Received response:', response)
  } catch (error) {
    console.error('Error in sending message:', error)
  }
}

function checkTabReady(tabId, callback) {
  chrome.tabs.onUpdated.addListener(function listener(tabIdUpdated, changeInfo, tab) {
    if (tabIdUpdated === tabId && changeInfo.status === 'complete') {
      // Remove the listener after we found the right tab and it has finished loading
      chrome.tabs.onUpdated.removeListener(listener)
      callback(tab)
    }
  })
}
