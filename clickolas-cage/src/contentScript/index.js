import {
  sendMessageToBackgroundScript,
  sendPromptToPlanReviser,
  sendPromptWithFeedback,
} from '../utils'

console.info('contentScript is running')
let originalPlan = ''
let originalPrompt = ''
let currentStep = ''
let currentStepNumber = 0
let newNodes = []
let observer = null
const delayBetweenKeystrokes = 1000

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

async function clickElement(selector) {
  const element = document.querySelector(selector)
  element.click()
  element.dispatchEvent(
    new MouseEvent('mousedown', { bubbles: true, cancelable: true, view: window }),
  )
  element.dispatchEvent(
    new MouseEvent('mouseup', { bubbles: true, cancelable: true, view: window }),
  )
}

/**
 * @function typeText
 * @param {string} text - The string of text to be typed into an HTML element
 * @param {HTMLElement} element - The target HTML element where the text will be typed
 */
async function typeText(text, element) {
  for (const char of text) {
    element.dispatchEvent(
      new KeyboardEvent('KeyEvent', {
        type: 'keydown',
        key: char,
        char: char,
        keyCode: char.charCodeAt(0),
        which: char.charCodeAt(0),
      }),
    )
    element.dispatchEvent(
      new KeyboardEvent('KeyEvent', {
        type: 'keypress',
        key: char,
        char: char,
        keyCode: char.charCodeAt(0),
        which: char.charCodeAt(0),
      }),
    )
    await sleep(delayBetweenKeystrokes / 2)
    element.dispatchEvent(
      new KeyboardEvent('KeyEvent', {
        type: 'keyup',
        key: char,
        char: char,
        keyCode: char.charCodeAt(0),
        which: char.charCodeAt(0),
      }),
    )
    await sleep(delayBetweenKeystrokes / 2)
  }
}

// Callback function to execute when mutations are observed
// gets called every time a node changes
const nodeChangeCallback = function (mutationsList, observer) {
  for (const mutation of mutationsList) {
    if (mutation.type === 'childList' && mutation.addedNodes?.length > 0) {
      newNodes.push({ nodes: mutation.addedNodes, step: currentStepNumber })
      console.log('A child node has been added.')
    }
  }
}

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
// waits minimum 1000ms
function waitForWindowLoad() {
  return new Promise((resolve) => {
    let startTime = Date.now()

    function delayResolve() {
      let elapsedTime = Date.now() - startTime
      let remainingTime = 1000 - elapsedTime
      if (remainingTime > 0) {
        setTimeout(resolve, remainingTime)
      } else {
        resolve()
      }
    }

    if (document.readyState === 'complete') {
      delayResolve()
    } else {
      window.addEventListener('load', delayResolve, { once: true })
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

//Given an initial guess label (likely hallucinated) find the correct selector or update plan
const locateCorrectElement = async (initialLabel) => {
  const clickableElements = []
  // Add all clickable elements in DOM to clickableElements array
  document.querySelectorAll('*').forEach(function (node) {
    if (
      node.tagName === 'BUTTON' ||
      node.tagName === 'INPUT' ||
      node.onclick ||
      (node.hasAttribute('jsaction') &&
        (node.getAttribute('jsaction').includes('click') ||
          node.getAttribute('jsaction').includes('mousedown'))) ||
      node.hasAttribute('onclick') ||
      node.getAttribute('role') === 'button'
    ) {
      clickableElements.push(node)
    }
  })
  const clickableElementLabels = []
  // Construct array of aria-labels and roles for each element
  clickableElements.forEach((e) => {
    let renderedAtStep = 0
    //cringe at this n^3 complexity
    for (const newNode of newNodes) {
      for (const node of newNode.nodes) {
        if (node.contains(e)) renderedAtStep = newNode.step
      }
    }
    clickableElementLabels.push({
      role: e.getAttribute('role') || e.tagName,
      ariaLabel: e.getAttribute('aria-label') || e.innerText,
      renderedAtStep,
    })
  })
  // If an element matches the initialLabel, return the path to the element
  for (const el of clickableElements) {
    if (el.getAttribute('aria-label') === initialLabel || el.innerText === initialLabel) {
      return getPathTo(el)
    }
  }
  // Remove duplicates and empty text elements from the clickableElementLabels array
  const cleanedArray = [
    ...new Set(clickableElementLabels.filter((e) => e.ariaLabel !== '' && e.ariaLabel !== null)),
  ]
  // Send a prompt to the element locator and await the response
  const response = await sendPromptToPlanReviser(
    originalPrompt,
    JSON.stringify(originalPlan),
    JSON.stringify(currentStep),
    JSON.stringify(cleanedArray),
  )
  console.log(response, 'response')
  // Send a message to the background script with the new plan
  sendMessageToBackgroundScript({ type: 'new_plan', data: JSON.parse(response) })
  return false
}

const executeAction = async (actionName, label, param) => {
  console.log('executing action...', actionName)
  let selector = ''
  if (actionName === 'CLICKBTN' && !label) label = param
  if (label && (actionName === 'CLICKBTN' || actionName === 'INPUT' || actionName === 'SELECT')) {
    selector = await locateCorrectElement(label)
    console.log(selector, 'selector')
    if (!selector) return false
  }
  switch (actionName) {
    case 'WAITLOAD':
      await waitForWindowLoad()
      return true
    case 'NAVURL':
      console.log(`Navigating to URL: ${param}`)
      chrome.runtime.sendMessage({ type: 'nav_url', url: param }, function (response) {})
      return true
    case 'CLICKBTN':
      console.log(`Clicking button with label: ${label}`)
      // https://stackoverflow.com/questions/50095952/javascript-trigger-jsaction-from-chrome-console
      clickElement(selector)
      await waitForWindowLoad()
      return true
    case 'INPUT':
      console.log(`Inputting text: ${param} into field with label: ${label}`)
      clickElement(selector)
      await typeText(param, document.querySelector(selector))
      await waitForWindowLoad()
      return true
    case 'SELECT':
      console.log(`Selecting option: ${param} in field with ID: ${label}`)
      document.querySelector(selector).value = param
      await waitForWindowLoad()
      return true
    case 'ASKUSER':
      console.log(`Asking user the following question: ${param}`)
      const answer = prompt(param || label)
      const response = await sendPromptWithFeedback(
        originalPrompt,
        JSON.stringify(originalPlan),
        JSON.stringify(currentStep),
        answer,
      )
      sendMessageToBackgroundScript({ type: 'new_plan', data: JSON.parse(response) })
      return false
    default:
      console.log('Unknown action: ' + actionName)
  }
  return true
}

chrome.runtime.onMessage.addListener(function (request, sender, sendResponse) {
  if (observer === null) {
    // Create an instance of MutationObserver with the callback
    observer = new MutationObserver(nodeChangeCallback)
    // Start observing the the whole dom for changes
    observer.observe(document.documentElement, { attributes: true, childList: true, subtree: true })
  }
  console.log(request, 'request')
  currentStepNumber = request.currentStep
  originalPlan = request.originalPlan
  currentStep = originalPlan[currentStepNumber]
  originalPrompt = request.originalPrompt
  executeAction(currentStep.action, currentStep.ariaLabel, currentStep.param)
    .then((completedAction) => {
      sendResponse('complete')
      console.log('completed action')
      if (completedAction)
        chrome.runtime.sendMessage({ type: 'completed_task' }, function (response) {
          console.log(response)
        })
    })
    .catch((error) => {
      console.error('Error in executeAction:', error)
      sendResponse({ error: error.message })
    })
  return true // This keeps the message channel open
})
