import { getNextAction, sendMessageToContentScript, sendPromptToPlanner } from '../helpers'
console.log('background is running')
console.log('help :(')

let currentPlan = null
let targetTab = null
let currentStep = 0
chrome.runtime.onMessage.addListener(async (request) => {
  if (request.type === 'goal') {
    console.log('received request in background', request.prompt)
    currentPlan = await sendPromptToPlanner(request.prompt)
    console.log(currentPlan, 'currentPlan')
    let { actionName, actionParams, currentTask, currentStep } = getNextAction(currentPlan, currentStep)
    console.log({ actionName, actionParams, currentTask, currentStep })
    if (actionName === 'NAVURL') {
      chrome.tabs.create(
        { url: actionParams[0].replaceAll("'", '').replaceAll('"', '') },
        function (tab) {
          targetTab = tab.id // Store the tab ID for later use
        },
      )
    }
  }
  return true
})

const loopOnPlan = () => {
  while (getNextAction(currentPlan, currentStep) !== null) {
    let { actionName, actionParams, currentTask, currentStep } = getNextAction(currentPlan, currentStep)
    sendMessageToContentScript({ type: 'action', prompt: currentTask })
  }
}
