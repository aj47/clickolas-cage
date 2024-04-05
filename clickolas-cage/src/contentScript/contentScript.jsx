import React from 'react';
import { createRoot } from 'react-dom/client'; // Import createRoot
import SidePanel from '../sidepanel/SidePanel';

chrome.runtime.sendMessage({ type: 'checkTabAllowed' }, function (response) {
  console.log(response, "response");
  if (response.isAllowed) {
    console.log('content script executed');
    const rootDiv = document.createElement('div');
    rootDiv.id = 'crx-root';
    document.body.appendChild(rootDiv);

    const root = createRoot(rootDiv); // Use createRoot
    root.render(
      <React.StrictMode>
        <SidePanel />
      </React.StrictMode>
    );
  }
});
