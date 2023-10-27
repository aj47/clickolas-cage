import React, { useRef, useState, useEffect } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
import OpenAI from 'openai'

const openai = new OpenAI({
  apiKey: import.meta.env.VITE_OPENAI_API_KEY, // defaults to process.env[""]
  dangerouslyAllowBrowser: true,
})

const sendPromptToPlanner = async (prompt) => {
  console.log(prompt)
  console.log('thinking...')
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4',
    messages: [
      {
        role: 'system',
        content: `you are an expert web browsing, given a prompt provide a step by step plan to execute it using google chrome, assume chrome is already open`,
      },
      {
        role: 'user',
        content: `your first task is: ${prompt}`,
      },
      // {
      //   role: 'user',
      //   content: `I want to provide step by step single commands to be inputted into a chrome console to achieve the following task : ${prompt}.
      //   First only provide the command to which URL to navigate to. then I will provide the DOM elements you can interact with, afterwards provide a command to interact with the dom and we will continue this process until the task is achieved`,
      // },
    ],
  })
  console.log(chatCompletion.choices[0].message.content)
  return chatCompletion.choices[0].message.content
  // return chatCompletion.choices[0].text.strip()
}
const sendPromptToOpenAI = async (prompt) => {
  console.log(prompt)
  console.log('thinking...')
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4',
    messages: [
      {
        role: 'system',
        content: `you are an expert Javascript AI interfacing with a chrome dev console,
        you will be given a task to be completed. respond in step by step processes of Javascript commands to complete ONLY one the following actions:
        1. navigate to a URL
        2. click a button
        3. input text`,
      },
      {
        role: 'user',
        content: `your first task is: ${prompt}`,
      },
      // {
      //   role: 'user',
      //   content: `I want to provide step by step single commands to be inputted into a chrome console to achieve the following task : ${prompt}.
      //   First only provide the command to which URL to navigate to. then I will provide the DOM elements you can interact with, afterwards provide a command to interact with the dom and we will continue this process until the task is achieved`,
      // },
    ],
  })
  console.log(chatCompletion.choices[0].message.content)
  return chatCompletion.choices[0].message.content
  // return chatCompletion.choices[0].text.strip()
}

const Popup = () => {
  const promptRef = useRef(null)
  const [LLMThoughts, setLLMThoughts] = useState(null)
  const [LLMPlan, setLLMPlan] = useState(null)
  const [initialPrompt, setInitialPrompt] = useState(null)

  useEffect(() => {
    // console.log(chrome.extension.getBackgroundPage());
    // const storedPrompt = localStorage.getItem('click-cage-prompt')
    // console.log(storedPrompt)
    // if (storedPrompt !== initialPrompt) {
    //   setInitialPrompt(storedPrompt)
    //   runFlow(storedPrompt)
    // }
  }, [initialPrompt])

  const runFlow = async (prompt) => {
    let response = ''
    setLLMThoughts('thinking...')
    let plan = await sendPromptToPlanner(prompt)
    console.log(plan.split(/(?<=\d\.)/))
    setLLMPlan(plan.split(/(?<=\d\.)/)[1])
    while (response.indexOf('```javascript') === -1)
      response = await sendPromptToOpenAI(plan.split(/(?<=\d\.)/)[1])
    setLLMThoughts(response.slice(0, response.indexOf('```javascript')))
    const start = response.indexOf('```javascript') + '```javascript'.length
    const end = response.indexOf('```', start + 1)
    const codeSnippet = response.slice(start, end)
    console.log('EXECUTE: ' + codeSnippet)

    // // chrome.tabs.create({ url: 'http://127.0.0.1:8000' }, function (tab) {})
    // chrome.tabs.onCreated.addListener(function (tabId, changeInfo, tab) {
    //   console.log('yoooo')
    //   alert('HELLO WORLD')
    // })
    // chrome.tabs.onUpdated.addListener(function (tabId, changeInfo, tab) {
    //   console.log('yoooo2')
    //   // make sure the status is 'complete' and it's the right tab
    //   if (tab.url.indexOf('127.0.0.1:8000') != -1 && changeInfo.status == 'complete') {
    //     // chrome.tabs.executeScript(null, {
    //     //   code: codeSnippet,
    //     // })
    //   }
    // })
    // chrome.runtime.sendMessage("test");
  }

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
                localStorage.setItem('click-cage-prompt', promptRef.current.value)
                chrome.tabs.create({ url: 'newtab.html' })
                return
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
