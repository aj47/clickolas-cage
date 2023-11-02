import { sendPromptToPlanner } from "../helpers"

console.info('contentScript is running')

let div = document.createElement('div')
div.id = 'test-div'
div.style.position = 'absolute'
div.style.bottom = '100px'
div.style.minWidth = '100px'
div.style.maxWidth = '500px'
div.style.minHeight = '100px'
div.style.position = 'sticky'
div.style.backgroundColor = 'grey'
document.body.appendChild(div)

const executePlan = async (plan) => {
  const actions = plan.split('\n')
  for (let i = 0; i < actions.length; i++) {
    const action = actions[i]
    console.log(action, "action");
    const actionParts = action.split('(')
    const actionParams = actionParts[1]?.slice(0, -1).split(',')
    const keywords = ['NAVURL', 'CLICKBTN', 'INPUT', 'SELECT', 'WAITLOAD', 'ASKUSER']
    const regex = new RegExp(keywords.join('|'), 'g')
    const matches = action.match(regex)
    const actionName = matches[0];

    switch (actionName) {
      case 'NAVURL':
        console.log(`Navigating to URL: ${actionParams[0]}`)
        window.location.href = actionParams[0]
        await new Promise((r) => (window.onload = r))
        break
      case 'CLICKBTN':
        console.log(`Clicking button with ID: ${actionParams[0]}`)
        document.getElementById(actionParams[0]).click()
        await new Promise((r) => (window.onload = r))
        break
      case 'INPUT':
        console.log(`Inputting text: ${actionParams[1]} into field with ID: ${actionParams[0]}`)
        document.getElementById(actionParams[0]).value = actionParams[1]
        await new Promise((r) => (window.onload = r))
        break
      case 'SELECT':
        console.log(`Selecting option: ${actionParams[1]} in field with ID: ${actionParams[0]}`)
        document.getElementById(actionParams[0]).value = actionParams[1]
        await new Promise((r) => (window.onload = r))
        break
      case 'WAITLOAD':
        console.log('Waiting for page to load')
        await new Promise((r) => (window.onload = r))
        console.log('Page is fully loaded')
        break
      case 'ASKUSER':
        console.log(`Asking user the following question: ${actionParams[0]}`)
        prompt(actionParams[0])
        break
      default:
        console.log('Unknown action: ' + actionName)
    }
  }
}

chrome.runtime.onMessage.addListener(async (request, sender, sendResponse) => {
  // This block will handle incoming messages
  console.log('Received message:', request)
  div.innerText = 'Thinking...'
  executePlan(await sendPromptToPlanner(request.prompt))
})
