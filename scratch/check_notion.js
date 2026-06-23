const { Client } = require('@notionhq/client');
const fs = require('fs');

const envLocal = fs.readFileSync('.env.local', 'utf8');
envLocal.split('\n').forEach(line => {
  const match = line.match(/^([^=]+)=(.*)$/);
  if (match) {
    process.env[match[1]] = match[2].replace(/['"]/g, '');
  }
});

async function run() {
  const notion = new Client({ auth: process.env.NOTION_TOKEN });
  const dbId = process.env.OPPORTUNITIES_DB_ID;

  if (!dbId || dbId === 'your_database_id_here') {
    console.log('No DB ID');
    return;
  }

  const res = await notion.databases.query({
    database_id: dbId,
    page_size: 50
  });

  const summary = res.results.map(page => {
    const props = page.properties;
    
    // Find Call Status
    let callStatus = null;
    let status = null;
    let type = null;

    for (const key of Object.keys(props)) {
      if (key.toLowerCase().includes('call status') || key.toLowerCase().includes('callstatus')) {
        const p = props[key];
        callStatus = p.select?.name || p.status?.name || p.rich_text?.[0]?.plain_text || 'unknown type: ' + p.type;
      }
      if (key.toLowerCase().trim() === 'status') {
        const p = props[key];
        status = p.select?.name || p.status?.name || 'unknown';
      }
      if (key.toLowerCase().includes('type')) {
        const p = props[key];
        if(p.select?.name) {
           type = p.select.name;
        }
      }
    }
    
    return { id: page.id, callStatus, status, type };
  });

  console.log(JSON.stringify(summary.filter(x => x.type && x.type.toLowerCase().includes('outbound')), null, 2));
}

run().catch(console.error);
