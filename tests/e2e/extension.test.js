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
    const extensionPath = path.join(__dirname, '../../dist');
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
    await page.goto('chrome-extension://EXTENSION_ID/popup.html');
    const title = await page.$eval('h2', el => el.textContent);
    expect(title).toBe("What's today's Plan?");
  });

  // Add more tests here
});