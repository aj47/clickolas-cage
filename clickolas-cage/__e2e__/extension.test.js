import { describe, test, expect, beforeAll, afterAll } from 'vitest';
import puppeteer from 'puppeteer';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

describe('Chrome Extension', () => {
  let browser;
  let page;

  beforeAll(async () => {
    const extensionPath = path.join(__dirname, '..');
    browser = await puppeteer.launch({
      headless: false,
      args: [
        `--disable-extensions-except=${extensionPath}`,
        `--load-extension=${extensionPath}`,
      ],
    });
    page = await browser.newPage();
  });

  afterAll(async () => {
    await browser.close();
  });

  test('Extension popup opens', async () => {
    // This test might need to be adjusted based on how your extension works
    await page.goto('chrome://extensions');
    // Add your test logic here
    expect(true).toBe(true); // Placeholder assertion
  });
});
