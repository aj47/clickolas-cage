console.log('background is running')
chrome.runtime.onMessage.addListener((request) => {
  sendPromptToPlanner(request);
})
