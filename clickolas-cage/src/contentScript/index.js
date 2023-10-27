import OpenAI from 'openai'

console.info('contentScript is running')

let div = document.createElement('div')
div.id = 'test-div'
div.style.position = 'absolute'
div.style.bottom = '100px'
div.style.minWidth = '100px'
div.style.maxWidth = '500px'
div.style.minHeight = '100px'
div.style.position = 'sticky'
div.style.backgroundColor = 'grey'
document.body.appendChild(div)

const openai = new OpenAI({
  apiKey: import.meta.env.VITE_OPENAI_API_KEY, // defaults to process.env[""]
  dangerouslyAllowBrowser: true,
})

const runFlow = async (prompt) => {
  let response = ''
  setLLMThoughts('thinking...')
  let plan = await sendPromptToPlanner(prompt)
  console.log(plan.split(/(?<=\d\.)/))
  setLLMPlan(plan.split(/(?<=\d\.)/)[1])
  while (response.indexOf('```javascript') === -1)
    response = await sendPromptToOpenAI(plan.split(/(?<=\d\.)/)[1])
  setLLMThoughts(response.slice(0, response.indexOf('```javascript')))
  const start = response.indexOf('```javascript') + '```javascript'.length
  const end = response.indexOf('```', start + 1)
  const codeSnippet = response.slice(start, end)
  console.log('EXECUTE: ' + codeSnippet)

  // // chrome.tabs.create({ url: 'http://127.0.0.1:8000' }, function (tab) {})
  // chrome.tabs.onCreated.addListener(function (tabId, changeInfo, tab) {
  //   console.log('yoooo')
  //   alert('HELLO WORLD')
  // })
  // chrome.tabs.onUpdated.addListener(function (tabId, changeInfo, tab) {
  //   console.log('yoooo2')
  //   // make sure the status is 'complete' and it's the right tab
  //   if (tab.url.indexOf('127.0.0.1:8000') != -1 && changeInfo.status == 'complete') {
  //     // chrome.tabs.executeScript(null, {
  //     //   code: codeSnippet,
  //     // })
  //   }
  // })
  // chrome.runtime.sendMessage("test");
}

const sendPromptToPlanner = async (prompt) => {
  console.log(prompt)
  console.log('thinking...')
  const chatCompletion = await openai.chat.completions.create({
    model: 'gpt-4',
    messages: [
      {
        role: 'system',
        content: `you are an expert web browsing AI with the following functions available:
        1. Navigate to a URL (Codename: NAVURL({url}))
        2. Click a button (Codename: CLICKBTN({buttonId}))
        3. Input text (Codename: INPUT({fieldId},{textToInput}))
        4. Select an option in a form (Codename: SELECT({fieldId},{option}))
        5. Wait for page load and inspect contents of page (Codename: WAITLOAD())
        6. Ask the user for more information (Codename: ASKUSER({question})
        given a prompt from the user provide a step by step plan to execute it in a web browser only utilizing the 6 functions above using the relative codenames.
        if you are unsure of URL, Ask the user. if you are unsure of IDs wait for page load.`,
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

const executePlan = async (plan) => {
  const actions = plan.split('\n')
  for (let i = 0; i < actions.length; i++) {
    const action = actions[i]
    console.log(action, "action");
    const actionParts = action.split('(')
    const actionParams = actionParts[1]?.slice(0, -1).split(',')
    const keywords = ['NAVURL', 'CLICKBTN', 'INPUT', 'SELECT', 'WAITLOAD', 'ASKUSER']
    const regex = new RegExp(keywords.join('|'), 'g')
    const matches = action.match(regex)
    const actionName = matches[0];

    switch (actionName) {
      case 'NAVURL':
        console.log(`Navigating to URL: ${actionParams[0]}`)
        window.location.href = actionParams[0]
        await new Promise((r) => (window.onload = r))
        break
      case 'CLICKBTN':
        console.log(`Clicking button with ID: ${actionParams[0]}`)
        document.getElementById(actionParams[0]).click()
        await new Promise((r) => (window.onload = r))
        break
      case 'INPUT':
        console.log(`Inputting text: ${actionParams[1]} into field with ID: ${actionParams[0]}`)
        document.getElementById(actionParams[0]).value = actionParams[1]
        await new Promise((r) => (window.onload = r))
        break
      case 'SELECT':
        console.log(`Selecting option: ${actionParams[1]} in field with ID: ${actionParams[0]}`)
        document.getElementById(actionParams[0]).value = actionParams[1]
        await new Promise((r) => (window.onload = r))
        break
      case 'WAITLOAD':
        console.log('Waiting for page to load')
        await new Promise((r) => (window.onload = r))
        console.log('Page is fully loaded')
        break
      case 'ASKUSER':
        console.log(`Asking user the following question: ${actionParams[0]}`)
        prompt(actionParams[0])
        break
      default:
        console.log('Unknown action: ' + actionName)
    }
  }
}

chrome.runtime.onMessage.addListener(async (request, sender, sendResponse) => {
  // This block will handle incoming messages
  console.log('Received message:', request)
  div.innerText = 'Thinking...'
  executePlan(await sendPromptToPlanner(request.prompt))
})
