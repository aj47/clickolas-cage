// dom-utils.js

export function navURL(url) {
  console.log(url, 'url')
  //Needs http otherwise does not go to absolute URL
  if (url.indexOf('http') !== 0) {
    url = 'http://' + url
  }
  return new Promise((resolve, reject) => {
    chrome.tabs.update({ url: url }, (tab) => {
      if (chrome.runtime.lastError) {
        // If there's an error during tab creation, reject the promise
        reject(new Error(chrome.runtime.lastError))
      } else {
        resolve(tab.id) // Resolve the promise with the tab object
      }
    })
  })
}
