import React, { useRef, useState, useEffect } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
import { sendMessageToBackgroundScript } from '../utils'
import { exportLogs, clearLogs } from '../llm-utils'
import { DEFAULT_MODEL, DEFAULT_PROVIDER } from '../config.js'

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
  const [model, setModel] = useState(DEFAULT_MODEL)
  const [provider, setProvider] = useState(DEFAULT_PROVIDER)
  const [customModel, setCustomModel] = useState('')
  const [showSettings, setShowSettings] = useState(false)
  const [apiKeys, setApiKeys] = useState({
    google: '',
    openai: '',
    groq: '',
    custom: ''
  })
  const [isLoadingSettings, setIsLoadingSettings] = useState(true)
  const [isListening, setIsListening] = useState(true) // Changed to true
  const [transcript, setTranscript] = useState('') // Add this line

  const recognitionRef = useRef(null)

  useEffect(() => {
    const loadModelAndProvider = async () => {
      try {
        setIsLoadingSettings(true)
        const response = await new Promise((resolve) => {
          chrome.runtime.sendMessage({ type: 'getModelAndProvider' }, resolve);
        });
        if (response && response.currentModel && response.currentProvider) {
          setModel(response.currentModel)
          setProvider(response.currentProvider)
          setApiKeys(response.apiKeys || {
            google: '',
            openai: '',
            groq: '',
            custom: ''
          })
        } else {
          console.error('Invalid response from background script:', response)
          // Set default values if the response is invalid
          setModel(DEFAULT_MODEL)
          setProvider(DEFAULT_PROVIDER)
        }
      } catch (error) {
        console.error('Error loading model and provider:', error)
        // Set default values if there's an error
        setModel(DEFAULT_MODEL)
        setProvider(DEFAULT_PROVIDER)
      } finally {
        setIsLoadingSettings(false)
      }
    }
    loadModelAndProvider()
  }, [])

  useEffect(() => {
    // Initialize speech recognition
    if ('webkitSpeechRecognition' in window) {
      const SpeechRecognition = window.webkitSpeechRecognition
      recognitionRef.current = new SpeechRecognition()
      recognitionRef.current.continuous = true
      recognitionRef.current.interimResults = true

      recognitionRef.current.onresult = (event) => {
        const currentTranscript = Array.from(event.results)
          .map(result => result[0].transcript)
          .join('')
        setTranscript(currentTranscript)
        if (promptRef.current) {
          promptRef.current.value = currentTranscript
          handleTextareaChange({ target: promptRef.current })
        }
      }

      recognitionRef.current.onerror = (event) => {
        console.error('Speech recognition error', event.error)
        setIsListening(false)
      }

      recognitionRef.current.onend = () => {
        setIsListening(false)
      }

      // Start listening immediately
      recognitionRef.current.start()
    }

    // Add global keydown event listener
    const handleGlobalKeyDown = (e) => {
      if (e.key === 'Enter' && !e.shiftKey && !showSettings && !isLoading) {
        e.preventDefault();
        handleSubmit();
      }
    };

    document.addEventListener('keydown', handleGlobalKeyDown);

    return () => {
      document.removeEventListener('keydown', handleGlobalKeyDown);
      if (recognitionRef.current) {
        recognitionRef.current.stop()
      }
    }
  }, [showSettings, isLoading]) // Add dependencies

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
    const newApiKeys = { ...apiKeys, [provider]: e.target.value };
    setApiKeys(newApiKeys);
    sendMessageToBackgroundScript({
      type: 'updateModelAndProvider',
      model: model === 'custom' ? customModel : model,
      provider,
      apiKeys: newApiKeys,
    })
  }

  const handleTextareaChange = (e) => {
    e.target.style.height = 'auto'
    e.target.style.height = `${e.target.scrollHeight}px`
  }

  const toggleSettings = () => {
    setShowSettings(!showSettings)
  }

  const toggleListening = () => {
    if (isListening) {
      recognitionRef.current.stop()
    } else {
      recognitionRef.current.start()
    }
    setIsListening(!isListening)
  }

  const handleSubmit = async () => {
    console.log('submit clicked.')
    if (promptRef.current.value.trim().length === 0) return
    sendMessageToBackgroundScript({ type: 'new_goal', prompt: promptRef.current.value })
    setIsLoading(true)
    setTranscript('') // Clear the transcript after submitting
  };

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
                  <optgroup label="Google">
                    <option value="gemini-1.5-pro">Gemini 1.5 Pro</option>
                    <option value="gemini-1.5-flash-latest">Gemini 1.5 Flash</option>
                  </optgroup>
                  <optgroup label="OpenAI">
                    <option value="gpt-4-turbo-preview">GPT-4 Turbo</option>
                    <option value="gpt-4">GPT-4</option>
                    <option value="gpt-4o">GPT-4o</option>
                    <option value="gpt-4o-mini">GPT-4o-mini</option>
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
                <select
                  value={provider}
                  onChange={handleProviderChange}
                  className="input-common input-small"
                >
                  <option value="google">Google</option>
                  <option value="openai">OpenAI</option>
                  <option value="groq">Groq</option>
                  <option value="custom">Custom</option>
                </select>
              </div>
              <input
                type="password"
                value={apiKeys[provider] || ''}
                onChange={handleApiKeyChange}
                placeholder={`Enter ${provider.toUpperCase()} API Key`}
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
          <>
            <img src={logo} className="App-logo" alt="logo" />
            <p>HELLO! I AM CLICKOLAS CAGE!</p>
            <div className="input-container">
              <textarea
                ref={promptRef}
                placeholder="Add event x to google calendar"
                className="input-common input-large expandable-textarea"
                onChange={handleTextareaChange}
                rows="1"
                value={transcript}
              />
              <button
                onClick={toggleListening}
                className={`input-common input-small microphone-button ${isListening ? 'listening' : ''}`}
              >
                {isListening ? 'Stop' : 'Start'} Listening
              </button>
            </div>
            <input
              onClick={handleSubmit}
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
                setTranscript(prompt) // Update transcript state
                console.log('submit clicked.')
                sendMessageToBackgroundScript({ type: 'new_goal', prompt })
                setIsLoading(true)
              }}
            >
              Quick Add Event
            </button>
          </>
        ) : (
          <p>Thinking...</p>
        )}
      </header>
    </div>
  )
}

export default Popup
