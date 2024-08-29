export const getDomain = (url) => {
  try {
    const parsedUrl = new URL(url)
    return parsedUrl.hostname // Returns the domain along with the subdomain
  } catch (e) {
    console.error(e)
    return null // Returns null if the URL is invalid
  }
}

export const sendMessageToBackgroundScript = async (prompt) => {
  console.log("send message to bg");
  chrome.runtime.sendMessage(prompt, function(response) {
    if (chrome.runtime.lastError) {
      console.error('Error sending message:', chrome.runtime.lastError.message);
    } else {
      console.log('Received response:', response);
    }
  });
}

export const sendMessageToContentScript = async (prompt, tabId = null) => {
  console.log('send message to CS', prompt)
  chrome.tabs.query({ active: true, currentWindow: true }, function (tabs) {
    console.log(tabs, 'tabs')
    chrome.tabs.sendMessage(tabs[0].id, prompt)
  })
}

/**
 * Pauses execution for a specified number of milliseconds.
 * @param {number} ms - The number of milliseconds to pause for.
 * @returns {Promise<void>} A promise that resolves after the specified delay.
 */
export const sleep = (ms) => {
  return new Promise((resolve) => setTimeout(resolve, ms))
}

// Function to run a specific function x times with a delay
export const runFunctionXTimesWithDelay = async (func, times, delay) => {
  return new Promise(async (resolve) => {
    // Wrap everything in a promise
    for (let i = 0; i < times; i++) {
      await func() // Call the function
      await sleep(delay) // Wait for the specified delay
    }
    resolve() // Resolve the promise when finished
  })
}

export function getSettings() {
  return new Promise((resolve) => {
    chrome.storage.sync.get(['currentModel', 'currentProvider', 'speechRecognitionEnabled'], (result) => {
      resolve({
        currentModel: result.currentModel,
        currentProvider: result.currentProvider,
        speechRecognitionEnabled: result.speechRecognitionEnabled
      })
    })
  })
}
