import { defineManifest } from '@crxjs/vite-plugin'
const packageData = require('../package.json');

export default defineManifest({
  name: packageData.name,
  description: packageData.description,
  version: packageData.version,
  manifest_version: 3,
  icons: {
    16: 'img/logo-16.png',
    32: 'img/logo-34.png',
    48: 'img/logo-48.png',
    128: 'img/logo-128.png',
  },
  action: {
    default_popup: 'popup.html',
    default_icon: 'img/logo-48.png',
  },
  options_page: 'options.html',
  devtools_page: 'devtools.html',
  background: {
    service_worker: 'src/background/background.js',
    type: 'module',
  },
  content_scripts: [
    {
      matches: ['http://*/*', 'https://*/*'],
      js: ['src/contentScript/contentScript.jsx'],
      media: [],
    },
  ],
  side_panel: {
    default_path: 'sidepanel.html',
  },
  web_accessible_resources: [
    {
      resources: ['img/logo-*.png'],
      matches: ['<all_urls>']
    },
  ],
  permissions: ['activeTab', 'sidePanel', 'storage', 'debugger', 'scripting'],
  commands: {
    "open-extension": {
      suggested_key: {
        default: "Ctrl+Shift+L",
        mac: "Command+Shift+L"
      },
      description: "Open the extension"
    }
  }
  // chrome_url_overrides: {
  //   newtab: 'newtab.html',
  // },
})
