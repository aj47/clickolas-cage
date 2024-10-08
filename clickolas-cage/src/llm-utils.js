import { SYSTEM_PROMPT_NEXT_STEP, SYSTEM_PROMPT_FIRST_STEP } from './prompts.js'
import { DEFAULT_MODEL } from './config.js'

let currentApiKey = null
let currentModel = DEFAULT_MODEL

export const initializeOpenAI = (apiKey, model) => {
  currentApiKey = apiKey
  currentModel = model
}

const openRouterChatCompletionWithLogging = async (messages) => {
  // ... (logging code remains the same)

  const response = await openRouterCallWithRetry(() =>
    fetch('https://openrouter.ai/api/v1/chat/completions', {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${currentApiKey}`,
        'HTTP-Referer': `${chrome.runtime.getURL('')}`,
        'X-Title': 'Clickolas Cage',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        model: currentModel,
        messages: messages,
        frequency_penalty: 0.5,
        seed: 1,
        response_format: { type: 'json_object' },
      }),
    }).then((res) => res.json()),
  )

  // ... (logging code remains the same)
  return response
}

/**
 * Extracts the first JSON object from a given string.
 * @param {string} str - The string to search for a JSON object.
 * @returns {Object|null} The parsed JSON object, or null if no valid JSON object is found.
 */
const extractJsonObject = (str) => {
  // Regular expression to match JSON objects
  const jsonRegex = /{(?:[^{}]|{(?:[^{}]|{[^{}]*})*})*}/g

  // Find the first match in the string
  const match = str.match(jsonRegex)

  if (match) {
    try {
      // Parse the matched string into a JSON object
      return JSON.parse(match[0])
    } catch (e) {
      // Handle parsing error
      console.error('Error parsing JSON: ', e)
      return null
    }
  } else {
    // No JSON found in the string
    return null
  }
}

/**
 * Makes an OpenAI API call with retry logic.
 * @param {Function} call - The OpenAI API call function to execute.
 * @param {number} [retryCount=3] - The number of times to retry the API call if it fails.
 * @returns {Promise} A promise that resolves with the response from the successful API call.
 */
async function openRouterCallWithRetry(call, retryCount = 3) {
  for (let i = 0; i < retryCount; i++) {
    try {
      const response = await call()
      if (response.error) {
        throw new Error(response.error.message)
      }
      return response
    } catch (error) {
      console.error(`Attempt ${i + 1} failed with error: ${error}`)
      if (i === retryCount - 1) {
        chrome.runtime.sendMessage({ type: 'error', message: error.message })
        throw error
      }
    }
  }
}

/**
 * Sends a prompt to the Plan Reviser to get a revised plan based on the current step and available text options.
 * @param {Object} currentState - The current state of the application.
 * @param {Object} request - The request object containing additional information.
 * @returns {Promise<Object>} - A promise that resolves to the revised plan in JSON format.
 */
export const getNextStepFromLLM = async (currentState, request) => {
  console.log('currentState', currentState, request)
  const systemPrompt = SYSTEM_PROMPT_NEXT_STEP(
    currentState.originalPrompt,
    currentState.currentURL,
    currentState.currentPlan,
  )

  let userContent = `nodes: ${JSON.stringify(
    request.elements,
  )}\n\nfocused element: ${JSON.stringify(request.focusedElement)}`
  if (request.ariaLabel) {
    userContent += `\n\nThe element with aria-label "${request.ariaLabel}" was not found. Please provide an alternative action or suggestion.`
  }
  if (request.message) {
    userContent += `\n\nUser message: ${request.message}`
  }

  const chatCompletion = await openRouterChatCompletionWithLogging([
    {
      role: 'system',
      content: systemPrompt,
    },
    {
      role: 'user',
      content: userContent,
    },
  ])
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

/**
 * Sends a prompt to the OpenAI API and returns the first step in achieving the goal as a URL or Google search URL.
 * @param {string} prompt - The user's prompt describing the goal.
 * @param {string} model - The current model.
 * @param {string} provider - The current provider.
 * @returns {Promise<object>} - A promise that resolves to an object containing the thought and URL parameter.
 */
export const promptToFirstStep = async (prompt, model, provider) => {
  const chatCompletion = await openRouterChatCompletionWithLogging([
    {
      role: 'system',
      content: SYSTEM_PROMPT_FIRST_STEP,
    },
    {
      role: 'user',
      content: `user prompt: ${prompt}`,
    },
  ])
  return extractJsonObject(chatCompletion.choices[0].message.content + '}')
}

/**
 * Exports the logs as a JSON file.
 */
export const exportLogs = () => {
  chrome.storage.local.get({ logs: [] }, (result) => {
    const logs = result.logs
    const blob = new Blob([JSON.stringify(logs, null, 2)], { type: 'application/json' })
    const url = URL.createObjectURL(blob)
    const a = document.createElement('a')
    a.href = url
    a.download = 'logs.json'
    a.click()
    URL.revokeObjectURL(url)
  })
}

/**
 * Clears the logs from Chrome storage.
 */
export const clearLogs = () => {
  chrome.storage.local.set({ logs: [] }, () => {
    console.log('Logs have been cleared.')
  })
}

export const fetchModels = async (apiKey) => {
  try {
    const response = await fetch('https://openrouter.ai/api/v1/models', {
      method: 'GET',
      headers: {
        Authorization: `Bearer ${apiKey}`,
        'HTTP-Referer': `${chrome.runtime.getURL('')}`,
        'X-Title': 'Clickolas Cage',
      },
    })
    const data = await response.json()
    return data.data
  } catch (error) {
    console.error('Error fetching models:', error)
    throw error
  }
}
