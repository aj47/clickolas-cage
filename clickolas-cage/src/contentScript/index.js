import { sendPromptToElementLocator } from '../helpers'

console.info('contentScript is running')
let originalPlan = ''
let originalPrompt = ''
let currentStep = ''

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

const getPathTo = (element) => {
  if (element.id) return `#${element.id}`;
  if (element === document.body) return element.tagName.toLowerCase();

  const siblings = Array.from(element.parentNode.childNodes).filter(e => e.nodeType === 1);
  const nodeIndex = siblings.indexOf(element);
  const tagName = element.tagName.toLowerCase();
  const nthChild = nodeIndex >= 0 ? `:nth-child(${nodeIndex + 1})` : '';

  return `${getPathTo(element.parentNode)} > ${tagName}${nthChild}`;
};

//Given an initial guess id (likely hallucinated) find the correct selector
const locateCorrectElement = async (initialId) => {
  if (document.getElementById(initialId)) return '#' + initialId
  const clickableElements = document.querySelectorAll('[jsaction]')
  const clickableElementsText = []
  clickableElements.forEach((e) => {
    clickableElementsText.push(e.innerText.slice(0, 10))
  })
  //Removes duplicates and empty text elements
  const cleanedArray = [...new Set(clickableElementsText.filter((e) => e !== ''))]
  const response = await sendPromptToElementLocator(
    originalPrompt,
    JSON.stringify(originalPlan),
    JSON.stringify(currentStep),
    cleanedArray.toString(),
  )
  console.log(response, "response");
  const selectedText = JSON.parse(response).selectedText
  for (const el of clickableElements) {
    console.log(el.innerText.slice(0,10), selectedText);
    if (el.innerText.slice(0,10) === selectedText) {
      console.log(getPathTo(el))
      return getPathTo(el)
    }
  }
}

const executeAction = async (actionName, param1, param2) => {
  console.log('executing action...', actionName)
  switch (actionName) {
    case 'NAVURL':
      console.log(`Navigating to URL: ${param1}`)
      window.location.href = param1
      await waitForWindowLoad()
      return
    case 'CLICKBTN':
      console.log(`Clicking button with ID: ${param1}`)
      document.querySelector(await locateCorrectElement(param1)).click()
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
  console.log(request, 'request')
  currentStep = request.currentStep
  originalPlan = request.originalPlan
  originalPrompt = request.originalPrompt
  await executeAction(currentStep.action, currentStep.param, currentStep.inputParam)
  sendResponse('complete')
  console.log('completed action')
  chrome.runtime.sendMessage({ type: 'completed_task' }, function (response) {
    console.log(response)
  })
})
