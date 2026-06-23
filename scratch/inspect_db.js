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

async function test() {
  try {
    const dbId = process.env.OPPORTUNITIES_DB_ID;
    console.log('Fetching DB:', dbId);
    const db = await notion.databases.retrieve({ database_id: dbId });
    console.log(JSON.stringify(db, null, 2));
  } catch(e) {
    console.error('Error:', e.body ? e.body : e);
  }
}
test();
