import OpenAI from 'openai'
import { PORTKEY_GATEWAY_URL, createHeaders } from 'portkey-ai'
const model = 'gemini-1.5-flash-latest'

const openai = new OpenAI({
  // apiKey: 'not-needed', // defaults to process.env[""]
  apiKey: import.meta.env.VITE_GEMINI_API_KEY, // defaults to process.env[""]
  // apiKey: "",
  baseURL: 'http://localhost:8787/v1',
  dangerouslyAllowBrowser: true,
  defaultHeaders: createHeaders({
    provider: 'google',
  }),
})

/**
 * Wrapper function for OpenAI chat completion calls with logging.
 * @param {Object} messages - The messages payload to send to the OpenAI API.
 * @returns {Promise<Object>} - The response from the OpenAI API.
 */
const openAiChatCompletionWithLogging = async (messages) => {
  chrome.storage.local.get({ logs: [] }, (result) => {
    const logs = result.logs
    logs.push({ messages })
    chrome.storage.local.set({ logs })
  })
  return openAiCallWithRetry(() =>
    openai.chat.completions.create({
      model: model,
      seed: 1,
      response_format: { type: 'json_object' },
      messages: messages,
    }),
  )
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
async function openAiCallWithRetry(call, retryCount = 3) {
  for (let i = 0; i < retryCount; i++) {
    try {
      const response = await call()
      return response
    } catch (error) {
      console.error(`Attempt ${i + 1} failed with error: ${error}`)
      if (i === retryCount - 1) throw error
    }
  }
}

/**
 * Sends a prompt to the OpenAI API with user feedback and returns a revised plan.
 * @param {string} originalPrompt - The original prompt given to the AI.
 * @param {string} originalPlan - The original plan generated by the AI.
 * @param {string} currentStep - The current step of the plan being executed.
 * @param {string} feedback - User feedback on the current step.
 * @returns {Promise<Object>} A revised plan based on the user feedback.
 */
export const sendPromptWithFeedback = async (
  originalPrompt,
  originalPlan,
  currentStep,
  feedback,
) => {
  const chatCompletion = await openAiChatCompletionWithLogging([
    {
      role: 'system',
      content: `you are an expert web browsing AI. you were given the original prompt:"${originalPrompt}"
you originally came up with the plan:
${originalPlan}
We currently just tried to execute step of the plan :
${currentStep}
  given user feedback, come up with a revised plan from the current step.
  Provide a response with this JSON schema:
{
  plan: [ {
    thought: "one sentence rationale",
    action: "NAVURL" | "CLICKBTN" | "INPUT" | "SELECT" | "WAITLOAD" ,
    ariaLabel: "labelName",
    param?: "url" | "inputOption" | "inputText"
  },...]
} `,
    },
    {
      role: 'user',
      content: `user has answered the question with ${feedback}`,
    },
  ])
  console.log(chatCompletion.choices[0].message.content)
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

/**
 * Sends a prompt to the Plan Reviser to get a revised plan based on the current step and available text options.
 * @param {string} originalPrompt - The original prompt given to the AI.
 * @param {string} originalPlan - The original plan created by the AI.
 * @param {string} currentStep - The current step being executed.
 * @param {any[]} textOptions - An array of user-provided node aria-labels.
 * @returns {Promise<Object>} - A promise that resolves to the revised plan in JSON format.
 */
export const getNextStepFromLLM = async (
  originalPrompt,
  originalPlan,
  currentStep,
  textOptions,
) => {
  console.log(originalPlan, 'originalPlan')
  console.log(textOptions, 'textOptions')
  const chatCompletion = await openAiChatCompletionWithLogging([
    {
      role: 'system',
      content: `you are an expert web browsing AI. you were given the original goal prompt:"${originalPrompt}"
This is the plan so far:
  ${JSON.stringify(originalPlan)}
we have just finished the final step and want to progress.
provide the next step of the plan to successfully achieve the goal and confirm it has been achieved.
the response should be in this JSON schema:
{
    "thought": "one sentence rationale",
    "action": "CLICKBTN" | "WAITLOAD" ,
    "ariaLabel": "ariaLabelValue",
}
make sure to use an EXACT aria label from the list of user provided labels
`,
    },
    {
      role: 'user',
      content: `nodes: ${JSON.stringify(textOptions)}`,
    },
  ])
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

/**
 * Sends a prompt to the Plan Reviser to get a revised plan based on the current step and available text options.
 * @param {string} originalPrompt - The original prompt given to the AI.
 * @param {string} originalPlan - The original plan created by the AI.
 * @param {string} currentStep - The current step being executed.
 * @param {string[]} textOptions - An array of user-provided node aria-labels.
 * @returns {Promise<Object>} - A promise that resolves to the revised plan in JSON format.
 */
export const sendPromptToPlanReviser = async (
  originalPrompt,
  originalPlan,
  currentStep,
  textOptions,
) => {
  const chatCompletion = await openAiChatCompletionWithLogging([
    {
      role: 'system',
      content: `you are an expert web browsing AI. you were given the original prompt:"${originalPrompt}"
you originally came up with the plan:
  ${originalPlan}
We currently just tried to execute step of the plan:
  ${currentStep}
but have encountered an issue finding the specified node with aria-label.
provide a revised plan continuing from the current step
the response should be in this JSON schema:
{
  plan: [ {
    thought: "one sentence rationale",
    action: "NAVURL" | "CLICKBTN" | "INPUT" | "SELECT" | "WAITLOAD" ,
    ariaLabel: "labelName",
    param?: "url" | "inputOption" | "inputText"
  },...]
}
ONLY use the following user provided nodes aria-labels:
`,
    },
    {
      role: 'user',
      content: `nodes: [${textOptions}]`,
    },
  ])
  console.log(chatCompletion.choices[0].message.content)
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

/**
 * Sends a prompt to the OpenAI chat completion API to generate a plan for achieving a user goal on a specific URL.
 * @param {string} prompt - The user goal prompt.
 * @param {string} url - The URL of the current page.
 * @returns {Promise<Object>} - A promise that resolves to the extracted JSON object containing the generated plan.
 */
export const sendPromptToPlanner = async (prompt, url) => {
  const chatCompletion = await openAiChatCompletionWithLogging([
    {
      role: 'system',
      content: `you are an expert web browsing AI.
given a user goal prompt devise a plan to achieve the goal.
Assume we are already on the URL: ${url} and give the following steps.
Provide the response with this JSON schema:
{
  plan: [ {
    "thought": "one sentence rationale",
    "action": "NAVURL" | "CLICKBTN" | "INPUT" | "SELECT" | "WAITLOAD" ,
    "ariaLabel": "labelName",
    "param"?: "url" | "inputOption" | "inputText"
  },...]
}
`,
    },
    {
      role: 'user',
      content: `Your goal is: ${prompt}`,
    },
  ])
  console.log(chatCompletion.choices[0].message.content)
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

/**
 * Checks if any candidate prompts match or closely align with a given goal prompt using OpenAI's chat completion API.
 * @param {string} prompt - The goal prompt to compare against candidate prompts.
 * @param {string[]} candidates - An array of candidate prompts to check for a match.
 * @returns {Promise<{match: string}>} A promise that resolves to an object with a 'match' property containing the matching candidate prompt or an empty string if no match is found.
 */
export const checkCandidatePrompts = async (prompt, candidates) => {
  const chatCompletion = await openAiChatCompletionWithLogging([
    {
      role: 'system',
      content: `Compare the following long goal prompt with the given list of smaller candidate prompts.
Determine if any of the smaller prompts match or closely align with the intention or key elements of the long goal prompt.
If a match is found, identify and return the matching smaller prompt.
Provide response in this JSON schema:
{
  match: "candidate prompt" | ""
}
`,
    },
    {
      role: 'user',
      content: `goal prompt: ${prompt}
candidate prompts: ${candidates}`,
    },
  ])
  console.log(chatCompletion.choices[0].message.content)
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

/**
 * Sends a prompt to the OpenAI API and returns the first step in achieving the goal as a URL or Google search URL.
 * @param {string} prompt - The user's prompt describing the goal.
 * @returns {Promise<object>} - A promise that resolves to an object containing the thought and URL parameter.
 */
export const promptToFirstStep = async (prompt) => {
  const chatCompletion = await openAiChatCompletionWithLogging([
    {
      role: 'system',
      content: `you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.
This should be either the absolute URL given
OR a google search URL ('www.google.com/search?q=your+search+here')
Provide response with this JSON schema:
{
    "thought": "one sentence rationale",
    "param": "url"
}
`,
    },
    {
      role: 'user',
      content: `user prompt: ${prompt}`,
    },
  ])
  return extractJsonObject(chatCompletion.choices[0].message.content + '}') // because it is not included when supplying the "stop" property
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
