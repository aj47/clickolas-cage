import { useState, useEffect } from 'react'

import {
  sendMessageToBackgroundScript,
  sendPromptToPlanReviser,
  sendPromptWithFeedback,
} from '../utils'

import './SidePanel.css'
export const SidePanel = () => {
  const [originalPlan, setOriginalPlan] = useState([])
  const [currentStep, setCurrentStep] = useState(null)
  const [currentStepNumber, setCurrentStepNumber] = useState(0)
  const [originalPrompt, setOriginalPrompt] = useState('')

  console.info('contentScript is running')
  let newNodes = []
  let observer = null
  const delayBetweenKeystrokes = 100

  function sleep(ms) {
    return new Promise((resolve) => setTimeout(resolve, ms))
  }

  async function clickElement(selector) {
    sendMessageToBackgroundScript({ type: 'click_element', selector })
  }

  /**
   * @function typeText
   * @param {string} text - The string of text to be typed into an HTML element
   * @param {HTMLElement} element - The target HTML element where the text will be typed
   */
  async function typeText(text, element) {
    return new Promise(async (resolve) => {
      element.focus() // Ensure the element has focus before typing

      for (const char of text) {
        const charCode = char.charCodeAt(0)
        const eventInitDict = {
          key: char,
          char: char,
          keyCode: charCode,
          which: charCode,
          shiftKey: false,
          ctrlKey: false,
          altKey: false,
          metaKey: false,
        }

        element.dispatchEvent(new KeyboardEvent('keydown', eventInitDict))
        element.dispatchEvent(new KeyboardEvent('keypress', eventInitDict))
        element.value += char
        element.dispatchEvent(
          new InputEvent('input', { inputType: 'insertText', ...eventInitDict }),
        )
        element.dispatchEvent(new KeyboardEvent('keyup', eventInitDict))

        await sleep(delayBetweenKeystrokes)
      }
      resolve()
    })
  }

  // Callback function to execute when mutations are observed
  // gets called every time a node changes
  // const nodeChangeCallback = function (mutationsList, observer) {
  //   for (const mutation of mutationsList) {
  //     if (mutation.type === 'childList' && mutation.addedNodes?.length > 0) {
  //       newNodes.push({ nodes: mutation.addedNodes, step: currentStepNumber })
  //       console.log('A child node has been added.')
  //     }
  //   }
  // }

  async function createSquareAtLocation(x, y) {
    console.log(x, 'x')
    console.log(y, 'y')
    // Create a div element
    let square = document.createElement('div')

    // Set its position and size
    square.style.position = 'absolute'
    square.style.left = x - 25 + 'px'
    square.style.top = y - 25 + 'px'
    square.style.width = '50px'
    square.style.height = '50px'
    square.style.zIndex = '9999'

    // Set its color to red
    square.style.backgroundColor = 'red'

    // Append it to the body of the document
    document.body.appendChild(square)
  }

  /**
   * Waits for the document to load or until 2000ms have passed since the start.
   * @returns {Promise<void>} A promise that resolves when the window is loaded or after 2000ms, whichever comes first.
   */
  function waitForWindowLoad() {
    return new Promise((resolve) => {
      let startTime = Date.now()

      function delayResolve() {
        let elapsedTime = Date.now() - startTime
        let remainingTime = 2000 - elapsedTime
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

  /**
   * Gets the CSS query path to an element relative to its parent nodes.
   * @param {HTMLElement} element - The HTML element for which you want to get the path.
   * @returns {string} A string representing the path of the element from the document root.
   */
  const getPathTo = (element) => {
    if (element.id) return `#${element.id}`
    if (element === document.body) return element.tagName.toLowerCase()

    const siblings = Array.from(element.parentNode.childNodes).filter((e) => e.nodeType === 1)
    const nodeIndex = siblings.indexOf(element)
    const tagName = element.tagName.toLowerCase()
    const nthChild = nodeIndex >= 0 ? `:nth-child(${nodeIndex + 1})` : ''
    return `${getPathTo(element.parentNode)} > ${tagName}${nthChild}`
  }

  /**
   * Locates the correct element based on an initial label. If it finds a matching element, \
   * it returns its path; otherwise, it logs an error message and returns false.
   * @param {string} initialLabel - The initial guess of the element's label.
   * @returns {Promise<Array<HTMLElement>|boolean>} A promise that resolves to either an array of paths or false, \
   * depending on whether it finds a matching element.
   */
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
    let returnEl = null
    // If an element matches the initialLabel, return the path to the element
    for (const el of clickableElements) {
      if (el.getAttribute('aria-label') === initialLabel || el.innerText === initialLabel) {
        console.log(el)
        const boundingBox = el.getBoundingClientRect()
        if (boundingBox && boundingBox.x !== 0 && boundingBox.y !== 0) returnEl = getPathTo(el)
      }
    }
    if (returnEl) return returnEl
    else console.log('NO ELEMENT FOUND :(')
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
    sendMessageToBackgroundScript({ type: 'new_plan', data: response })
    return false
  }

  const executeAction = async (actionName, label, param) => {
    console.log('executing action...', actionName)
    let selector = ''
    if (actionName === 'CLICKBTN' && !label) label = param
    if (label && (actionName === 'CLICKBTN' || actionName === 'INPUT' || actionName === 'SELECT')) {
      console.log(label, 'aria-label')
      selector = await locateCorrectElement(label)
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
        return false
      case 'INPUT':
        console.log(`Inputting text: ${param} into field with label: ${label}`)
        console.log('Input selector: ', selector)
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
    // if (observer === null) {
    //   // Create an instance of MutationObserver with the callback
    //   observer = new MutationObserver(nodeChangeCallback)
    //   // Start observing the the whole dom for changes
    //   observer.observe(document.documentElement, {
    //     attributes: true,
    //     childList: true,
    //     subtree: true,
    //   })
    // }
    if (request.type === 'showClick') {
      createSquareAtLocation(request.x, request.y)
      return
    }
    debugger
    console.log(request, 'request')
    setCurrentStepNumber(request.currentStep)
    // document.querySelector('#thoughts-panel').innerText = processPlanText(originalPlan)
    setOriginalPlan(request.originalPlan)
    console.log(originalPlan, 'originalPlan')
    setCurrentStep(request.originalPlan[request.currentStep])
    setOriginalPrompt(request.originalPrompt)
    console.log(currentStep, 'currentStep')
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

  return (
    <div className="sidePanel">
      {originalPlan.length > 0 && (
        <div className="plan">
          <h2>Clickolas Plan: </h2>
          <ul>
            {originalPlan.map((step, i) => {
              return (
                <div className="step" key={i}>
                  {i + 1} - {step.thought}
                </div>
              )
            })}
          </ul>
        </div>
      )}
    </div>
  )
}

export default SidePanel
