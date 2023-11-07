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
//
function waitForWindowLoad() {
  return new Promise((resolve) => {
    // If the document is already loaded, resolve the promise immediately.
    if (document.readyState === 'complete') {
      resolve()
    } else {
      // Otherwise, attach an event listener for the load event.
      window.addEventListener('load', resolve, { once: true })
    }
  })
}

const executeAction = async (actionName, param1, param2) => {
  debugger;
  console.log("executing action...", actionName);
  switch ((actionName)) {
    case 'NAVURL':
      console.log(`Navigating to URL: ${param1}`)
      window.location.href = param1
      await waitForWindowLoad()
      return
    case 'CLICKBTN':
      console.log(`Clicking button with ID: ${param1}`)
      document.getElementById(param1).click()
      await waitForWindowLoad()
      return
    case 'INPUT':
      console.log(`Inputting text: ${param2} into field with ID: ${param1}`)
      document.getElementById(param1).value = param2
      await waitForWindowLoad()
      return
    case 'SELECT':
      console.log(`Selecting option: ${param2} in field with ID: ${param1}`)
      document.getElementById(param1).value = param2
      await waitForWindowLoad()
      return
    case 'WAITLOAD':
      console.log('Waiting for page to load')
      await waitForWindowLoad()
      console.log('Page is fully loaded')
      return
    case 'ASKUSER':
      console.log(`Asking user the following question: ${param1}`)
      prompt(param1)
      return
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
  sendResponse("complete");
  console.log("completed action")
  chrome.runtime.sendMessage({type: "completed_task"}, function (response) {
    console.log(response)
  })
})
