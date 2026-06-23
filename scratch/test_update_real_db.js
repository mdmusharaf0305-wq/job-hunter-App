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

const notion = new Client({ auth: process.env.NOTION_TOKEN });

async function testUpdate() {
  try {
    const dbId = 'ab75bede-0c3a-8305-9c42-070aa53ac4c7'; // the real db ID from data_sources
    const db = await notion.databases.retrieve({ database_id: dbId });
    console.log('Real DB props:', Object.keys(db.properties));
    
    // Now let's fetch one page
    const res = await notion.databases.query({
      database_id: dbId,
      page_size: 1
    });
    
    if (res.results.length === 0) {
      console.log('No pages found');
      return;
    }
    
    const pageId = res.results[0].id;
    console.log('Testing update on page:', pageId);
    
    const updateRes = await notion.pages.update({
      page_id: pageId,
      properties: {
        '🏢 Company': { title: [{ text: { content: 'Test Update' } }] }
      }
    });
    console.log('Update successful');
  } catch(e) {
    console.error('Error:', e.body ? JSON.stringify(e.body, null, 2) : e);
  }
}
testUpdate();
