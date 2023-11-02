import { getNextAction, sendMessageToContentScript, sendPromptToPlanner } from '../helpers'
console.log('background is running')
console.log('help :(')

let currentPlan = null
let targetTab = null
chrome.runtime.onMessage.addListener(async (request) => {
  if (request.type === 'goal') {
    console.log('received request in background', request.prompt)
    currentPlan = await sendPromptToPlanner(request.prompt)
    console.log(currentPlan, 'currentPlan')
    let { actionName, actionParams, currentTask } = getNextAction(currentPlan, [0])
    console.log({ actionName, actionParams, currentTask })
    if (actionName === 'NAVURL') {
      chrome.tabs.create(
        { url: actionParams[0].replaceAll("'", '').replaceAll('"', '') },
        function (tab) {
          targetTab = tab.id // Store the tab ID for later use
        },
      )
      currentTask = currentPlan.split('\n')[1]
    }
    if (currentTask) sendMessageToContentScript({ type: 'action', prompt: currentTask })
  }
  return true
})
