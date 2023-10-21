import React, { useRef, useState } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
import OpenAI from 'openai'

const openai = new OpenAI({
  apiKey: import.meta.env.VITE_OPENAI_API_KEY, // defaults to process.env[""]
  dangerouslyAllowBrowser: true,
})

console.log();
const sendPromptToOpenAI = async (prompt) => {
  console.log('thinking...')
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4',
    messages: [
      {
        role: 'user',
        content: `I want to provide step by step single commands to be inputted into a chrome console to achieve the following task : ${prompt}.
        First only provide the command to which URL to navigate to. then I will provide the DOM elements you can interact with, afterwards provide a command to interact with the dom and we will continue this process until the task is achieved`,
      },
    ],
  })
  console.log(chatCompletion.choices[0].message.content)
  return chatCompletion.choices[0].message.content
  // return chatCompletion.choices[0].text.strip()
}

const Popup = () => {
  const promptRef = useRef(null)
  const [LLMThoughts, setLLMThoughts] = useState(null)
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>HELLO! I AM CLICKOLAS CAGE!</p>
        <input ref={promptRef} type="text" placeholder="Add event x to my google calendar" />
        <input
          onClick={async () => {
            setLLMThoughts(await sendPromptToOpenAI(promptRef.current))
          }}
          type="button"
          value="Submit"
        />
      </header>
      <p>{LLMThoughts}</p>
    </div>
  )
}

export default Popup
