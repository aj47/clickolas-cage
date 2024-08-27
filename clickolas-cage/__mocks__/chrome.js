import { vi } from 'vitest';

export const chrome = {
  runtime: {
    onMessage: {
      addListener: vi.fn(),
    },
  },
  // Add other Chrome APIs as needed
};

global.chrome = chrome;
