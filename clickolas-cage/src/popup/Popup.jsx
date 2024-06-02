import React, { useRef, useState, useEffect } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
import { sendMessageToBackgroundScript, sendMessageToContentScript } from '../utils'

const Popup = () => {
  const promptRef = useRef(null)
  const [LLMThoughts, setLLMThoughts] = useState(null)
  const [LLMPlan, setLLMPlan] = useState(null)
  const [isLoading, setIsLoading] = useState(false)
  const [initialPrompt, setInitialPrompt] = useState(null)
  const [showConfirmationDialog, setShowConfirmationDialog] = useState(false)

  useEffect(() => {
    // Listener for background script to trigger confirmation dialog
    chrome.runtime.onMessage.addListener((message, sender, sendResponse) => {
      if (message.type === 'askUserConfirmation') {
        setShowConfirmationDialog(true)
      }
    })
  }, [])

  const handleUserConfirmation = (confirmation) => {
    setShowConfirmationDialog(false)
    sendMessageToBackgroundScript({ type: 'userConfirmation', confirmation })
  }

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>HELLO! I AM CLICKOLAS CAGE!</p>
        {!initialPrompt && !isLoading && (
          <>
            <input ref={promptRef} type="text" placeholder="Add event x to my google calendar" className="input-large" />
            <input
              onClick={async () => {
                console.log('submit clicked.')
                if (promptRef.current.value.length === 0) return
                sendMessageToBackgroundScript({ type: 'new_goal', prompt: promptRef.current.value })
                setIsLoading(true)
              }}
              type="button"
              value="Submit"
              className="input-large"
            />
          </>
        )}
        {isLoading && <p>Thinking...</p>}
        {showConfirmationDialog && (
          <div>
            <p>Did the task complete successfully?</p>
            <button onClick={() => handleUserConfirmation(true)}>Yes</button>
            <button onClick={() => handleUserConfirmation(false)}>No</button>
          </div>
        )}
      </header>
      <p>{LLMThoughts}</p>
      <p>{LLMPlan}</p>
    </div>
  )
}

export default Popup
