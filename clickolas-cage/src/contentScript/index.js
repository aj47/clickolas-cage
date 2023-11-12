import { sendMessageToBackgroundScript, sendPromptToElementLocator, sendPromptWithFeedback } from '../utils'

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
  if (element.id) return `#${element.id}`
  if (element === document.body) return element.tagName.toLowerCase()

  const siblings = Array.from(element.parentNode.childNodes).filter((e) => e.nodeType === 1)
  const nodeIndex = siblings.indexOf(element)
  const tagName = element.tagName.toLowerCase()
  const nthChild = nodeIndex >= 0 ? `:nth-child(${nodeIndex + 1})` : ''
  return `${getPathTo(element.parentNode)} > ${tagName}${nthChild}`
}

//Given an initial guess id (likely hallucinated) find the correct selector
const locateCorrectElement = async (initialLabel) => {
  // if (document.getElementById(initialId)) return '#' + initialId
  // const clickableElements = document.querySelectorAll('[jsaction]')
  const clickableElements = []
  document.querySelectorAll('*').forEach(function (node) {
    if (
      node.tagName === 'BUTTON' ||
      node.onclick ||
      node.hasAttribute('jsaction') ||
      node.hasAttribute('onclick') ||
      node.getAttribute('role') === 'button'
    ) {
      clickableElements.push(node)
      // console.log(node, 'ARIA Label:', node.getAttribute('aria-label'))
    }
  })
  const clickableElementLabels = []
  clickableElements.forEach((e) => {
    clickableElementLabels.push(e.getAttribute('aria-label'))
  })
  for (const el of clickableElements) {
    if (el.getAttribute('aria-label') === initialLabel) {
      return getPathTo(el)
    }
  }
  //Removes duplicates and empty text elements
  // const cleanedArray = [...new Set(clickableElementsText.filter((e) => e !== ''))]
  const response = await sendPromptToElementLocator(
    originalPrompt,
    JSON.stringify(originalPlan),
    JSON.stringify(currentStep),
    clickableElementLabels.toString(),
  )
  console.log(response, 'response')
  sendMessageToBackgroundScript({ type: 'new_plan', data: JSON.parse(response) })
  // const selectedText = JSON.parse(response).selectedText
  // for (const el of clickableElements) {
  //   console.log(el.innerText.slice(0, 10), selectedText)
  //   if (el.innerText.slice(0, 10) === selectedText) {
  //     console.log(getPathTo(el))
  //     return getPathTo(el)
  //   }
  // }
  return false
}

const executeAction = async (actionName, label, param) => {
  console.log('executing action...', actionName)
  debugger;
  let selector = ''
  if (actionName === 'CLICKBTN' && !label) label = param
  if (label) {
    selector = await locateCorrectElement(label)
    console.log(selector, 'selector')
    if (!selector) return
  }

  switch (actionName) {
    case 'NAVURL':
      console.log(`Navigating to URL: ${param}`)
      window.location.href = param
      await waitForWindowLoad()
      return
    case 'CLICKBTN':
      console.log(`Clicking button with label: ${label}`)
      document.querySelector(selector).click()
      await waitForWindowLoad()
      return
    case 'INPUT':
      console.log(`Inputting text: ${param} into field with label: ${label}`)
      document.querySelector(selector).value = param
      await waitForWindowLoad()
      return
    case 'SELECT':
      console.log(`Selecting option: ${param} in field with ID: ${label}`)
      document.querySelector(selector).value = param
      await waitForWindowLoad()
      return
    case 'WAITLOAD':
      console.log('Waiting for page to load')
      await waitForWindowLoad()
      console.log('Page is fully loaded')
      return
    case 'ASKUSER':
      console.log(`Asking user the following question: ${param}`)
      const answer = prompt(param)
      const response = await sendPromptWithFeedback(
        originalPrompt,
        JSON.stringify(originalPlan),
        JSON.stringify(currentStep),
        answer,
      )
      sendMessageToBackgroundScript({ type: 'new_plan', data: JSON.parse(response) })
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
  await executeAction(currentStep.action, currentStep.ariaLabel, currentStep.param)
  sendResponse('complete')
  console.log('completed action')
  chrome.runtime.sendMessage({ type: 'completed_task' }, function (response) {
    console.log(response)
  })
})
