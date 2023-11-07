import OpenAI from 'openai'

const openai = new OpenAI({
  apiKey: import.meta.env.VITE_OPENAI_API_KEY, // defaults to process.env[""]
  dangerouslyAllowBrowser: true,
})

export const getNextAction = (plan, currentStep) => {
  console.log(plan, currentStep)
  try {
    if (currentStep > plan.split('\n').length) return null
    let currentTask = plan.split('\n')[currentStep]
    const actionParts = currentTask.split('(')
    const actionParams = actionParts[1]?.slice(0, -1).split(',')
    const keywords = ['NAVURL', 'CLICKBTN', 'INPUT', 'SELECT', 'WAITLOAD', 'ASKUSER']
    const regex = new RegExp(keywords.join('|'), 'g')
    const matches = currentTask.match(regex)
    if (matches) return { actionName: matches[0], actionParams, currentTask, currentStep }
    else getNextAction(plan, currentStep + 1)
  } catch (e) {
    getNextAction(plan, currentStep + 1)
  }
}

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
            param: "url" | "divId" | "question"
            param2?: "optionToSelect" | "textToInput"
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
  return chatCompletion.choices[0].message.content
  // return chatCompletion.choices[0].text.strip()
}
