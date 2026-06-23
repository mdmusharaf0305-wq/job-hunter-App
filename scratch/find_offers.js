const fs = require('fs');
const path = require('path');

let token = '';
let dbId = '';
try {
  const envPath = 'F:\\CodeArea\\job-command-center\\.env.local';
  if (fs.existsSync(envPath)) {
    const lines = fs.readFileSync(envPath, 'utf8').split('\n');
    for (const line of lines) {
      const trimmed = line.trim();
      if (trimmed.startsWith('NOTION_TOKEN=')) {
        token = trimmed.split('NOTION_TOKEN=')[1].trim().replace(/['"]/g, '');
      }
      if (trimmed.startsWith('OPPORTUNITIES_DB_ID=')) {
        dbId = trimmed.split('OPPORTUNITIES_DB_ID=')[1].trim().replace(/['"]/g, '');
      }
    }
  }
} catch (e) {
  console.log("Error reading env file", e.message);
}

function toUUID(id) {
  const clean = id.replace(/-/g, '');
  if (clean.length === 32) {
    return `${clean.slice(0,8)}-${clean.slice(8,12)}-${clean.slice(12,16)}-${clean.slice(16,20)}-${clean.slice(20)}`;
  }
  return id;
}

async function findOffers() {
  const uuid = toUUID(dbId);
  const res = await fetch(`https://api.notion.com/v1/databases/${uuid}/query`, {
    method: 'POST',
    headers: {
      'Authorization': `Bearer ${token}`,
      'Notion-Version': '2022-06-28',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({ page_size: 100 })
  });
  const data = await res.json();
  data.results.forEach(page => {
    const props = page.properties;
    let company = '';
    for (const key in props) {
      if (props[key].type === 'title') {
        company = props[key].title?.[0]?.plain_text || '';
      }
    }
    const statusVal = props.Status?.status?.name || '';
    if (statusVal.toLowerCase().includes('offer')) {
      console.log(`Company: ${company}, Status: ${statusVal}, ID: ${page.id}`);
    }
  });
}

findOffers();
