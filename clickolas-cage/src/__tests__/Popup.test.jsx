import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, fireEvent, act } from '@testing-library/react';
import Popup from '../Popup';
import { chrome } from '@mocks/chrome';
import ReactDOM from 'react-dom/client';

// Mock the chrome API
vi.mock('@mocks/chrome', () => ({
  chrome: {
    runtime: {
      sendMessage: vi.fn(),
    },
  },
}));

// Mock the imported functions and constants
vi.mock('../utils', () => ({
  sendMessageToBackgroundScript: vi.fn(),
}));
vi.mock('../llm-utils', () => ({
  exportLogs: vi.fn(),
  clearLogs: vi.fn(),
}));
vi.mock('../config.js', () => ({
  DEFAULT_MODEL: 'gpt-4-turbo-preview',
  DEFAULT_PROVIDER: 'openai',
  DEFAULT_SPEECH_RECOGNITION: true,
}));

// Mock SpeechRecognition
const mockSpeechRecognition = {
  start: vi.fn(),
  stop: vi.fn(),
  addEventListener: vi.fn(),
};
global.webkitSpeechRecognition = vi.fn(() => mockSpeechRecognition);

// Update this mock
vi.mock('react-dom/client', () => ({
  default: {
    createRoot: vi.fn(() => ({
      render: vi.fn(),
    })),
  },
}));

describe('Popup Component', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    chrome.runtime.sendMessage.mockImplementation((message, callback) => {
      if (message.type === 'getSettings') {
        callback({
          currentModel: 'gpt-4-turbo-preview',
          currentProvider: 'openai',
          apiKeys: { openai: 'test-key' },
          speechRecognitionEnabled: true,
        });
      }
    });

    // Add this to reset the document body before each test
    document.body.innerHTML = '<div id="app"></div>';
  });

  it('renders without crashing', async () => {
    render(<Popup />);
    expect(ReactDOM.default.createRoot).toHaveBeenCalled();
    expect(await screen.findByText("What's today's Plan?")).toBeInTheDocument();
  });

  it('toggles settings visibility', async () => {
    render(<Popup />);
    const settingsButton = await screen.findByText('Show Settings');
    await act(async () => {
      fireEvent.click(settingsButton);
    });
    expect(screen.getByText('Model Settings')).toBeInTheDocument();
  });

  it('handles model change', async () => {
    render(<Popup />);
    await act(async () => {
      fireEvent.click(await screen.findByText('Show Settings'));
      fireEvent.change(screen.getByRole('combobox', { name: '' }), { target: { value: 'gemini-1.5-pro' } });
    });
    expect(chrome.runtime.sendMessage).toHaveBeenCalledWith(
      expect.objectContaining({ type: 'updateModelAndProvider', model: 'gemini-1.5-pro', provider: 'google' }),
      expect.any(Function)
    );
  });

  it('handles custom model input', async () => {
    render(<Popup />);
    await act(async () => {
      fireEvent.click(await screen.findByText('Show Settings'));
      fireEvent.change(screen.getByRole('combobox', { name: '' }), { target: { value: 'custom' } });
      const customModelInput = screen.getByPlaceholderText('Enter custom model');
      fireEvent.change(customModelInput, { target: { value: 'my-custom-model' } });
    });
    expect(chrome.runtime.sendMessage).toHaveBeenCalledWith(
      expect.objectContaining({ type: 'updateModelAndProvider', model: 'my-custom-model' }),
      expect.any(Function)
    );
  });

  it('handles provider change', async () => {
    render(<Popup />);
    await act(async () => {
      fireEvent.click(await screen.findByText('Show Settings'));
      const providerSelect = screen.getAllByRole('combobox')[1];
      fireEvent.change(providerSelect, { target: { value: 'google' } });
    });
    expect(chrome.runtime.sendMessage).toHaveBeenCalledWith(
      expect.objectContaining({ type: 'updateModelAndProvider', provider: 'google' }),
      expect.any(Function)
    );
  });

  it('handles API key change', async () => {
    render(<Popup />);
    await act(async () => {
      fireEvent.click(await screen.findByText('Show Settings'));
      const apiKeyInput = screen.getByPlaceholderText('Enter OPENAI API Key');
      fireEvent.change(apiKeyInput, { target: { value: 'new-api-key' } });
    });
    expect(chrome.runtime.sendMessage).toHaveBeenCalledWith(
      expect.objectContaining({
        type: 'updateModelAndProvider',
        apiKeys: expect.objectContaining({ openai: 'new-api-key' })
      }),
      expect.any(Function)
    );
  });

  it('handles speech recognition toggle', async () => {
    render(<Popup />);
    await act(async () => {
      fireEvent.click(await screen.findByText('Show Settings'));
      const speechToggle = screen.getByRole('checkbox');
      fireEvent.click(speechToggle);
    });
    expect(chrome.runtime.sendMessage).toHaveBeenCalledWith(
      expect.objectContaining({ type: 'updateSettings', speechRecognitionEnabled: false }),
      expect.any(Function)
    );
  });

  it('handles submit button click', async () => {
    const { sendMessageToBackgroundScript } = await import('../utils');
    render(<Popup />);
    await act(async () => {
      const textarea = await screen.findByPlaceholderText('Add event x to google calendar');
      fireEvent.change(textarea, { target: { value: 'Test prompt' } });
      fireEvent.click(screen.getByText('Submit'));
    });
    expect(sendMessageToBackgroundScript).toHaveBeenCalledWith({ type: 'new_goal', prompt: 'Test prompt' });
  });

  it('handles quick add button click', async () => {
    const { sendMessageToBackgroundScript } = await import('../utils');
    render(<Popup />);
    await act(async () => {
      fireEvent.click(await screen.findByText('Quick Add Event'));
    });
    expect(sendMessageToBackgroundScript).toHaveBeenCalledWith({
      type: 'new_goal',
      prompt: "Create a google calendar event for august 12 labeled 'Win Gemini Competition'"
    });
  });

  // Add more tests as needed for other functionalities
});
