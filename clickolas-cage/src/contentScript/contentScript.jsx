import React from 'react'
import ReactDOM from 'react-dom'
import SidePanel from "../sidepanel/SidePanel"

console.log("yo");
const root = document.createElement('div')
root.id = 'crx-root'
document.body.append(root)

ReactDOM.render(
  <React.StrictMode>
    <SidePanel/>
  </React.StrictMode>,
  root,
)
