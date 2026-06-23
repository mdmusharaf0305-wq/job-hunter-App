const fs = require('fs');
const path = require('path');

let token = '';
try {
  const envPath = 'F:\\CodeArea\\job-command-center\\.env.local';
  if (fs.existsSync(envPath)) {
    const lines = fs.readFileSync(envPath, 'utf8').split('\n');
    for (const line of lines) {
      const trimmed = line.trim();
      if (trimmed.startsWith('NOTION_TOKEN=')) {
        token = trimmed.split('NOTION_TOKEN=')[1].trim().replace(/['"]/g, '');
      }
    }
  }
} catch (e) {
  console.log("Error reading env file", e.message);
}

async function inspectPage(pageId) {
  const res = await fetch(`https://api.notion.com/v1/pages/${pageId}`, {
    headers: {
      'Authorization': `Bearer ${token}`,
      'Notion-Version': '2022-06-28'
    }
  });
  const page = await res.json();
  console.log(JSON.stringify(page, null, 2));
}

async function start() {
  console.log("Inspecting 4bell:");
  await inspectPage('3755bede-0c3a-807d-85bb-ddd9cad17b7b');
}

start();
