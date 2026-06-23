const fs = require('fs');
const { fetchApplications, mapRawStatusToBaseStage, getDashboardMetrics } = require('../src/lib/notion/client');

// Mock process.env
try {
  const envPath = 'F:\\CodeArea\\job-command-center\\.env.local';
  if (fs.existsSync(envPath)) {
    const lines = fs.readFileSync(envPath, 'utf8').split('\n');
    for (const line of lines) {
      const trimmed = line.trim();
      if (trimmed.startsWith('NOTION_TOKEN=')) {
        process.env.NOTION_TOKEN = trimmed.split('NOTION_TOKEN=')[1].trim().replace(/['"]/g, '');
      }
      if (trimmed.startsWith('OPPORTUNITIES_DB_ID=')) {
        process.env.OPPORTUNITIES_DB_ID = trimmed.split('OPPORTUNITIES_DB_ID=')[1].trim().replace(/['"]/g, '');
      }
    }
  }
} catch (e) {
  console.log("Error reading .env", e);
}

async function run() {
  try {
    const apps = await fetchApplications();
    console.log("Total Applications:", apps.length);
    const offers = apps.filter(a => mapRawStatusToBaseStage(a.status) === 'offered');
    console.log("Offer Status Counts:", offers.length);
    console.log("Offer app details:", offers.map(a => ({ company: a.company, role: a.role, status: a.status })));
    
    // Check if it used mock data
    const DeloitteApp = apps.find(a => a.company === 'Deloitte');
    console.log("Is mock data loaded (Deloitte app-1 present?):", !!DeloitteApp && DeloitteApp.id === 'app-1');
  } catch (e) {
    console.error(e);
  }
}
run();
