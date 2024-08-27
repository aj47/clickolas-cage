import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, fireEvent, act } from '@testing-library/react';
import SidePanel from '../sidepanel/SidePanel'; // Update this line
import { chrome } from '@mocks/chrome';

// Mock the chrome API
vi.mock('@mocks/chrome', () => ({
  chrome: {
    runtime: {
      getURL: vi.fn().mockReturnValue('mocked-url/logo-48.png'),
      onMessage: {
        addListener: vi.fn(),
      },
    },
  },
}));

// Mock the utils functions
vi.mock('../utils', () => ({
  runFunctionXTimesWithDelay: vi.fn(),
  sendMessageToBackgroundScript: vi.fn(),
  sleep: vi.fn(),
}));

// Update the mock for ReactDOM
vi.mock('react-dom/client', () => ({
  default: {
    createRoot: vi.fn(() => ({
      render: vi.fn(),
    })),
  },
  createRoot: vi.fn(() => ({
    render: vi.fn(),
  })),
}));

// Add this before your tests
const mockSpeechRecognition = {
  start: vi.fn(),
  stop: vi.fn(),
  addEventListener: vi.fn(),
};

global.webkitSpeechRecognition = vi.fn(() => mockSpeechRecognition);

describe('SidePanel', () => {
  beforeEach(() => {
    // Clear all mocks before each test
    vi.clearAllMocks();

    // Add this to mock the document.getElementById
    document.body.innerHTML = '<div id="app"></div>';

    // Mock chrome.runtime.onMessage.addListener
    chrome.runtime.onMessage.addListener.mockImplementation((listener) => {
      listener({}, {}, vi.fn()); // Use vi.fn() instead of () => {}
      return true; // Indicate that the response is asynchronous
    });
  });

  it('renders the Clickolas Cage title', () => {
    render(<SidePanel />);
    const titleElement = screen.getByText('Clickolas Cage');
    expect(titleElement).toBeInTheDocument();
  });

  it('toggles minimize state when minimize button is clicked', () => {
    render(<SidePanel />);
    const minimizeButton = screen.getByText('▼');
    fireEvent.click(minimizeButton);
    expect(screen.getByText('▲')).toBeInTheDocument();
    fireEvent.click(minimizeButton);
    expect(screen.getByText('▼')).toBeInTheDocument();
  });

  it('handles user input and sends message to background script', async () => {
    const { sendMessageToBackgroundScript } = await import('../utils');
    render(<SidePanel />);
    const input = screen.getByPlaceholderText('Type your message...');
    const sendButton = screen.getByText('Send');

    await act(async () => {
      fireEvent.change(input, { target: { value: 'Test message' } });
      fireEvent.click(sendButton);
    });

    expect(sendMessageToBackgroundScript).toHaveBeenCalledWith(expect.objectContaining({
      type: 'user_message',
      message: 'Test message',
    }));
  });

  it('toggles listening state when voice input button is clicked', () => {
    render(<SidePanel />);
    const voiceButton = screen.getByText('Voice (Ctrl+Shift+K)');
    fireEvent.click(voiceButton);
    expect(screen.getByText('Send (Ctrl+Shift+K)')).toBeInTheDocument();
    fireEvent.click(voiceButton);
    expect(screen.getByText('Voice (Ctrl+Shift+K)')).toBeInTheDocument();
  });

  it('shows stop execution button when isExecuting is true', async () => {
    const { rerender } = render(<SidePanel />);
    expect(screen.queryByText('Stop Execution')).not.toBeInTheDocument();

    // Simulate execution started
    await act(async () => {
      chrome.runtime.onMessage.addListener.mock.calls[0][0]({ type: 'execution_started' });
    });

    rerender(<SidePanel />);
    expect(screen.getByText('Stop Execution')).toBeInTheDocument();
  });

  it('handles stop execution when stop button is clicked', async () => {
    const { sendMessageToBackgroundScript } = await import('../utils');
    render(<SidePanel />);

    // Simulate execution started
    await act(async () => {
      chrome.runtime.onMessage.addListener.mock.calls[0][0]({ type: 'execution_started' });
    });

    const stopButton = screen.getByText('Stop Execution');
    fireEvent.click(stopButton);

    expect(sendMessageToBackgroundScript).toHaveBeenCalledWith({
      type: 'stop_execution',
    });
  });

  it('updates messages when new messages are received', async () => {
    render(<SidePanel />);

    await act(async () => {
      chrome.runtime.onMessage.addListener.mock.calls[0][0]({
        plan: [{ thought: 'Step 1' }, { thought: 'Step 2' }],
        currentStep: 1,
      },
      {},
      vi.fn() // Use vi.fn() here
      );
    });

    expect(screen.getByText('1 - Step 1')).toBeInTheDocument();
    expect(screen.getByText('2 - Step 2')).toBeInTheDocument();
  });

  it('handles locateElement request', async () => {
    render(<SidePanel />);

    // Add a test element to the DOM
    const testElement = document.createElement('div');
    testElement.setAttribute('aria-label', 'Test Label');
    document.body.appendChild(testElement);

    // Simulate locateElement request
    await act(async () => {
      const mockSendResponse = vi.fn();
      chrome.runtime.onMessage.addListener.mock.calls[0][0]({
        type: 'locateElement',
        ariaLabel: 'Test Label',
        action: 'CLICKBTN',
      }, null, mockSendResponse);

      expect(mockSendResponse).toHaveBeenCalledWith(expect.objectContaining({
        type: 'element_not_found',
        ariaLabel: 'Test Label',
        elements: expect.any(Array),
        focusedElement: expect.objectContaining({
          role: 'BODY',
          tabIndex: -1,
        }),
      }));
    });
  });

  it('handles showClick request', async () => {
    render(<SidePanel />);

    // Simulate showClick request
    await act(async () => {
      const mockSendResponse = vi.fn();
      chrome.runtime.onMessage.addListener.mock.calls[0][0]({
        type: 'showClick',
        x: 100,
        y: 100,
      }, null, mockSendResponse);

      expect(mockSendResponse).toHaveBeenCalledWith({ type: 'completed_task' });
    });

    // Check if the click indicator was added to the DOM
    const clickIndicator = document.querySelector('img[src="mocked-url/logo-48.png"]');
    expect(clickIndicator).not.toBeNull();
    expect(clickIndicator.style.left).toBe('83px');
    expect(clickIndicator.style.top).toBe('83px');
  });
});
