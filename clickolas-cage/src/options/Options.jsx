import { useState, useEffect } from 'react'

import './Options.css'

export const Options = () => {
  const [llmProvider, setLlmProvider] = useState('')
  const [apiKey, setApiKey] = useState('')

  useEffect(() => {
    // Retrieve the current settings from chrome.storage.local
    chrome.storage.local.get(['llmProvider', 'apiKey'], (result) => {
      if (result.llmProvider && result.apiKey) {
        setLlmProvider(result.llmProvider)
        setApiKey(result.apiKey)
      }
    })
  }, [])

  const saveOptions = () => {
    // Save the LLM provider and API key to chrome.storage.local
    chrome.storage.local.set({ llmProvider, apiKey }, () => {
      console.log('Options saved.')
    })
  }

  return (
    <main>
      <h3>Options Page</h3>
      <div>
        <label htmlFor="llmProvider">LLM Provider:</label>
        <input
          id="llmProvider"
          type="text"
          value={llmProvider}
          onChange={(e) => setLlmProvider(e.target.value)}
        />
      </div>
      <div>
        <label htmlFor="apiKey">API Key:</label>
        <input
          id="apiKey"
          type="text"
          value={apiKey}
          onChange={(e) => setApiKey(e.target.value)}
        />
      </div>
      <button onClick={saveOptions}>Save</button>
    </main>
  )
}

export default Options
