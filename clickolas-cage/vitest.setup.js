import '@testing-library/jest-dom';
import { expect, vi } from 'vitest';
import { chrome } from './__mocks__/chrome';

// Mock Chrome API
vi.mock('chrome', () => chrome);

// Mock OpenAI and Portkey
vi.mock('openai');
vi.mock('portkey-ai');

// Extend Vitest's expect with jest-dom matchers
expect.extend(await import('@testing-library/jest-dom/matchers'));
