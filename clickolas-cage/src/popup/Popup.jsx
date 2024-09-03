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

const Popup = () => {
  const promptRef = useRef(null)
  const [isLoading, setIsLoading] = useState(false)
  const [model, setModel] = useState(DEFAULT_MODEL)
  const [apiKey, setApiKey] = useState('')
  const [showSettings, setShowSettings] = useState(false)
  const [isLoadingSettings, setIsLoadingSettings] = useState(true)
  const [isListening, setIsListening] = useState(true)
  const [transcript, setTranscript] = useState('')
  const [speechRecognitionEnabled, setSpeechRecognitionEnabled] = useState(DEFAULT_SPEECH_RECOGNITION)
  const [error, setError] = useState(null)

  const recognitionRef = useRef(null)

  const initializeSpeechRecognition = () => {
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
          chrome.runtime.sendMessage({ type: 'getSettings' }, resolve);
        });
        if (response) {
          setModel(response.currentModel || DEFAULT_MODEL)
          setApiKey(response.apiKey || '')
          setSpeechRecognitionEnabled(response.speechRecognitionEnabled ?? DEFAULT_SPEECH_RECOGNITION)
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
      setIsListening(false);
    }
  }, [])

  useEffect(() => {
    initializeSpeechRecognition()

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
        recognitionRef.current = null
      }
      setIsListening(false);
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

  const handleModelChange = async (e) => {
    const selectedModel = e.target.value
    setModel(selectedModel)
    await sendMessageToBackgroundScript({
      type: 'updateModelAndApiKey',
      model: selectedModel,
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
                <div className="model-selector">
                  <select value={model} onChange={handleModelChange}>
                    <optgroup label="OpenAI">
                      <option value="openai/gpt-4o">GPT-4o</option>
                      <option value="openai/gpt-4">GPT-4</option>
                      <option value="openai/gpt-4-32k">GPT-4 32k</option>
                    </optgroup>
                    <optgroup label="Anthropic">
                    </optgroup>
                    <optgroup label="Google">
                      <option value="google/gemini-pro">Gemini Pro</option>
                    </optgroup>
                    <optgroup label="Meta">
                      <option value="meta/llama-2-70b-chat">LLaMA v2 70B</option>
                      <option value="meta-llama/llama-3.1-8b-instruct:free">LLaMA 3.1 8B Instruct (Free)</option>
                    </optgroup>
                  </select>
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
            </>
          )}
        </div>
      </header>
    </div>
  )
}

export default Popup
