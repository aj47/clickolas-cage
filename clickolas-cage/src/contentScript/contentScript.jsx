import React from 'react'
import ReactDOM from 'react-dom'
import SidePanel from '../sidepanel/SidePanel'

// --- We only allow content script to execute on tabs created by background script
chrome.runtime.sendMessage({ action: 'checkTab' }, function (response) {
  if (response.isAllowed) {
    console.log('content script executed')
    const root = document.createElement('div')
    root.id = 'crx-root'
    document.body.append(root)

    ReactDOM.render(
      <React.StrictMode>
        <SidePanel />
      </React.StrictMode>,
      root,
    )
  }
})
