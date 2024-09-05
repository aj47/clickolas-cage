import React, { useRef, useState, useEffect } from 'react'
import logo from '../assets/logo.png'
import './Popup.css'
import { sendMessageToBackgroundScript } from '../utils'
import { exportLogs, clearLogs } from '../llm-utils'
import { DEFAULT_MODEL, DEFAULT_SPEECH_RECOGNITION } from '../config.js'

const handleExportLogs = () => {
  exportLogs()
}

const handleClearLogs = () => {
  clearLogs()
}

const SearchableDropdown = ({ options, value, onChange, placeholder }) => {
  const [isOpen, setIsOpen] = useState(false)
  const [search, setSearch] = useState('')
  const dropdownRef = useRef(null)

  const selectedOption = options.find(option => option.id === value) || { name: '' }

  const filteredOptions = options.filter((option) =>
    option.name.toLowerCase().includes(search.toLowerCase()),
  )

  useEffect(() => {
    const handleClickOutside = (event) => {
      if (dropdownRef.current && !dropdownRef.current.contains(event.target)) {
        setIsOpen(false)
      }
    }

    document.addEventListener('mousedown', handleClickOutside)
    return () => {
      document.removeEventListener('mousedown', handleClickOutside)
    }
  }, [])

  return (
    <div className="searchable-dropdown" ref={dropdownRef}>
      <input
        type="text"
        value={isOpen ? search : selectedOption.name}
        onChange={(e) => setSearch(e.target.value)}
        onFocus={() => {
          setIsOpen(true)
          setSearch('')
        }}
        onBlur={() => setTimeout(() => setIsOpen(false), 200)}
        placeholder={placeholder}
      />
      {isOpen && (
        <ul className="dropdown-list">
          {filteredOptions.map((option) => (
            <li
              key={option.id}
              onClick={() => {
                onChange(option.id)
                setSearch(option.name)
                setIsOpen(false)
              }}
            >
              <div className="model-info">
                <span className="model-name">{option.name}</span>
                <span className="model-stats">
                  {option.pricing && typeof option.pricing.prompt === 'string' &&
                   typeof option.pricing.completion === 'string' &&
                   `$${parseFloat(option.pricing.prompt).toFixed(6)} / ${parseFloat(option.pricing.completion).toFixed(6)} | `}
                  {option.context_length && `${option.context_length} tokens`}
                </span>
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  )
}

const Popup = () => {
  const promptRef = useRef(null)
  const [isLoading, setIsLoading] = useState(false)
  const [model, setModel] = useState(DEFAULT_MODEL)
  const [apiKey, setApiKey] = useState('')
  const [showSettings, setShowSettings] = useState(false)
  const [isLoadingSettings, setIsLoadingSettings] = useState(true)
  const [isListening, setIsListening] = useState(true)
  const [transcript, setTranscript] = useState('')
  const [speechRecognitionEnabled, setSpeechRecognitionEnabled] = useState(
    DEFAULT_SPEECH_RECOGNITION,
  )
  const [error, setError] = useState(null)
  const [availableModels, setAvailableModels] = useState([])

  const recognitionRef = useRef(null)

  const initializeSpeechRecognition = () => {
    if ('webkitSpeechRecognition' in window && speechRecognitionEnabled) {
      const SpeechRecognition = window.webkitSpeechRecognition
      recognitionRef.current = new SpeechRecognition()
      recognitionRef.current.continuous = true
      recognitionRef.current.interimResults = true

      recognitionRef.current.onresult = (event) => {
        const currentTranscript = Array.from(event.results)
          .map((result) => result[0].transcript)
          .join('')
        setTranscript(currentTranscript)
        if (promptRef.current) {
          promptRef.current.value = currentTranscript
        }
      }

      recognitionRef.current.onerror = (event) => {
        console.error('Speech recognition error', event.error)
        setIsListening(false)
      }

      recognitionRef.current.onend = () => {
        setIsListening(false)
      }
    }
  }

  useEffect(() => {
    const loadSettings = async () => {
      try {
        setIsLoadingSettings(true)
        const response = await new Promise((resolve) => {
          chrome.runtime.sendMessage({ type: 'getSettings' }, resolve)
        })
        if (response) {
          const savedModel = response.currentModel || DEFAULT_MODEL
          setModel(savedModel)
          setApiKey(response.apiKey || '')
          setSpeechRecognitionEnabled(
            response.speechRecognitionEnabled ?? DEFAULT_SPEECH_RECOGNITION,
          )

          // Fetch available models
          if (response.apiKey) {
            fetchAvailableModels(response.apiKey)
          }
        } else {
          console.error('Invalid response from background script:', response)
          setError('Invalid response from background script')
          setModel(DEFAULT_MODEL)
          setSpeechRecognitionEnabled(DEFAULT_SPEECH_RECOGNITION)
        }
      } catch (error) {
        console.error('Error loading settings:', error)
        setError('Error loading settings')
        setModel(DEFAULT_MODEL)
        setSpeechRecognitionEnabled(DEFAULT_SPEECH_RECOGNITION)
      } finally {
        setIsLoadingSettings(false)
      }
    }
    loadSettings()

    const handleErrorMessage = (message) => {
      if (message.type === 'error') {
        setError(message.message)
        setIsLoading(false)
      }
    }

    chrome.runtime.onMessage.addListener(handleErrorMessage)

    return () => {
      chrome.runtime.onMessage.removeListener(handleErrorMessage)
      setIsListening(false)
    }
  }, [])

  useEffect(() => {
    initializeSpeechRecognition()

    const handleGlobalKeyDown = (e) => {
      if (e.key === 'Enter' && !e.shiftKey && !showSettings && !isLoading) {
        e.preventDefault()
        handleSubmit()
      }
    }

    document.addEventListener('keydown', handleGlobalKeyDown)

    return () => {
      document.removeEventListener('keydown', handleGlobalKeyDown)
      if (recognitionRef.current) {
        recognitionRef.current.stop()
        recognitionRef.current = null
      }
      setIsListening(false)
    }
  }, [])

  useEffect(() => {
    if (isListening && recognitionRef.current) {
      try {
        recognitionRef.current.start()
      } catch (error) {
        console.error('Error starting speech recognition:', error)
        setIsListening(false)
      }
    } else if (!isListening && recognitionRef.current) {
      recognitionRef.current.stop()
    }
  }, [isListening, speechRecognitionEnabled])

  const fetchAvailableModels = async (apiKey) => {
    try {
      const response = await new Promise((resolve) => {
        chrome.runtime.sendMessage({ type: 'fetchModels', apiKey }, resolve)
      })
      if (response && response.models) {
        setAvailableModels(response.models)
      }
    } catch (error) {
      console.error('Error fetching models:', error)
      setError('Error fetching models')
    }
  }

  const handleModelChange = async (selectedModelId) => {
    setModel(selectedModelId)
    await sendMessageToBackgroundScript({
      type: 'updateModelAndApiKey',
      model: selectedModelId,
      apiKey,
    })
  }

  const handleApiKeyChange = (e) => {
    const newApiKey = e.target.value
    setApiKey(newApiKey)
    sendMessageToBackgroundScript({
      type: 'updateModelAndApiKey',
      model,
      apiKey: newApiKey,
    })
    fetchAvailableModels(newApiKey)
  }

  const handleTextareaChange = (e) => {
    setTranscript(e.target.value)
    e.target.style.height = 'auto'
    e.target.style.height = `${e.target.scrollHeight}px`
  }

  const toggleSettings = () => {
    setShowSettings(!showSettings)
  }

  const toggleListening = () => {
    if (isListening) {
      setIsListening(false)
    } else {
      initializeSpeechRecognition()
      setIsListening(true)
    }
  }

  const handleSubmit = async () => {
    console.log('submit clicked.')
    if (promptRef.current.value.trim().length === 0) return
    sendMessageToBackgroundScript({ type: 'new_goal', prompt: promptRef.current.value })
    setIsLoading(true)
    setTranscript('')
  }

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
                <div className="model-selector">
                  <SearchableDropdown
                    options={availableModels}
                    value={model}
                    onChange={handleModelChange}
                    placeholder="Select or search for a model"
                  />
                </div>
                <input
                  type="password"
                  value={apiKey}
                  onChange={handleApiKeyChange}
                  placeholder="Enter OpenRouter API Key"
                />
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
              {error && <p style={{ color: 'red' }}>{error}</p>}
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
              <button onClick={handleSubmit} className="submit-button">
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
            </>
          )}
        </div>
      </header>
    </div>
  )
}

export default Popup
