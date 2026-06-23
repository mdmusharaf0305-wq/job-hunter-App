import { fetchApplications, updateApplication } from '../src/lib/notion/client';
import fs from 'fs';

let envStr = '';
try { envStr += fs.readFileSync('.env.local', 'utf8') + '\n'; } catch(e) {}
try { envStr += fs.readFileSync('.env', 'utf8') + '\n'; } catch(e) {}

envStr.split('\n').forEach(line => {
  const match = line.match(/^([^=]+)=(.*)$/);
  if (match && !process.env[match[1]]) {
    process.env[match[1]] = match[2].trim().replace(/^"|"$/g, '');
  }
});

async function test() {
  const apps = await fetchApplications();
  if (apps.length === 0) {
    console.log('No apps');
    return;
  }
  
  const app = apps[0];
  console.log('Updating app:', app.company);
  
  try {
    const res = await updateApplication(app.id, { company: app.company });
    console.log('Update success');
  } catch(e: any) {
    console.error('Update error:', JSON.stringify(e.body, null, 2) || e);
  }
}
test();
