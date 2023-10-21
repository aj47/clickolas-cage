import React from "react";
import logo from "../../assets/img/logo.png";
import Greetings from "../../containers/Greetings/Greetings";
import "./Popup.css";

const Popup = () => {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>HELLO! I AM CLICKOLAS CAGE!</p>
        <input type="text" placeholder="Add event x to my google calendar" />
        <input type="button" Value="Submit"/>
      </header>
    </div>
  );
};

export default Popup;
