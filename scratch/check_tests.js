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

  const res = await notion.databases.query({
    database_id: dbId,
    page_size: 100
  });

  const summary = res.results.map(page => {
    const props = page.properties;
    let company = '';
    let role = '';
    let type = '';
    let status = '';
    let callStatus = '';

    for (const key of Object.keys(props)) {
      if (key.toLowerCase().includes('company') && props[key].title) {
        company = props[key].title[0]?.plain_text || '';
      }
      if (key.toLowerCase().includes('role') && props[key].rich_text) {
        role = props[key].rich_text[0]?.plain_text || '';
      }
      if (key.toLowerCase() === 'status') {
        status = props[key].select?.name || props[key].status?.name || '';
      }
      if (key.toLowerCase().includes('type')) {
        type = props[key].select?.name || '';
      }
      if (key.toLowerCase().includes('call status') || key.toLowerCase().includes('callstatus')) {
        callStatus = props[key].select?.name || props[key].status?.name || '';
      }
    }
    
    return { id: page.id, company, role, type, status, callStatus };
  });

  const testApps = summary.filter(a => a.company.toLowerCase().includes('test') || a.role.toLowerCase().includes('test'));
  console.log('TEST APPS:');
  console.log(JSON.stringify(testApps, null, 2));

  const rejectedOutbound = summary.filter(a => 
    a.type.toLowerCase().includes('outbound') && 
    (a.status.toLowerCase().includes('rejected') || a.status.toLowerCase().includes('drop'))
  );
  console.log('REJECTED OUTBOUND:');
  console.log(JSON.stringify(rejectedOutbound, null, 2));
}

run().catch(console.error);
