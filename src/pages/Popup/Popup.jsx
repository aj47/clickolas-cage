import React, { useRef } from "react";
import logo from "../../assets/img/logo.png";
import Greetings from "../../containers/Greetings/Greetings";
import "./Popup.css";
import OpenAI from "openai";

// const openaiInstance = new OpenAI({
//   apiKey: "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", // defaults to process.env["OPENAI_API_KEY"]
// });


const sendPromptToOpenAI = async (prompt) => {
  const chatCompletion = await openaiInstance.chat.completions.create({
    model: "gpt-4",
    messages: [
      {
        role: "user",
        content: `I want to provide step by step single commands to be inputted into a chrome console to achieve the following task : ${prompt}.
        First only provide the command to which URL to navigate to. then I will provide the DOM elements you can interact with, afterwards provide a command to interact with the dom and we will continue this process until the task is achieved`,
      },
    ],
    stream: true,
  });
  console.log(chatCompletion);
  // return response.choices[0].text.strip();
};

const Popup = () => {
  const promptRef = useRef(null);
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>HELLO! I AM CLICKOLAS CAGE!</p>
        <input
          ref={promptRef}
          type="text"
          placeholder="Add event x to my google calendar"
        />
        <input
          onClick={() => {
            sendPromptToOpenAI(e.target.value);
          }}
          type="button"
          value="Submit"
        />
      </header>
    </div>
  );
};

export default Popup;
