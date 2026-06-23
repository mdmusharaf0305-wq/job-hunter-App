const fs = require('fs');
const path = require('path');

function loadEnv() {
  const envPath = path.join(__dirname, '..', '.env.local');
  if (!fs.existsSync(envPath)) {
    console.error('.env.local not found');
    process.exit(1);
  }
  const content = fs.readFileSync(envPath, 'utf8');
  const env = {};
  content.split('\n').forEach(line => {
    const trimmed = line.trim();
    if (trimmed && !trimmed.startsWith('#')) {
      const parts = trimmed.split('=');
      const key = parts[0].trim();
      const val = parts.slice(1).join('=').trim();
      env[key] = val;
    }
  });
  return env;
}

const env = loadEnv();
const token = env.NOTION_TOKEN;
const dbId = env.OPPORTUNITIES_DB_ID;

function toUUID(id) {
  const clean = id.replace(/-/g, '');
  if (clean.length === 32) {
    return `${clean.slice(0,8)}-${clean.slice(8,12)}-${clean.slice(12,16)}-${clean.slice(16,20)}-${clean.slice(20)}`;
  }
  return id;
}

function stripEmoji(str) {
  return str.replace(/[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}\u{FE00}-\u{FE0F}\u{1F900}-\u{1F9FF}\u{200D}\u{20E3}\u{E0020}-\u{E007F}]/gu, '').trim().toLowerCase();
}

function findProp(props, ...candidates) {
  for (const c of candidates) {
    if (props[c]) return props[c];
  }
  const propEntries = Object.entries(props);
  for (const c of candidates) {
    const needle = stripEmoji(c);
    for (const [key, val] of propEntries) {
      if (stripEmoji(key) === needle) return val;
    }
  }
  return undefined;
}

function getPropertyValue(prop) {
  if (!prop) return '';
  switch (prop.type) {
    case 'title':
      return prop.title?.[0]?.plain_text || '';
    case 'rich_text':
      return prop.rich_text?.[0]?.plain_text || '';
    case 'select':
      return prop.select?.name || '';
    case 'status':
      return prop.status?.name || '';
    case 'multi_select':
      return prop.multi_select?.map(s => s.name).join(', ') || '';
    case 'date':
      return prop.date?.start || '';
    case 'url':
      return prop.url || '';
    case 'number':
      return prop.number?.toString() || '';
    case 'phone_number':
      return prop.phone_number || '';
    case 'email':
      return prop.email || '';
    case 'relation':
      return prop.relation?.[0]?.id || '';
    case 'formula':
      if (prop.formula?.type === 'string') return prop.formula.string || '';
      if (prop.formula?.type === 'number') return prop.formula.number?.toString() || '';
      return '';
    case 'checkbox':
      return prop.checkbox ? 'true' : 'false';
    default:
      return '';
  }
}

async function main() {
  const uuid = toUUID(dbId);
  const url = `https://api.notion.com/v1/databases/${uuid}/query`;
  
  try {
    const res = await fetch(url, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ page_size: 20 })
    });
    const data = await res.json();
    if (data.object === 'error') {
      console.error('Notion Error:', data);
      return;
    }
    
    console.log(`Successfully fetched ${data.results.length} rows.`);
    
    // Dump details of first page's properties to see property names and values
    if (data.results.length > 0) {
      const firstPage = data.results[0];
      console.log('--- Raw properties of the first item ---');
      for (const [key, val] of Object.entries(firstPage.properties)) {
        console.log(`Property: "${key}", Type: "${val.type}", Value: "${getPropertyValue(val)}"`);
      }
    }
    
    console.log('\n--- Company/Client breakdown for all items ---');
    data.results.forEach((page, index) => {
      const props = page.properties;
      let company = '';
      for (const key in props) {
        if (props[key]?.type === 'title') {
          company = getPropertyValue(props[key]);
          break;
        }
      }
      
      const client = getPropertyValue(findProp(props, 'Client', 'client', '🤝 Client')) || 'Direct';
      console.log(`[${index + 1}] Company: "${company}", Client: "${client}"`);
    });
  } catch (e) {
    console.error('Fetch error:', e);
  }
}

main();
