import OpenAI from 'openai'

const openai = new OpenAI({
  apiKey: 'not-needed', // defaults to process.env[""]
  // apiKey: import.meta.env.VITE_OPENAI_API_KEY, // defaults to process.env[""]
  baseURL: 'http://localhost:1234/v1',
  dangerouslyAllowBrowser: true,
})

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

export const sendMessageToBackgroundScript = async (prompt) => {
  chrome.runtime.sendMessage(prompt, function (response) {
    // console.log(response)
  })
}

export const sendMessageToContentScript = async (prompt, tabId = null) => {
  console.log('send message to CS', prompt)
  chrome.tabs.query({ active: true, currentWindow: true }, function (tabs) {
    console.log(tabs, 'tabs')
    chrome.tabs.sendMessage(tabs[0].id, prompt)
  })
}

async function openaiCallWithRetry(call, retryCount = 3) {
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

export const sendPromptWithFeedback = async (
  originalPrompt,
  originalPlan,
  currentStep,
  feedback,
) => {
  const chatCompletion = await openaiCallWithRetry(() =>
    openai.chat.completions.create({
      model: 'gpt-3.5-turbo-1106',
      seed: 1,
      response_format: { type: 'json_object' },
      messages: [
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
      ],
    }),
  )
  console.log(chatCompletion.choices[0].message.content)
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

export const sendPromptToPlanReviser = async (
  originalPrompt,
  originalPlan,
  currentStep,
  textOptions,
) => {
  const chatCompletion = await openaiCallWithRetry(() =>
    openai.chat.completions.create({
      model: 'gpt-4-1106-preview',
      seed: 1,
      temperature: 0,
      response_format: { type: 'json_object' },
      messages: [
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
      ],
    }),
  )
  console.log(chatCompletion.choices[0].message.content)
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

export const sendPromptToPlanner = async (prompt, url, matchingRecipe) => {
  const chatCompletion = await openaiCallWithRetry(() =>
    openai.chat.completions.create({
      model: 'gpt-3.5-turbo-1106',
      seed: 1,
      temperature: 0,
      response_format: { type: 'json_object' },
      messages: [
        {
          role: 'system',
          content: `you are an expert web browsing AI.
given a user goal prompt devise a plan to achieve the goal.
Assume we are already on the URL: ${url} and give the following steps.
Provide the response with this JSON schema:
{
  plan: [ {
    thought: "one sentence rationale",
    action: "NAVURL" | "CLICKBTN" | "INPUT" | "SELECT" | "WAITLOAD" ,
    ariaLabel: "labelName",
    param?: "url" | "inputOption" | "inputText"
  },...]
}
`,
        },
        {
          role: 'user',
          content: `Your goal is: ${prompt}
${matchingRecipe && 'A working recipe is: ' + matchingRecipe}`,
        },
      ],
    }),
  )
  console.log(chatCompletion.choices[0].message.content)
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

export const checkCandidatePrompts = async (prompt, candidates) => {
  const chatCompletion = await openaiCallWithRetry(() =>
    openai.chat.completions.create({
      model: 'gpt-3.5-turbo-1106',
      seed: 1,
      temperature: 0,
      response_format: { type: 'json_object' },
      messages: [
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
      ],
    }),
  )
  console.log(chatCompletion.choices[0].message.content)
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

export const promptToFirstStep = async (prompt) => {
  const chatCompletion = await openaiCallWithRetry(() =>
    openai.chat.completions.create({
      model: 'gpt-3.5-turbo-1106',
      seed: 1,
      temperature: 0,
      response_format: { type: 'json_object' },
      messages: [
        {
          role: 'system',
          content: `you are an expert web browsing AI. given a prompt from the user provide the first step into achieving the goal.
This should be either the absolute URL if you are confident on the page the task should be completed on
OR a google search URL ('www.google.com/search?q=your+search+here')
alternatively you can ask the user for additional info if needed.
Provide response with this JSON schema:
{
    thought: "one sentence rationale",
    action: "NAVURL" ,
    param?: "url"
}
`,
        },
        {
          role: 'user',
          content: `user prompt: ${prompt}`,
        },
      ],
    }),
  )
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

export const getDomain = (url) => {
  try {
    const parsedUrl = new URL(url)
    return parsedUrl.hostname // Returns the domain along with the subdomain
  } catch (e) {
    console.error(e)
    return null // Returns null if the URL is invalid
  }
}
