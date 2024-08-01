import { useState, useEffect, useRef } from 'react'

import { runFunctionXTimesWithDelay, sendMessageToBackgroundScript, sleep } from '../utils'

import './SidePanel.css'
export const SidePanel = () => {
  const [plan, setPlan] = useState([])
  const [currentStep, setCurrentStep] = useState(0)
  const socketRef = useRef(null)
  const stepsListRef = useRef(null)  // New ref for the steps list

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
    const clickableElementLabels = []

    const getAllElements = (root) => {
      const elements = []
      for (const element of Array.from(root.querySelectorAll("*"))) {
        elements.push(element)
        if (element.shadowRoot) {
          elements.push(...getAllElements(element.shadowRoot))
        }
      }
      return elements
    }

    const elements = getAllElements(document.documentElement)

    for (const element of elements) {
      const isClickable = isElementClickable(element)
      if (isClickable) {
        clickableElements.push(element)
        clickableElementLabels.push({
          role: element.getAttribute('role') || element.tagName,
          ariaLabel: element.getAttribute('aria-label') || element.innerText,
        })
      }
    }

    const cleanedArray = [
      ...new Set(clickableElementLabels.filter((e) => e.ariaLabel !== '' && e.ariaLabel !== null && e.role !== 'BODY')),
    ]
    return { clickableElements, clickableElementLabels: cleanedArray }
  }

  const isElementClickable = (element) => {
    const tagName = element.tagName.toLowerCase()
    let isClickable = false

    // Check for href attribute
    if (element.href) return true

    // Check for onclick attribute
    if (element.hasAttribute("onclick")) return true

    // Check for clickable roles
    const clickableRoles = ["button", "tab", "link", "checkbox", "menuitem", "menuitemcheckbox", "menuitemradio", "radio"]
    const role = element.getAttribute("role")
    if (role && clickableRoles.includes(role.toLowerCase())) return true

    // Check for contentEditable
    const contentEditable = element.getAttribute("contentEditable")
    if (contentEditable && ["", "contenteditable", "true"].includes(contentEditable.toLowerCase())) return true

    // Check for jsaction
    if (element.hasAttribute("jsaction")) {
      const jsactionRules = element.getAttribute("jsaction").split(";")
      for (const jsactionRule of jsactionRules) {
        const ruleSplit = jsactionRule.trim().split(":")
        if (ruleSplit.length >= 1 && ruleSplit.length <= 2) {
          const [eventType, namespace, actionName] = ruleSplit.length === 1
            ? ["click", ...ruleSplit[0].trim().split("."), "_"]
            : [ruleSplit[0], ...ruleSplit[1].trim().split("."), "_"]
          if (eventType === "click" && namespace !== "none" && actionName !== "_") return true
        }
      }
    }

    // Check for specific tag names
    switch (tagName) {
      case "a":
      case "object":
      case "embed":
      case "details":
        return true
      case "textarea":
        return !element.disabled && !element.readOnly
      case "input":
        return !(element.getAttribute("type")?.toLowerCase() === "hidden" || element.disabled || (element.readOnly && element.type !== "text"))
      case "button":
      case "select":
        return !element.disabled
      case "img":
        return ["zoom-in", "zoom-out"].includes(element.style.cursor)
      case "div":
      case "ol":
      case "ul":
        return (element.clientHeight < element.scrollHeight) && isScrollableElement(element)
    }

    return isClickable
  }

  const isScrollableElement = (element) => {
    const style = window.getComputedStyle(element)
    return ['auto', 'scroll'].includes(style.overflowY) || ['auto', 'scroll'].includes(style.overflow)
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
      socketRef.current = chrome.runtime.onMessage.addListener(
        async function (request, sender, sendResponse) {
          console.log('recieved request', JSON.stringify(request))
          handleRequest(request, sender, sendResponse)
          return true // Indicate that the response is asynchronous
        },
      )
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
    if (request.type === 'showClick') {
      createSquareAtLocation(request.x, request.y)
    } else if (request.type === 'locateElement') {
      setCurrentStep(request.currentStep)
      setPlan(request.plan)
      sendResponse({
        type: 'click_element',
        selector: locateCorrectElement(request.ariaLabel),
      })
    } else if (request.type === 'generateNextStep') {
      setPlan(request.plan)
      setCurrentStep(request.currentStep)
      console.log('current step', request.currentStep)
      sendResponse({
        type: 'next_step_with_elements',
        elements: getClickableElements().clickableElementLabels.slice(0, 200),
      })
    } else if (request.type === 'updatePlan') {
      setPlan(request.plan)
      setCurrentStep(request.currentStep)
    }
    sendResponse({ type: 'completed_task' })
  }

  useEffect(() => {
    // New effect to scroll the steps list to bottom when plan updates
    if (stepsListRef.current) {
      stepsListRef.current.scrollTop = stepsListRef.current.scrollHeight
    }
  }, [plan])  // This effect runs whenever plan changes

  return (
    <div className="sidePanel">
      <div className="plan">
        <h2>Current Step: {currentStep}</h2>
        {plan?.length > 0 ? (
          <>
            <h2>Clickolas Plan: </h2>
            <div className="steps-list" ref={stepsListRef}>  {/* New scrollable container */}
              {plan.map((step, i) => (
                <div className="step" key={i}>
                  {i + 1} - {step.thought}
                </div>
              ))}
            </div>
          </>
        ) : (
          <h2> Thinking...</h2>
        )}
      </div>
    </div>
  )
}

export default SidePanel
