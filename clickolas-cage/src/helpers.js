import OpenAI from 'openai'

const openai = new OpenAI({
  apiKey: import.meta.env.VITE_OPENAI_API_KEY, // defaults to process.env[""]
  dangerouslyAllowBrowser: true,
})

export const sendMessageToBackgroundScript = async (prompt) => {
  chrome.runtime.sendMessage(prompt, function (response) {
    console.log(response)
  })
}

export const sendMessageToContentScript = async (prompt, tabId = null) => {
  console.log('send message to CS', prompt)
  chrome.tabs.query({ active: true, currentWindow: true }, function (tabs) {
    console.log(tabs, 'tabs')
    chrome.tabs.sendMessage(tabs[0].id, prompt)
  })
}

export const sendPromptToElementLocator = async (
  originalPrompt,
  originalPlan,
  currentStep,
  textOptions,
) => {
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4-1106-preview',
    response_format: { type: 'json_object' },
    messages: [
      {
        role: 'system',
        content: `you are an expert web browsing AI. you were given the prompt:"${originalPrompt}"
        you came up with the plan:
        "${originalPlan}
        We are at this step of the plan :
        ${currentStep}
          but have encountered an issue finding the specified ID.
          given an array of text elements, select one element which could be ID we are looking for.
        provide a response with this JSON schema:
        {
          selectedText: "textOptionSelected"
        } `,
      },
      {
        role: 'user',
        content: `options: ${textOptions}`,
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
            param: "url" | "divId" | "question" | "inputId-textToInput" | "optionId-optionToSelect"
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
