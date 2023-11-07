console.info('contentScript is running')

// let div = document.createElement('div')
// div.id = 'test-div'
// div.style.position = 'absolute'
// div.style.bottom = '100px'
// div.style.minWidth = '100px'
// div.style.maxWidth = '100px'
// div.style.minHeight = '100px'
// div.style.position = 'sticky'
// div.style.backgroundColor = 'grey'
// document.body.appendChild(div)

const executeAction = async (actionName, param1, param2) => {
  console.log("executing action...", actionName);
  switch ((actionName)) {
    case 'NAVURL':
      console.log(`Navigating to URL: ${param1}`)
      window.location.href = param1
      await new Promise((r) => (window.onload = r))
      break
    case 'CLICKBTN':
      console.log(`Clicking button with ID: ${param1}`)
      document.getElementById(param1).click()
      await new Promise((r) => (window.onload = r))
      break
    case 'INPUT':
      console.log(`Inputting text: ${param2} into field with ID: ${param1}`)
      document.getElementById(param1).value = param2
      await new Promise((r) => (window.onload = r))
      break
    case 'SELECT':
      console.log(`Selecting option: ${param2} in field with ID: ${param1}`)
      document.getElementById(param1).value = param2
      await new Promise((r) => (window.onload = r))
      break
    case 'WAITLOAD':
      console.log('Waiting for page to load')
      await new Promise((r) => (window.onload = r))
      console.log('Page is fully loaded')
      break
    case 'ASKUSER':
      console.log(`Asking user the following question: ${param1}`)
      prompt(param1)
      break
    default:
      console.log('Unknown action: ' + actionName)
  }
}

// chrome.runtime.onMessage.addListener(async (request, sender, sendResponse) => {
//   console.log('Received message:', request.prompt)
//   div.innerText = 'Thinking...'
//   executeAction(request.prompt, request.targetTab)
// })
chrome.runtime.onMessage.addListener(async function (request, sender, sendResponse) {
  console.log(request, "request");
  await executeAction(request.action, request.param, request.inputParam);
  console.log("action executed");
  sendResponse("complete");
})
