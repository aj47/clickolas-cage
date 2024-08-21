import React, { useRef, useState, useEffect } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
import { sendMessageToBackgroundScript } from '../utils'
import { exportLogs, clearLogs } from '../llm-utils'

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
  const [model, setModel] = useState('gpt-4o')
  const [provider, setProvider] = useState('openai')
  const [customModel, setCustomModel] = useState('')
  const [showSettings, setShowSettings] = useState(false)
  const [apiKey, setApiKey] = useState('')
  const [isLoadingSettings, setIsLoadingSettings] = useState(true)

  useEffect(() => {
    const loadModelAndProvider = async () => {
      try {
        setIsLoadingSettings(true)
        const response = await new Promise((resolve) => {
          chrome.runtime.sendMessage({ type: 'getModelAndProvider' }, resolve)
        })
        if (response && response.currentModel && response.currentProvider) {
          setModel(response.currentModel)
          setProvider(response.currentProvider)
          setApiKey(response.currentApiKey || '')
        } else {
          console.error('Invalid response from background script:', response)
          // Set default values if the response is invalid
          setModel('gemini-1.5-flash-latest')
          setProvider('google')
        }
      } catch (error) {
        console.error('Error loading model and provider:', error)
        // Set default values if there's an error
        setModel('gemini-1.5-flash-latest')
        setProvider('google')
      } finally {
        setIsLoadingSettings(false)
      }
    }
    loadModelAndProvider()
  }, [])

  const handleModelChange = async (e) => {
    const selectedModel = e.target.value
    setModel(selectedModel)
    if (selectedModel !== 'custom') {
      const newProvider = getProviderFromModel(selectedModel)
      setProvider(newProvider)
      await sendMessageToBackgroundScript({
        type: 'updateModelAndProvider',
        model: selectedModel,
        provider: newProvider,
      })
    }
  }

  const handleCustomModelChange = (e) => {
    const customModelValue = e.target.value
    setCustomModel(customModelValue)
    sendMessageToBackgroundScript({
      type: 'updateModelAndProvider',
      model: customModelValue,
      provider,
    })
  }

  const handleProviderChange = async (e) => {
    const newProvider = e.target.value
    setProvider(newProvider)
    await sendMessageToBackgroundScript({
      type: 'updateModelAndProvider',
      model: model === 'custom' ? customModel : model,
      provider: newProvider,
    })
  }

  const handleApiKeyChange = (e) => {
    const newApiKey = e.target.value
    setApiKey(newApiKey)
    sendMessageToBackgroundScript({
      type: 'updateModelAndProvider',
      model: model === 'custom' ? customModel : model,
      provider,
      apiKey: newApiKey,
    })
  }

  const handleTextareaChange = (e) => {
    e.target.style.height = 'auto'
    e.target.style.height = `${e.target.scrollHeight}px`
  }

  const toggleSettings = () => {
    setShowSettings(!showSettings)
  }

  return (
    <div className="App">
      <header className="App-header">
        <div style={{ position: 'absolute', top: 15, right: 15 }}>
          <button className="input-common input-small" onClick={toggleSettings}>
            {showSettings ? 'Hide Settings' : 'Show Settings'}
          </button>
        </div>
        {showSettings ? (
          isLoadingSettings ? (
            <div className="settings-menu">
              <p>Loading settings...</p>
            </div>
          ) : (
            <div className="settings-menu">
              <div className="model-provider-selector">
                <select
                  value={model}
                  onChange={handleModelChange}
                  className="input-common input-small"
                >
                  {/* <optgroup label="Google">
                    <option value="gemini-1.5-pro">Gemini 1.5 Pro</option>
                    <option value="gemini-1.5-flash-latest">Gemini 1.5 Flash</option>
                  </optgroup> */}
                  <optgroup label="OpenAI">
                    <option value="gpt-4-turbo-preview">GPT-4 Turbo</option>
                    <option value="gpt-4">GPT-4</option>
                    <option value="gpt-4o">GPT-4o</option>
                    <option value="gpt-4o-mini">GPT-4o-mini</option>
                    <option value="gpt-3.5-turbo">GPT-3.5 Turbo</option>
                  </optgroup>
                  {/* <optgroup label="Groq">
                    <option value="llama2-70b-4096">LLaMA2 70B</option>
                    <option value="mixtral-8x7b-32768">Mixtral 8x7B</option>
                  </optgroup>
                  <option value="custom">Custom</option> */}
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
                <select
                  value={provider}
                  onChange={handleProviderChange}
                  className="input-common input-small"
                >
                  {/* <option value="google">Google</option> */}
                  <option value="openai">OpenAI</option>
                  {/* <option value="groq">Groq</option> */}
                  {/* <option value="custom">Custom</option> */}
                </select>
              </div>
              <input
                type="password"
                value={apiKey}
                onChange={handleApiKeyChange}
                placeholder="Enter API Key"
                className="input-common input-small"
              />
              <button className="input-common input-small" onClick={handleExportLogs}>
                Export Logs
              </button>
              <button className="input-common input-small" onClick={handleClearLogs}>
                Clear Logs
              </button>
            </div>
          )
        ) : !isLoading ? (
          apiKey.length > 5 ? (
            <>
              <img src={logo} className="App-logo" alt="logo" />
              <p>HELLO! I AM CLICKOLAS CAGE!</p>
              <textarea
                ref={promptRef}
                placeholder="Add event x to google calendar"
                className="input-common input-large expandable-textarea"
                onChange={handleTextareaChange}
                rows="1"
              />
              <input
                onClick={async () => {
                  console.log('submit clicked.')
                  if (promptRef.current.value.trim().length === 0) return
                  sendMessageToBackgroundScript({
                    type: 'new_goal',
                    prompt: promptRef.current.value,
                  })
                  setIsLoading(true)
                }}
                type="button"
                value="Submit"
                className="input-common input-large"
              />
              <button
                className="input-common input-small"
                style={{ marginTop: 15 }}
                onClick={async () => {
                  const prompt =
                    "Create a google calendar event for august 12 labeled 'Win Gemini Competition'"
                  promptRef.current.value = prompt
                  console.log('submit clicked.')
                  sendMessageToBackgroundScript({ type: 'new_goal', prompt })
                  setIsLoading(true)
                }}
              >
                Quick Add Event
              </button>
            </>
          ) : (
            <p>Please enter an API key in settings </p>
          )
        ) : (
          <p>Thinking...</p>
        )}
      </header>
    </div>
  )
}

export default Popup
