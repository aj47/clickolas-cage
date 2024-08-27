import { defineConfig } from 'vite';

export default defineConfig({
  test: {
    environment: 'node',
    include: ['**/__e2e__/**/*.{js,jsx}', '**/*.e2e.{spec,test}.{js,jsx}'],
  },
});
