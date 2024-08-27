discord: https://discord.gg/wD3Ufgmj


[view short explanation](https://www.youtube.com/watch?v=HVevc5XnKJU)
[more video](https://youtu.be/JKBv1uUnrSk)

# clickolas-cage

> a chrome extension that performs web browsing actions autonomously to complete a given goal/task (using LLM as a brain).
)



## Installing

1. Check if your `Node.js` version is >= **14**.
2. To install the dependencies:
```shell
cd clickolas-cage
npm install
```
3. replace your GEMINI api key in `.env.template` and rename the file  to `.env`

## Developing

run these commands to run everything locally:
```shell
cd clickolas-cage

npm run dev
```
and in a seperate terminal:
```shell
npx @portkey-ai/gateway
```
This runs the chrome extension locally.

To link the running extension to chrome:
1. set your Chrome browser 'Developer mode' on
2. click 'Load unpacked', and select `clickolas-cage/build` folder

The main source files are:
- `src/popup/popup.jsx` The popup window that shows when you press the extension icon
- `src/background/background.js` Persists and facilitates planning
- `src/contentScript/contentScript.js` Executes on web pages, executes actions and scrapes elements
- `src/utils.js` Helper functions
- `src/llm-utils.js` LLM helper functions

### Current Flow
1. User clicks extension icon, enters and submits goal prompt
2. Popup.jsx sends a message to background.js with request type 'new_goal'
3. background.js calls promptToFirstStep() in llm-utils.js
4. LLM returns starting URL which feeds into navURL()
5. navURL will open a new tab with the starting URL
6. getNextStep() is called which will get contentScript to extract clickable elements and send it to LLM to generate next step




## Packing

After the development of your extension run the command

```shell
$ npm run build
```

Now, the content of `build` folder will be the extension ready to be submitted to the Chrome Web Store. Just take a look at the [official guide](https://developer.chrome.com/webstore/publish) to more infos about publishing.

---

## Using Clickolas Cage

### Opening the Extension

There are two ways to open the Clickolas Cage extension:

1. Click on the extension icon in your Chrome toolbar.
2. Use the keyboard shortcut: 
   - Windows/Linux: `Ctrl+Shift+L`
   - Mac: `Command+Shift+L`

### How to Use

1. Once the extension popup opens, you'll see a text area where you can enter your goal or task.
2. You can type your goal directly or use the speech-to-text feature:
   - Click the "Start Listening" button to activate speech recognition.
   - Speak your goal clearly.
   - Click "Stop Listening" when you're done.
3. Click the "Submit" button or press Enter to start the automation process.
4. A side panel will appear on the webpage, showing the steps Clickolas Cage is taking to complete your task.
5. You can interact with the side panel to provide additional input or stop the execution if needed.

### API Keys

To use Clickolas Cage, you'll need to provide API keys for the language models. The extension supports multiple providers:

1. Click the "Show Settings" button in the popup.
2. Select your desired model and provider.
3. Enter the corresponding API key in the input field.

Supported providers:
- Google (Gemini models)
- OpenAI (GPT models)
- Groq (LLaMA and Mixtral models)
- Custom (for other providers)

Make sure to keep your API keys secure and never share them publicly.

---

### Sidepanel Controls

Once Clickolas Cage starts executing your task, a sidepanel will appear on the right side of the webpage. This panel provides the following controls and information:

1. **Minimize/Maximize**: Click the '▼' or '▲' button in the top-right corner to minimize or maximize the sidepanel.

2. **Drag and Move**: You can click and drag the top bar of the sidepanel to reposition it on the page.

3. **Message List**: The main area of the sidepanel displays messages, including:
   - Steps being executed
   - User inputs
   - System messages
   - Completion messages

4. **Stop Execution**: When Clickolas Cage is actively executing a task, a "Stop Execution" button will appear. Click this to halt the current operation.

5. **Input Area**: When not executing, you'll see an input field where you can:
   - Type additional instructions or queries
   - Use voice input for hands-free interaction

6. **Voice Input**: 
   - Click the "Voice" button or use the keyboard shortcut (Ctrl+Shift+K) to start/stop voice recognition.
   - When active, it will display "Stop" and the button will highlight.
   - Speak your instruction clearly, then click "Stop" or use the shortcut again to submit.

7. **Send Button**: Click "Send" or press Enter to submit your typed or voice-transcribed input.

The sidepanel allows you to monitor the progress of your task, provide additional input when needed, and control the execution of Clickolas Cage directly from the webpage.

---

