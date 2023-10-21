import OpenAI from 'openai'
console.log('background is running')
const openai = new OpenAI({
  apiKey: import.meta.env.VITE_OPENAI_API_KEY, // defaults to process.env[""]
  dangerouslyAllowBrowser: true,
})

const sendPromptToPlanner = async (prompt) => {
  console.log(prompt)
  console.log('thinking...')
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4',
    messages: [
      {
        role: 'system',
        content: `you are an expert web browsing, given a prompt provide a step by step plan to execute it using google chrome, assume chrome is already open`,
      },
      {
        role: 'user',
        content: `your first task is: ${prompt}`,
      },
      // {
      //   role: 'user',
      //   content: `I want to provide step by step single commands to be inputted into a chrome console to achieve the following task : ${prompt}.
      //   First only provide the command to which URL to navigate to. then I will provide the DOM elements you can interact with, afterwards provide a command to interact with the dom and we will continue this process until the task is achieved`,
      // },
    ],
  })
  console.log(chatCompletion.choices[0].message.content)
  return chatCompletion.choices[0].message.content
  // return chatCompletion.choices[0].text.strip()
}
const sendPromptToOpenAI = async (prompt) => {
  console.log(prompt)
  console.log('thinking...')
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4',
    messages: [
      {
        role: 'system',
        content: `you are an expert Javascript AI interfacing with a chrome dev console,
        you will be given a task to be completed. respond in step by step processes of Javascript commands to complete ONLY one the following actions:
        1. navigate to a URL
        2. click a button
        3. input text`,
      },
      {
        role: 'user',
        content: `your first task is: ${prompt}`,
      },
      // {
      //   role: 'user',
      //   content: `I want to provide step by step single commands to be inputted into a chrome console to achieve the following task : ${prompt}.
      //   First only provide the command to which URL to navigate to. then I will provide the DOM elements you can interact with, afterwards provide a command to interact with the dom and we will continue this process until the task is achieved`,
      // },
    ],
  })
  console.log(chatCompletion.choices[0].message.content)
  return chatCompletion.choices[0].message.content
  // return chatCompletion.choices[0].text.strip()
}


chrome.runtime.onMessage.addListener((request) => {
  sendPromptToPlanner(request);
  // if (request.type === 'COUNT') {
  //   console.log('background has received a message from popup, and count is ', request?.count)
  // }
})
