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
    const dbId = process.env.OPPORTUNITIES_DB_ID;
    const res = await notion.databases.query({
      database_id: dbId,
      page_size: 1
    });
    
    if (res.results.length === 0) {
      console.log('No pages found');
      return;
    }
    
    const pageId = res.results[0].id;
    console.log('Updating page:', pageId);
    
    const page = await notion.pages.retrieve({ page_id: pageId });
    console.log('Existing props:', Object.keys(page.properties));
    
    const updateRes = await notion.pages.update({
      page_id: pageId,
      properties: {
        '⏳ Last Contacted': { date: null },
        '📱 Recruiter Contact': { rich_text: [] },
        '📧 Recruiter Email': null
      }
    });
    console.log('Update successful');
  } catch(e) {
    console.error('Error updating:', e.body ? JSON.stringify(e.body, null, 2) : e);
  }
}
testUpdate();
