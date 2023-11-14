import OpenAI from 'openai'

const openai = new OpenAI({
  apiKey: import.meta.env.VITE_OPENAI_API_KEY, // defaults to process.env[""]
  dangerouslyAllowBrowser: true,
})

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

export const sendPromptWithFeedback = async (
  originalPrompt,
  originalPlan,
  currentStep,
  feedback,
) => {
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4-1106-preview',
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
    action: "NAVURL" | "CLICKBTN" | "INPUT" | "SELECT" | "WAITLOAD" | "ASKUSER",
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
  })
  console.log(chatCompletion.choices[0].message.content)
  return chatCompletion.choices[0].message.content
}

export const sendPromptToPlanReviser = async (
  originalPrompt,
  originalPlan,
  currentStep,
  textOptions,
) => {
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4-1106-preview',
    temperature: 0,
    seed: 1,
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
    action: "NAVURL" | "CLICKBTN" | "INPUT" | "SELECT" | "WAITLOAD" | "ASKUSER",
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
  })
  console.log(chatCompletion.choices[0].message.content)
  return chatCompletion.choices[0].message.content
}

export const sendPromptToPlanner = async (prompt) => {
  // make an event in my google calendar on friday 12pm labeled "hello world"
  console.log('thinking about it...')
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4-1106-preview',
    temperature: 0,
    seed: 1,
    response_format: { type: 'json_object' },
    messages: [
      {
        role: 'system',
        content: `you are an expert web browsing AI given a prompt from the user provide a step by step plan to execute it in a web browser.
if you are unsure of URL, Ask the user. if you are unsure of IDs wait for page load.
ALWAYS start with NAVURL. Provide response with this JSON schema:
{
  plan: [ {
    action: "NAVURL" | "CLICKBTN" | "INPUT" | "SELECT" | "WAITLOAD" | "ASKUSER",
    ariaLabel: "labelName",
    param?: "url" | "inputOption" | "inputText"
  },...]
}
`,
      },
      {
        role: 'user',
        content: `your first task is: ${prompt}`,
      },
    ],
  })
  console.log(chatCompletion.choices[0].message.content)
  return chatCompletion.choices[0].message.content
  // return chatCompletion.choices[0].text.strip()
}
