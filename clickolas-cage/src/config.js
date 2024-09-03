import { getSettings } from './utils'

// Default values for model, provider, and speech recognition
// These values can be overwritten by user settings stored in chrome storage
let DEFAULT_MODEL = 'meta-llama/llama-3.1-8b-instruct:free'
let DEFAULT_SPEECH_RECOGNITION = true

// Function to initialize config values from storage
// This function updates the default values with user settings if available
async function initializeConfig() {
  try {
    const settings = await getSettings()
    // Update default values with user settings if they exist
    DEFAULT_MODEL = settings.currentModel || DEFAULT_MODEL
    DEFAULT_SPEECH_RECOGNITION = settings.speechRecognitionEnabled ?? DEFAULT_SPEECH_RECOGNITION
  } catch (error) {
    console.error('Error initializing config:', error)
  }
}

// Initialize config when this module is imported
initializeConfig()

export { DEFAULT_MODEL, DEFAULT_SPEECH_RECOGNITION }
