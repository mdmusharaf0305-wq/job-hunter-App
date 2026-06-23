const { Client } = require('@notionhq/client');
require('dotenv').config({ path: '.env.local' });
require('dotenv').config({ path: '.env' });

const notion = new Client({ auth: process.env.NOTION_TOKEN });

async function test() {
  try {
    const res = await notion.databases.query({
      database_id: process.env.OPPORTUNITIES_DB_ID,
      page_size: 1
    });
    
    if (res.results.length === 0) {
      console.log('No pages found to update');
      return;
    }
    
    const pageId = res.results[0].id;
    console.log('Testing update on page:', pageId);
    
    const updateRes = await notion.pages.update({
      page_id: pageId,
      properties: {
        '🏢 Company': { title: [{ text: { content: 'Test Update Company' } }] }
      }
    });
    
    console.log('Update successful!');
  } catch (err) {
    console.error('Update failed:', err.body || err);
  }
}

test();
