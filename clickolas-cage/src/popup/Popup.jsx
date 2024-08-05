import React, { useRef, useState, useEffect } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
import { sendMessageToBackgroundScript, sendMessageToContentScript } from '../utils'
import { exportLogs, clearLogs, setModelAndProvider } from '../llm-utils'

const handleExportLogs = () => {
  exportLogs()
}

const handleClearLogs = () => {
  clearLogs()
}

const getProviderFromModel = (model) => {
  if (model.startsWith('gemini')) return 'google'
  if (model.startsWith('gpt')) return 'openai'
  if (model.startsWith('llama2') || model.startsWith('mixtral')) return 'groq'
  return 'custom'
}

const Popup = () => {
  const promptRef = useRef(null)
  const [isLoading, setIsLoading] = useState(false)
  const [model, setModel] = useState('gemini-1.5-flash-latest')
  const [provider, setProvider] = useState('google')
  const [customModel, setCustomModel] = useState('')

  const handleModelChange = (e) => {
    const selectedModel = e.target.value
    setModel(selectedModel)
    if (selectedModel !== 'custom') {
      const newProvider = getProviderFromModel(selectedModel)
      setProvider(newProvider)
      setModelAndProvider(selectedModel, newProvider)
    }
  }

  const handleCustomModelChange = (e) => {
    const customModelValue = e.target.value
    setCustomModel(customModelValue)
    setModelAndProvider(customModelValue, provider)
  }

  const handleProviderChange = (e) => {
    const newProvider = e.target.value
    setProvider(newProvider)
    setModelAndProvider(model === 'custom' ? customModel : model, newProvider)
  }

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
            <div className="model-provider-selector">
              <select value={model} onChange={handleModelChange} className="input-common input-small">
                <optgroup label="Google">
                  <option value="gemini-1.5-pro">Gemini 1.5 Pro</option>
                  <option value="gemini-1.5-flash-latest">Gemini 1.5 Flash</option>
                </optgroup>
                <optgroup label="OpenAI">
                  <option value="gpt-4-turbo-preview">GPT-4 Turbo</option>
                  <option value="gpt-4">GPT-4</option>
                  <option value="gpt-3.5-turbo">GPT-3.5 Turbo</option>
                </optgroup>
                <optgroup label="Groq">
                  <option value="llama2-70b-4096">LLaMA2 70B</option>
                  <option value="mixtral-8x7b-32768">Mixtral 8x7B</option>
                </optgroup>
                <option value="custom">Custom</option>
              </select>
              {model === 'custom' && (
                <input
                  type="text"
                  value={customModel}
                  onChange={handleCustomModelChange}
                  placeholder="Enter custom model"
                  className="input-common input-small custom-model-input"
                />
              )}
              <select value={provider} onChange={handleProviderChange} className="input-common input-small">
                <option value="google">Google</option>
                <option value="openai">OpenAI</option>
                <option value="groq">Groq</option>
                <option value="custom">Custom</option>
              </select>
            </div>
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
