import React, { useRef, useState, useEffect } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
import { sendMessageToBackgroundScript } from '../utils'
import { exportLogs, clearLogs } from '../llm-utils'
import { DEFAULT_MODEL, DEFAULT_PROVIDER, DEFAULT_SPEECH_RECOGNITION } from '../config.js'

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
  const [speechRecognitionEnabled, setSpeechRecognitionEnabled] = useState(DEFAULT_SPEECH_RECOGNITION)
  const [error, setError] = useState(null) // Add this line

  const recognitionRef = useRef(null)

  useEffect(() => {
    const loadSettings = async () => {
      try {
        setIsLoadingSettings(true)
        const response = await new Promise((resolve) => {
          chrome.runtime.sendMessage({ type: 'getSettings' }, resolve);
        });
        if (response) {
          setModel(response.currentModel || DEFAULT_MODEL)
          setProvider(response.currentProvider || DEFAULT_PROVIDER)
          setApiKeys(response.apiKeys || {
            google: '',
            openai: '',
            groq: '',
            custom: ''
          })
          setSpeechRecognitionEnabled(response.speechRecognitionEnabled ?? DEFAULT_SPEECH_RECOGNITION)
        } else {
          console.error('Invalid response from background script:', response)
          setError('Invalid response from background script')
          setModel(DEFAULT_MODEL)
          setProvider(DEFAULT_PROVIDER)
          setSpeechRecognitionEnabled(DEFAULT_SPEECH_RECOGNITION)
        }
      } catch (error) {
        console.error('Error loading settings:', error)
        setError('Error loading settings')
        setModel(DEFAULT_MODEL)
        setProvider(DEFAULT_PROVIDER)
        setSpeechRecognitionEnabled(DEFAULT_SPEECH_RECOGNITION)
      } finally {
        setIsLoadingSettings(false)
      }
    }
    loadSettings()

    const handleErrorMessage = (message) => {
      if (message.type === 'error') {
        setError(message.message)
      }
    }

    chrome.runtime.onMessage.addListener(handleErrorMessage)

    return () => {
      chrome.runtime.onMessage.removeListener(handleErrorMessage)
    }
  }, [])

  useEffect(() => {
    // Initialize speech recognition
    if ('webkitSpeechRecognition' in window && speechRecognitionEnabled) {
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
  }, [showSettings, isLoading, speechRecognitionEnabled]) // Add dependencies

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

  const handleSpeechRecognitionToggle = async () => {
    const newValue = !speechRecognitionEnabled
    setSpeechRecognitionEnabled(newValue)
    await sendMessageToBackgroundScript({
      type: 'updateSettings',
      speechRecognitionEnabled: newValue,
    })
  }

  return (
    <div className="App">
      <header className="App-header">
        <div className="content-container">
          <button className="settings-toggle" onClick={toggleSettings}>
            {showSettings ? 'Hide Settings' : 'Show Settings'}
          </button>
          {showSettings ? (
            isLoadingSettings ? (
              <div className="settings-menu">
                <p>Loading settings...</p>
              </div>
            ) : (
              <div className="settings-menu">
                <h3>Model Settings</h3>
                <div className="model-provider-selector">
                  <select
                    value={model}
                    onChange={handleModelChange}
                  >
                    <optgroup label="Google">
                      <option value="gemini-1.5-pro">Gemini 1.5 Pro</option>
                      <option value="gemini-1.5-flash-latest">Gemini 1.5 Flash</option>
                    </optgroup>
                    <optgroup label="OpenAI">
                      <option value="gpt-4-turbo-preview">GPT-4 Turbo</option>
                      <option value="gpt-4o">GPT-4o</option>
                      <option value="gpt-4o-mini">GPT-4o-mini</option>
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
                    />
                  )}
                  <select
                    value={provider}
                    onChange={handleProviderChange}
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
                />
                {/* <h3>Log Management</h3>
                <button onClick={handleExportLogs}>
                  Export Logs
                </button>
                <button onClick={handleClearLogs}>
                  Clear Logs
                </button> */}
                <div className="setting-row">
                  <label htmlFor="speech-recognition-toggle">
                    Enable Speech Recognition on Load:
                  </label>
                  <input
                    id="speech-recognition-toggle"
                    type="checkbox"
                    checked={speechRecognitionEnabled}
                    onChange={handleSpeechRecognitionToggle}
                  />
                </div>
              </div>
            )
          ) : !isLoading ? (
            <>
              <img src={logo} className="App-logo" alt="logo" />
              <h2>What's today's Plan?</h2>
              <div className="input-container">
                <textarea
                  ref={promptRef}
                  placeholder="Add event x to google calendar"
                  className="expandable-textarea"
                  onChange={handleTextareaChange}
                  rows="1"
                  value={transcript}
                />
                <button
                  onClick={toggleListening}
                  className={`microphone-button ${isListening ? 'listening' : ''}`}
                >
                  {isListening ? 'Stop' : 'Start'} Listening
                </button>
              </div>
              <button
                onClick={handleSubmit}
                className="submit-button"
              >
                Submit
              </button>
              <button
                className="quick-add-button"
                onClick={async () => {
                  const prompt =
                    "Create a google calendar event for august 12 labeled 'Win Gemini Competition'"
                  promptRef.current.value = prompt
                  setTranscript(prompt)
                  console.log('submit clicked.')
                  sendMessageToBackgroundScript({ type: 'new_goal', prompt })
                  setIsLoading(true)
                }}
              >
                Quick Add Event
              </button>
            </>
          ) : (
            <>
              <p>Thinking...</p>
              {error && <p style={{ color: 'red' }}>{error}</p>} {/* Add this line */}
            </>
          )}
        </div>
      </header>
    </div>
  )
}

export default Popup
