import { useState, useEffect, useRef } from 'react'

import { runFunctionXTimesWithDelay, sendMessageToBackgroundScript, sleep } from '../utils'

import { sendPromptWithFeedback } from '../llm-utils'

import './SidePanel.css'
export const SidePanel = () => {
  const [originalPlan, setOriginalPlan] = useState([])
  const [currentStep, setCurrentStep] = useState(0)
  const socketRef = useRef(null)

  const delayBetweenKeystrokes = 100

  /**
   * Simulates typing text into a given HTML element
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

  /**
   * Creates a square at the given location. The x and y parameters are in pixel values.
   * Used for showing where clickolas has clicked.
   * @param {number} x - The x-coordinate of the top left corner of the square.
   * @param {number} y - The y-coordinate of the top left corner of the square.
   */
  async function createSquareAtLocation(x, y) {
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
    square.style.opacity = 0.5

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

  const getClickableElements = () => {
    const clickableElements = []
    // Add all clickable elements in DOM to clickableElements array
    document.querySelectorAll('*').forEach(function (node) {
      if (  node.tagName !== 'BODY' &&
        node.tagName === 'BUTTON' ||
        node.tagName === 'INPUT' ||
        node.onclick ||
        (node.hasAttribute('jsaction') &&
          (node.getAttribute('jsaction').includes('click') ||
            node.getAttribute('jsaction').includes('mousedown'))) ||
        node.hasAttribute('onclick') ||
        (node.getAttribute('role') === 'button')
      ) {
        clickableElements.push(node)
      }
    })
    const clickableElementLabels = []
    // Construct array of aria-labels and roles for each element
    clickableElements.forEach((e) => {
      // let renderedAtStep = 0
      //cringe at this n^3 complexity
      // for (const newNode of newNodes) {
      //   for (const node of newNode.nodes) {
      //     if (node.contains(e)) renderedAtStep = newNode.step
      //   }
      // }
      clickableElementLabels.push({
        role: e.getAttribute('role') || e.tagName,
        ariaLabel: e.getAttribute('aria-label') || e.innerText,
        // renderedAtStep,
      })
    })
    const cleanedArray = [
      ...new Set(clickableElementLabels.filter((e) => e.ariaLabel !== '' && e.ariaLabel !== null)),
    ]
    return { clickableElements, clickableElementLabels: cleanedArray }
  }

  /**
   * Locates the correct element based on an initial label. If it finds a matching element, \
   * it returns its path; otherwise, it logs an error message and returns false.
   * @param {string} initialLabel - The initial guess of the element's label.
   * @returns {Promise<Array<HTMLElement>|boolean>} A promise that resolves to either an array of paths or false, \
   * depending on whether it finds a matching element.
   */
  const locateCorrectElement = (initialLabel) => {
    console.log('looking for element:', initialLabel)
    const { clickableElements, clickableElementLabels } = getClickableElements()
    let returnEl = null
    // If an element matches the initialLabel, return the path to the element
    for (const el of clickableElements) {
      // console.log(el.getAttribute('aria-label'), el.innerText, "e.getAttribute(ari");
      if (el.getAttribute('aria-label') === initialLabel || el.innerText === initialLabel) {
        console.log('LOCATED ELEMENT: ')
        console.log(el)
        const boundingBox = el.getBoundingClientRect()
        if (boundingBox && boundingBox.x !== 0 && boundingBox.y !== 0) returnEl = getPathTo(el)
      }
    }
    if (returnEl) return returnEl
    else console.log('NO ELEMENT FOUND :(')
    return false
  }

  /**
   * Sends a message to the background script to press the Tab key.
   */
  const pressTabInTab = () => {
    sendMessageToBackgroundScript({ type: 'press_tab_key' })
  }
  // Function to get the text of the currently focused element or its accessible name
  const logFocusedElement = async () => {
    return new Promise((resolve, reject) => {
      try {
        const focusedElementObj = { element: document.activeElement } // Get the currently focused element

        if (focusedElementObj.element && focusedElementObj.element.getAttribute('aria-label')) {
          // Check if there's an aria-label for accessibility; if so, return that
          focusedElementObj.label = focusedElementObj.element.getAttribute('aria-label')
        } else {
          // Otherwise, return the text content or innerText
          focusedElementObj.label = focusedElementObj.element
            ? focusedElementObj.element.textContent || focusedElementObj.element.innerText
            : ''
        }
        focusedElementObj.cleanLabel = focusedElementObj.label.trim()
        sendMessageToBackgroundScript({
          type: 'new_focused_element',
          element: focusedElementObj,
        })
        resolve(focusedElementObj) // Resolve the promise with the focused element object
      } catch (error) {
        reject(error) // Reject the promise in case of any errors
      }
    })
  }

  // Add a listener to log the focused element when it changes
  useEffect(() => {
    if (!socketRef.current) {
      socketRef.current = chrome.runtime.onMessage.addListener(async function (request, sender, sendResponse) {
        handleRequest(request, sender, sendResponse)
      })
    }

    document.addEventListener('focus', logFocusedElement, true) // Use capture phase to ensure the listener is executed

    // Cleanup the listener on component unmount
    return () => {
      if (socketRef.current) {
        chrome.runtime.onMessage.removeListener(socketRef.current)
        socketRef.current = null
      }
      document.removeEventListener('focus', logFocusedElement, true)
    }
  }, [])

  const runPressTabInTabWithNextStep = (times, delay) => {
    runFunctionXTimesWithDelay(pressTabInTab, times, delay).then(() => {
      console.log('ready for next step...')
      sendMessageToBackgroundScript({
        type: 'next_step',
      })
    })
  }

  const handleRequest = async (request, sender, sendResponse) => {
    console.log('Side panel recv:', JSON.stringify(request))
    console.log('Received request:', JSON.stringify(request))
    if (request.type === 'showClick') {
      createSquareAtLocation(request.x, request.y)
    // } else if (request.type === 'addThought') {
    //   setCurrentStep(request.currentStep)
    } else if (request.type === 'clickElement') {
      setCurrentStep(request.currentStep)
      setOriginalPlan(request.originalPlan)
      return sendMessageToBackgroundScript({
        type: 'click_element',
        selector: locateCorrectElement(request.ariaLabel),
      })
      setCurrentStep(request.currentStep)
    } else if (request.type === 'generateNextStep') {
      setOriginalPlan(request.originalPlan)
      setCurrentStep(request.currentStep)
      // runPressTabInTabWithNextStep(10, 250);
      console.log(getClickableElements())
      return sendMessageToBackgroundScript({
        type: 'next_step_with_elements',
        elements: getClickableElements().clickableElementLabels.slice(0, 75),
      })
    }
    return sendResponse('complete')
  }

  useEffect(() => {
    chrome.runtime.onMessage.addListener(function (request, sender, sendResponse) {
      handleRequest(request, sender, sendResponse)
      return true; // Indicate that the response is asynchronous
    })
  }, [])

  return (
    <div className="sidePanel">
      <div className="plan">
        <h2>Current Step: {currentStep}</h2>
        {originalPlan?.length > 0 ? (
          <>
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
          </>
        ) : (
          <h2> Thinking...</h2>
        )}
      </div>
    </div>
  )
}

export default SidePanel
