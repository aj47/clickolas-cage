import React, { useRef, useState, useEffect } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
import { sendMessageToBackgroundScript, sendMessageToContentScript } from '../utils'
import { exportLogs, clearLogs } from '../llm-utils'

const handleExportLogs = () => {
  exportLogs()
}

const handleClearLogs = () => {
  clearLogs()
}

const Popup = () => {
  const promptRef = useRef(null)
  const [isLoading, setIsLoading] = useState(false)

  return (
    <div className="App">
      <header className="App-header">
        <div style={{position: 'absolute', top: 15, right: 15}}>
          <button className="input-common input-small" style={{marginBottom: 15}} onClick={handleExportLogs}>
            Export Logs
          </button>
          <button className="input-common input-small" onClick={handleClearLogs}>
            Clear Logs
          </button>
        </div>
        <img src={logo} className="App-logo" alt="logo" />
        <p>HELLO! I AM CLICKOLAS CAGE!</p>
        {!isLoading && (
          <>
            <button
              className="input-common input-small"
              onClick={async () => {
                const prompt = "Create a google calendar event at 2pm labeled 'hello world'";
                promptRef.current.value = prompt;
                console.log('submit clicked.')
                sendMessageToBackgroundScript({ type: 'new_goal', prompt });
                setIsLoading(true);
              }}
            >
              Quick Add Event
            </button>
            <input
              ref={promptRef}
              type="text"
              placeholder="Add event x to
 google calendar"
              className="input-common input-large"
            />
            <input
              onClick={async () => {
                console.log('submit clicked.')
                if (promptRef.current.value.length === 0) return
                sendMessageToBackgroundScript({ type: 'new_goal', prompt: promptRef.current.value })
                setIsLoading(true)
              }}
              type="button"
              value="Submit"
              className="input-common input-large"
            />
          </>
        )}
        {isLoading && <p>Thinking...</p>}
      </header>
    </div>
  )
}

export default Popup
