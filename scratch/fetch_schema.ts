import fs from 'fs';

const envFile = fs.readFileSync('.env.local', 'utf-8');
const envVars: any = {};
envFile.split('\n').forEach(line => {
  const match = line.match(/^([^=]+)=(.*)$/);
  if (match) envVars[match[1]] = match[2].replace(/["']/g, '').trim();
});

const token = envVars.NOTION_TOKEN;
const dbId = envVars.OPPORTUNITIES_DB_ID;

function toUUID(id: string) {
  const clean = id.replace(/-/g, '');
  if (clean.length === 32) {
    return `${clean.slice(0,8)}-${clean.slice(8,12)}-${clean.slice(12,16)}-${clean.slice(16,20)}-${clean.slice(20)}`;
  }
  return id;
}

async function run() {
  try {
    const res = await fetch(`https://api.notion.com/v1/databases/${toUUID(dbId)}`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Notion-Version': '2022-06-28',
      }
    });
    const data = await res.json();
    fs.writeFileSync('db_schema.json', JSON.stringify(data.properties, null, 2));
    console.log('done');
  } catch (e) {
    console.error(e);
  }
}
run();
