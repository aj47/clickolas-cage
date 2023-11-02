import React, { useRef, useState, useEffect } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
const Popup = () => {
  const promptRef = useRef(null)
  const [LLMThoughts, setLLMThoughts] = useState(null)
  const [LLMPlan, setLLMPlan] = useState(null)
  const [initialPrompt, setInitialPrompt] = useState(null)

  // useEffect(() => {
  // console.log(chrome.extension.getBackgroundPage());
  // const storedPrompt = localStorage.getItem('click-cage-prompt')
  // console.log(storedPrompt)
  // if (storedPrompt !== initialPrompt) {
  //   setInitialPrompt(storedPrompt)
  //   runFlow(storedPrompt)
  // }
  // }, [initialPrompt])

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>HELLO! I AM CLICKOLAS CAGE!</p>
        {!initialPrompt && (
          <>
            <input ref={promptRef} type="text" placeholder="Add event x to my google calendar" />
            <input
              onClick={async () => {
                console.log("hello?");
                if (promptRef.current.value.length === 0) return
                chrome.tabs.query({ active: true, currentWindow: true }, function (tabs) {
                  chrome.tabs.sendMessage(tabs[0].id, { prompt: promptRef.current.value })
                })
              }}
              type="button"
              value="Submit"
            />
          </>
        )}
      </header>
      <p>{LLMThoughts}</p>
      <p>{LLMPlan}</p>
    </div>
  )
}

export default Popup
