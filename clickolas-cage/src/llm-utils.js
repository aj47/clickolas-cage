import OpenAI from 'openai'
import { PORTKEY_GATEWAY_URL, createHeaders } from 'portkey-ai'

// Dynamically retrieve the API key and provider from chrome.storage.local
let apiKey = '';
let provider = '';

// Retrieve the LLM provider and API key settings before making API calls
chrome.storage.local.get(['llmProvider', 'apiKey'], function(result) {
  apiKey = result.apiKey;
  provider = result.llmProvider;
});

const model = 'gemini-1.5-flash-latest'

const openai = new OpenAI({
  apiKey: apiKey, // Use the dynamically retrieved API key
  baseURL: 'http://localhost:8787/v1',
  dangerouslyAllowBrowser: true,
  defaultHeaders: createHeaders({
    provider: provider, // Use the dynamically retrieved provider
  }),
})

const extractJsonObject = (str) => {
  const jsonRegex = /{(?:[^{}]|{(?:[^{}]|{[^{}]*})*})*}/g
  const match = str.match(jsonRegex)

  if (match) {
    try {
      return JSON.parse(match[0])
    } catch (e) {
      console.error('Error parsing JSON: ', e)
      return null
    }
  } else {
    return null
  }
}

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

export const sendPromptWithFeedback = async (
  originalPrompt,
  originalPlan,
  currentStep,
  feedback,
) => {
  const chatCompletion = await openAiCallWithRetry(() =>
    openai.chat.completions.create({
      model: model,
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

export const getNextStepFromLLM = async (
  originalPrompt,
  originalPlan,
  currentStep,
  textOptions,
) => {
  console.log(originalPlan, 'originalPlan')
  console.log(textOptions, 'textOptions')
  const chatCompletion = await openAiCallWithRetry(() =>
    openai.chat.completions.create({
      model: model,
      seed: 1,
      temperature: 0,
      response_format: { type: 'json_object' },
      messages: [
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
      ],
    }),
  )
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

export const sendPromptToPlanReviser = async (
  originalPrompt,
  originalPlan,
  currentStep,
  textOptions,
) => {
  const chatCompletion = await openAiCallWithRetry(() =>
    openai.chat.completions.create({
      model: model,
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

export const sendPromptToPlanner = async (prompt, url) => {
  const chatCompletion = await openAiCallWithRetry(() =>
    openai.chat.completions.create({
      model: model,
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
      ],
    }),
  )
  console.log(chatCompletion.choices[0].message.content)
  return extractJsonObject(chatCompletion.choices[0].message.content)
}

export const checkCandidatePrompts = async (prompt, candidates) => {
  const chatCompletion = await openAiCallWithRetry(() =>
    openai.chat.completions.create({
      model: model,
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
  const chatCompletion = await openAiCallWithRetry(() =>
    openai.chat.completions.create({
      model: model,
      stop: '}',
      temperature: 0.2,
      response_format: { type: 'json_object' },
      messages: [
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
      ],
    }),
  )
  return extractJsonObject(chatCompletion.choices[0].message.content + '}') // because it is not included when supplying the "stop" property
}
