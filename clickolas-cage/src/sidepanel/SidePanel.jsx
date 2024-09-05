import { useState, useEffect, useRef } from 'react'

import { runFunctionXTimesWithDelay, sendMessageToBackgroundScript, sleep } from '../utils'

import './SidePanel.css'

export const SidePanel = () => {
  const [tabId, setTabId] = useState(null)

  useEffect(() => {
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
      if (tabs[0]) {
        setTabId(tabs[0].id)
      }
    })

    const handleTabChange = (activeInfo) => {
      setTabId(activeInfo.tabId)
    }

    chrome.tabs.onActivated.addListener(handleTabChange)

    return () => {
      chrome.tabs.onActivated.removeListener(handleTabChange)
    }
  }, [])
  const [messages, setMessages] = useState([])
  const [currentStep, setCurrentStep] = useState(0)
  const socketRef = useRef(null)
  const messagesListRef = useRef(null)

  const delayBetweenKeystrokes = 100

  const [lastObservedTime, setLastObservedTime] = useState(Date.now())
  const observerRef = useRef(null)

  const [isInitialRenderComplete, setIsInitialRenderComplete] = useState(false)

  const [isDragging, setIsDragging] = useState(false)
  const [dragOffset, setDragOffset] = useState({ x: 0, y: 0 })

  const [isMinimized, setIsMinimized] = useState(false)

  const [userInput, setUserInput] = useState('')
  const [transcript, setTranscript] = useState('')
  const transcriptRef = useRef('')
  const [isLoading, setIsLoading] = useState(false)

  const [isExecuting, setIsExecuting] = useState(false)
  const isExecutingRef = useRef(false)
  const [showStopButton, setShowStopButton] = useState(false)

  const [disablePointerEvents, setDisablePointerEvents] = useState(false)

  const [isListening, setIsListening] = useState(false)
  const isListeningRef = useRef(false)
  const recognitionRef = useRef(null)

  const handleMouseDown = (e) => {
    console.log('Mouse down event triggered')
    setIsDragging(true)
    setDragOffset({
      x: e.clientX - position.x,
      y: e.clientY - position.y,
    })
  }

  const [position, setPosition] = useState({
    x: window.innerWidth - 260,
    y: window.innerHeight / 2 - 200, // Position in the middle of the window height
  })
  const handleMouseMove = (e) => {
    if (isDragging) {
      const panelHeight = isMinimized ? 30 : 400 // Use the actual height of the panel
      const newX = Math.max(0, Math.min(e.clientX - dragOffset.x, window.innerWidth - 250))
      const newY = Math.max(0, Math.min(e.clientY - dragOffset.y, window.innerHeight - panelHeight))
      setPosition({
        x: newX,
        y: newY,
      })
    }
  }

  const handleMouseUp = () => {
    setIsDragging(false)
  }

  const toggleMinimize = () => {
    setIsMinimized(!isMinimized)
  }

  useEffect(() => {
    if (isDragging) {
      document.addEventListener('mousemove', handleMouseMove)
      document.addEventListener('mouseup', handleMouseUp)
    } else {
      document.removeEventListener('mousemove', handleMouseMove)
      document.removeEventListener('mouseup', handleMouseUp)
    }
    return () => {
      document.removeEventListener('mousemove', handleMouseMove)
      document.removeEventListener('mouseup', handleMouseUp)
    }
  }, [isDragging, dragOffset, position])

  /**
   * Shows a click indicator at the given location using the logo image.
   * @param {number} x - The x-coordinate of the click location.
   * @param {number} y - The y-coordinate of the click location.
   */
  async function showClickIndicator(x, y) {
    const clickIndicator = document.createElement('img')
    clickIndicator.src = chrome.runtime.getURL('img/logo-48.png')
    clickIndicator.style.opacity = '0.9'
    clickIndicator.style.position = 'absolute'
    clickIndicator.style.left = `${x - 17}px`
    clickIndicator.style.top = `${y - 17}px`
    clickIndicator.style.zIndex = '9999'
    clickIndicator.style.pointerEvents = 'none'
    document.body.appendChild(clickIndicator)

    // Remove the indicator after a short delay
    setTimeout(() => {
      if (document.body.contains(clickIndicator)) {
        document.body.removeChild(clickIndicator)
      }
    }, 2000)
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
    const seenAriaLabels = new Set()

    const getAllElements = (root) => {
      const elements = []
      for (const element of Array.from(root.querySelectorAll('*'))) {
        // Skip elements inside .sidePanel
        if (element.closest('.sidePanel')) continue

        elements.push(element)
        if (element.shadowRoot) {
          elements.push(...getAllElements(element.shadowRoot))
        }
      }
      return elements
    }

    const elements = getAllElements(document.documentElement)
    const currentTime = Date.now()
    const focusedElement = document.activeElement

    for (const element of elements) {
      const isClickable = isElementClickable(element)
      if (isClickable) {
        const boundingBox = element.getBoundingClientRect()
        if (boundingBox && boundingBox.x !== 0 && boundingBox.y !== 0) {
          const isNew =
            element.dataset.observedTime &&
            parseInt(element.dataset.observedTime) > lastObservedTime
          clickableElements.push(element)
          const ariaLabel = element.getAttribute('aria-label') || element.innerText

          // Check if this aria label has been seen before
          if (!seenAriaLabels.has(ariaLabel)) {
            seenAriaLabels.add(ariaLabel)
            const elementInfo = {
              role: element.getAttribute('role') || element.tagName,
              ariaLabel: ariaLabel,
              isNew: isNew,
              tabIndex: element.tabIndex,
            }
            if (element.tagName.toLowerCase() === 'input') {
              elementInfo.value = element.value
            }
            clickableElementLabels.push(elementInfo)
          }
        }
      }
    }

    setLastObservedTime(currentTime)

    const cleanedArray = clickableElementLabels.filter(
      (e) => e.ariaLabel !== '' && e.ariaLabel !== null && e.role !== 'BODY',
    )

    // Sort the array to place new elements at the top
    cleanedArray.sort((a, b) => {
      if (a.isNew && !b.isNew) return -1
      if (!a.isNew && b.isNew) return 1
      return 0
    })

    return {
      clickableElements,
      clickableElementLabels: cleanedArray,
      focusedElement: focusedElement
        ? {
            role: focusedElement.getAttribute('role') || focusedElement.tagName,
            ariaLabel: focusedElement.getAttribute('aria-label') || focusedElement.innerText,
            tabIndex: focusedElement.tabIndex,
          }
        : null,
    }
  }

  const isElementClickable = (element) => {
    const tagName = element.tagName.toLowerCase()
    let isClickable = false

    // Check for href attribute
    if (element.href) return true

    // Check for onclick attribute
    if (element.hasAttribute('onclick')) return true

    // Check for clickable roles
    const clickableRoles = [
      'option',
      'button',
      'tab',
      'link',
      'checkbox',
      'menuitem',
      'menuitemcheckbox',
      'menuitemradio',
      'radio',
    ]
    const role = element.getAttribute('role')
    if (role && clickableRoles.includes(role.toLowerCase())) return true

    // Check for contentEditable
    const contentEditable = element.getAttribute('contentEditable')
    if (contentEditable && ['', 'contenteditable', 'true'].includes(contentEditable.toLowerCase()))
      return true

    // Check for jsaction
    if (element.hasAttribute('jsaction')) {
      const jsactionRules = element.getAttribute('jsaction').split(';')
      for (const jsactionRule of jsactionRules) {
        const ruleSplit = jsactionRule.trim().split(':')
        if (ruleSplit.length >= 1 && ruleSplit.length <= 2) {
          const [eventType, namespace, actionName] =
            ruleSplit.length === 1
              ? ['click', ...ruleSplit[0].trim().split('.'), '_']
              : [ruleSplit[0], ...ruleSplit[1].trim().split('.'), '_']
          if (eventType === 'click' && namespace !== 'none' && actionName !== '_') return true
        }
      }
    }

    // Check for specific tag names
    switch (tagName) {
      case 'a':
      case 'object':
      case 'embed':
      case 'details':
        return true
      case 'textarea':
        return !element.disabled && !element.readOnly
      case 'input':
        return !(
          element.getAttribute('type')?.toLowerCase() === 'hidden' ||
          element.disabled ||
          (element.readOnly && element.type !== 'text')
        )
      case 'button':
      case 'select':
        return !element.disabled
      case 'img':
        return ['zoom-in', 'zoom-out'].includes(element.style.cursor)
      case 'div':
      case 'ol':
      case 'ul':
        return element.clientHeight < element.scrollHeight && isScrollableElement(element)
    }

    return isClickable
  }

  const isScrollableElement = (element) => {
    const style = window.getComputedStyle(element)
    return (
      ['auto', 'scroll'].includes(style.overflowY) || ['auto', 'scroll'].includes(style.overflow)
    )
  }

  /**
   * Locates the correct element based on an initial label, and scrolls to it if found.
   * If it finds a matching element, it returns its path; otherwise, it logs an error message and returns false.
   * @param {string} initialLabel - The initial guess of the element's label.
   * @returns {Promise<string|Object>} A promise that resolves to either a string path or an object with error information.
   */
  const locateCorrectElement = (initialLabel) => {
    console.log('looking for element:', initialLabel)
    const { clickableElements, clickableElementLabels, focusedElement } = getClickableElements()
    let returnEl = null
    for (const el of clickableElements) {
      if (el.getAttribute('aria-label') === initialLabel || el.innerText === initialLabel) {
        console.log('LOCATED ELEMENT: ')
        console.log(el)
        returnEl = el
        break
      }
    }
    if (returnEl) {
      returnEl.scrollIntoView({ behavior: 'smooth', block: 'center' })
      return getPathTo(returnEl)
    } else {
      console.log('NO ELEMENT FOUND :(')
      return {
        type: 'element_not_found',
        ariaLabel: initialLabel,
        elements: clickableElementLabels,
        focusedElement: focusedElement,
      }
    }
  }

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
  }, [])

  const handleRequest = async (request, sender, sendResponse) => {
    // Re-enable pointer events when any message is received
    setDisablePointerEvents(false)

    if (request.plan && request.currentStep) {
      const newMessages = request.plan.map((step, index) => ({
        type: 'step',
        content: `${index + 1} - ${step.thought}`,
      }))
      setMessages(newMessages)
      setCurrentStep(request.currentStep)
    }
    switch (request.type) {
      case 'showClick':
        showClickIndicator(request.x, request.y)
        sendResponse({ type: 'completed_task' })
        break
      case 'locateElement':
        if (request.action === 'CLICKBTN') {
          setDisablePointerEvents(true)
        }
        const result = locateCorrectElement(request.ariaLabel)
        if (typeof result === 'string') {
          sendResponse({
            type: 'element_located',
            selector: result,
            action: request.action,
            text: request.text, // Only used for TYPETEXT
          })
        } else {
          sendResponse(result) // This will send the 'element_not_found' response with focusedElement
        }
        break
      case 'generateNextStep':
        const { clickableElementLabels, focusedElement } = getClickableElements()
        sendResponse({
          type: 'next_step_with_elements',
          elements: clickableElementLabels.slice(0, 200),
          focusedElement: focusedElement,
        })
        break
      case 'goalCompleted':
        setMessages((prevMessages) => [
          ...prevMessages,
          { type: 'completion', content: `Goal achieved: ${request.message}` },
        ])
        setIsExecuting(false)
        isExecutingRef.current = false
        setShowStopButton(false) // Reset the stop button visibility
        sendResponse({ type: 'ready' })
        break
      default:
        sendResponse({ type: 'ready' })
        break
      case 'execution_started':
        setIsExecuting(true)
        isExecutingRef.current = true
        setShowStopButton(true)
        break
      case 'execution_completed':
        setIsExecuting(false)
        isExecutingRef.current = false
        setShowStopButton(false) // Reset the stop button visibility
        break
    }
  }

  useEffect(() => {
    // Scroll to the bottom of the messages list when messages update
    if (messagesListRef.current) {
      messagesListRef.current.scrollTop = messagesListRef.current.scrollHeight
    }
  }, [messages])

  //----------  start DOM change check --------
  useEffect(() => {
    const timer = setTimeout(() => {
      setIsInitialRenderComplete(true)
    }, 1000) // Adjust this delay as needed
    return () => clearTimeout(timer)
  }, [])
  useEffect(() => {
    if (!isInitialRenderComplete) return
    observerRef.current = new MutationObserver((mutations) => {
      const currentTime = Date.now()
      mutations.forEach((mutation) => {
        mutation.addedNodes.forEach((node) => {
          if (!isIgnoredElement(node)) {
            if (isRelevantElement(node)) {
              node.dataset.observedTime = currentTime
            }
            // Check for all relevant child elements
            if (node.querySelectorAll) {
              node
                .querySelectorAll(
                  'ul, select, .dropdown, [role="listbox"], [role="menu"], [role="menuitem"]',
                )
                .forEach((relevantChild) => {
                  relevantChild.dataset.observedTime = currentTime
                })
            }
          }
        })
      })
    })
    observerRef.current.observe(document.body, {
      childList: true,
      subtree: true,
      attributes: false,
      characterData: false,
    })
    return () => {
      if (observerRef.current) {
        observerRef.current.disconnect()
      }
    }
  }, [isInitialRenderComplete])
  const isRelevantElement = (element) => {
    if (!(element instanceof Element)) {
      return false
    }
    return (
      element.tagName === 'UL' ||
      element.tagName === 'SELECT' ||
      element.classList?.contains('dropdown') ||
      element.getAttribute('role') === 'listbox' ||
      element.getAttribute('role') === 'menu' ||
      element.getAttribute('role') === 'menuitem'
    )
  }
  const isIgnoredElement = (element) => {
    // Check if the element is an HTML element
    if (element instanceof Element) {
      // Check if the element is part of the step list or a click square
      return (
        element.closest('.sidePanel') !== null ||
        element.classList?.contains('clickolas-click-indicator')
      )
    }
    return false
  }
  //----------  end DOM change check --------

  useEffect(() => {
    // Initialize speech recognition
    if ('webkitSpeechRecognition' in window) {
      const SpeechRecognition = window.webkitSpeechRecognition
      recognitionRef.current = new SpeechRecognition()
      recognitionRef.current.continuous = true
      recognitionRef.current.interimResults = true

      recognitionRef.current.onresult = (event) => {
        const currentTranscript = Array.from(event.results)
          .map((result) => result[0].transcript)
          .join('')
        setTranscript(currentTranscript)
        transcriptRef.current = currentTranscript // Update the ref
        setUserInput(currentTranscript)
      }

      recognitionRef.current.onerror = (event) => {
        console.error('Speech recognition error', event.error)
        setIsListening(false)
      }

      recognitionRef.current.onend = () => {
        setIsListening(false)
      }
    }

    // Add global keydown event listener for voice input
    const handleGlobalKeyDown = async (e) => {
      if (e.ctrlKey && e.shiftKey && e.key === 'K') {
        e.preventDefault()
        const newListeningState = !isListeningRef.current
        await toggleListening()
        if (!newListeningState) {
          // Only submit if we're stopping listening
          await handleUserInput(e, transcriptRef.current)
        }
        console.log('isListening (after toggle)', isListeningRef.current)
      }
    }

    document.addEventListener('keydown', handleGlobalKeyDown)

    return () => {
      document.removeEventListener('keydown', handleGlobalKeyDown)
      if (recognitionRef.current) {
        recognitionRef.current.stop()
      }
    }
  }, [])

  const toggleListening = async () => {
    return new Promise((resolve) => {
      setIsListening((prevIsListening) => {
        const newState = !prevIsListening
        isListeningRef.current = newState
        console.log('isListening (in toggle)', newState)

        if (isExecutingRef.current) {
          handleStopExecution().then(() => {
            if (newState) {
              recognitionRef.current.start()
              setTranscript('')
            } else {
              recognitionRef.current.stop()
            }
            resolve()
          })
        } else {
          if (newState) {
            recognitionRef.current.start()
            setTranscript('')
          } else {
            recognitionRef.current.stop()
          }
          setTimeout(resolve, 0)
        }

        return newState
      })
    })
  }

  const handleUserInput = async (e, overrideInput = null) => {
    if (e) e.preventDefault()
    const inputToSend = overrideInput || userInput
    console.log('userInput', inputToSend)
    if (!inputToSend.trim()) return

    setIsLoading(true)
    const { clickableElementLabels, focusedElement } = getClickableElements()

    // Add user message to the message log
    setMessages((prevMessages) => [...prevMessages, { type: 'user', content: inputToSend }])

    try {
      await sendMessageToBackgroundScript({
        type: 'user_message',
        tabId: tabId,
        message: inputToSend,
        elements: clickableElementLabels.slice(0, 200),
        focusedElement: focusedElement,
        plan: messages.filter((m) => m.type === 'step').map((m) => m.content),
      })
      setUserInput('')
      setTranscript('') // Clear transcript after sending
      transcriptRef.current = '' // Clear the transcript ref
      if (isListeningRef.current) {
        await toggleListening() // Stop listening after sending the message
      }
    } catch (error) {
      console.error('Error sending user message:', error)
      setMessages((prevMessages) => [
        ...prevMessages,
        { type: 'error', content: 'Failed to send message' },
      ])
    } finally {
      setIsLoading(false)
    }
  }

  const handleStopExecution = async () => {
    try {
      setIsExecuting(false)
      isExecutingRef.current = false
      await sendMessageToBackgroundScript({
        type: 'stop_execution',
        tabId: tabId,
      })
      setMessages((prevMessages) => [
        ...prevMessages,
        { type: 'system', content: 'Execution stopped.' },
      ])
    } catch (error) {
      console.error('Error stopping execution:', error)
      setMessages((prevMessages) => [
        ...prevMessages,
        { type: 'error', content: 'Failed to stop execution.' },
      ])
    }
  }

  return (
    <div
      className={`sidePanel ${isMinimized ? 'minimized' : ''}`}
      style={{
        top: `${position.y}px`,
        left: `${position.x}px`,
        right: 'auto',
        pointerEvents: disablePointerEvents ? 'none' : 'auto',
      }}
    >
      <div className="topBar" onMouseDown={handleMouseDown}>
        <span>Clickolas Cage</span>
        <button className="minimizeButton" onClick={toggleMinimize}>
          {isMinimized ? '▲' : '▼'}
        </button>
      </div>
      <div className="plan">
        <div className="messages-list" ref={messagesListRef}>
          {messages.map((message, i) => (
            <div className={`message ${message.type}`} key={i}>
              {message.content}
            </div>
          ))}
        </div>
      </div>
      <div className="input-area">
        {isExecutingRef.current ? (
          <button onClick={handleStopExecution} className="stop-execution-button">
            Stop Execution <p style={{fontSize: '0.7em', marginBottom: '0'}}> (Ctrl+Shift+K for Voice)</p>
          </button>
        ) : (
          <>
            <form onSubmit={(e) => handleUserInput(e)} className="user-input-form">
              <input
                type="text"
                value={userInput}
                onChange={(e) => setUserInput(e.target.value)}
                placeholder={isListening ? 'Listening...' : 'Type your message...'}
                disabled={isLoading}
              />
              <button
                type="submit"
                onClick={toggleListening}
                className={`voice-input-button ${isListening ? 'listening' : ''}`}
              >
                {isListening ? (isLoading ? 'Sending...' : 'Send') : 'Voice'} (Ctrl+Shift+K)
              </button>
              {!isListening && (
                <button type="submit" disabled={isLoading}>
                  {isLoading ? 'Sending...' : 'Send'}
                </button>
              )}
            </form>
          </>
        )}
      </div>
    </div>
  )
}

export default SidePanel
