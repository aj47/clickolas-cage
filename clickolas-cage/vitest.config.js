import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import path from 'path';

export default defineConfig({
  plugins: [react()],
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./vitest.setup.js'],
    include: [
      '**/src/__tests__/**/*.{test,spec}.{js,jsx,ts,tsx}'
    ],
    exclude: [
      '**/node_modules/**',
      '**/dist/**',
      '**/cypress/**',
      '**/.{idea,git,cache,output,temp}/**',
      '**/__e2e__/**',
      '**/*.e2e.{spec,test}.{js,jsx,ts,tsx}',
      '**/clickolas-cage/__tests__/**' // Exclude the old test files
    ],
    alias: {
      '@': path.resolve(__dirname, './src'),
      '@mocks': path.resolve(__dirname, './__mocks__')
    }
  },
});
