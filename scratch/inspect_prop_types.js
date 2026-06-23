const { Client } = require('@notionhq/client');
const fs = require('fs');
let envStr = '';
try { envStr += fs.readFileSync('.env.local', 'utf8') + '\n'; } catch(e) {}
try { envStr += fs.readFileSync('.env', 'utf8') + '\n'; } catch(e) {}

envStr.split('\n').forEach(line => {
  const match = line.match(/^([^=]+)=(.*)$/);
  if (match && !process.env[match[1]]) {
    process.env[match[1]] = match[2].trim().replace(/^"|"$/g, '');
  }
});

async function testUpdate() {
  try {
    const dbId = process.env.OPPORTUNITIES_DB_ID;
    const res = await fetch(`https://api.notion.com/v1/databases/${dbId}/query`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.NOTION_TOKEN}`,
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json'
      }
    });
    const data = await res.json();
    if (!data.results || data.results.length === 0) return;
    const props = data.results[0].properties;
    
    for (const key in props) {
      console.log(`${key}: ${props[key].type}`);
    }
  } catch(e) {
    console.error('Error:', e);
  }
}
testUpdate();
