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
    const res = await fetch(`https://api.notion.com/v1/databases/${dbId}/query`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.NOTION_TOKEN}`,
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json'
      }
    });
    const data = await res.json();
    
    if (!data.results || data.results.length === 0) return;
    const pageId = data.results[0].id;
    console.log('Testing full update on page:', pageId);

    // Mock form submission payload
    const payload = {
      role: 'Frontend Developer',
      company: 'Test Company',
      client: 'Direct',
      type: 'inbound',
      priority: 'Medium',
      workMode: 'Hybrid',
      location: 'Bangalore',
      recruiterName: 'Test Recruiter',
      recruiterPhone: '12345',
      recruiterEmail: 'test@example.com',
      recruiterLinkedin: 'https://linkedin.com/in/test',
      interviewRounds: '3 Rounds',
      interviewMode: 'Virtual',
      roundPlan: 'Test Round', // from multiselect
      salary: '20LPA',
      status: 'sourcing',
      employmentType: 'Full-Time',
      companyType: 'Startup',
      receivedCallOn: '2026-06-04',
      callStatus: '',
      resumeSent: false,
      resumeSentOn: '2026-06-04',
      lastContactedDate: '2026-06-04'
    };

    const properties = {};
    if (payload.role) properties['💼 Role'] = { multi_select: payload.role.split(',').map(r => ({ name: r.trim() })).filter(r => r.name !== '') };
    if (payload.company) properties['🏢 Company'] = { title: [{ text: { content: payload.company } }] };
    if (payload.client) properties['🤝 Client'] = { select: { name: payload.client } };
    if (payload.type) properties['🧭 Recruiter Type'] = { select: { name: payload.type === 'inbound' ? '📥 Inbound' : '📤 Outbound' } };
    if (payload.interviewRounds) properties['🪜 Total Rounds'] = { select: { name: payload.interviewRounds } };
    if (payload.roundPlan) properties['🗺️ Round Plan'] = { multi_select: payload.roundPlan.split(',').map(r => ({ name: r.trim() })).filter(r => r.name !== '') };
    if (payload.priority) properties['🔥 Priority'] = { select: { name: payload.priority } };
    if (payload.recruiterName) properties['👤 Recruiter Name'] = { rich_text: [{ text: { content: payload.recruiterName } }] };
    if (payload.recruiterPhone) properties['📱 Recruiter Contact'] = { rich_text: [{ text: { content: payload.recruiterPhone } }] };
    if (payload.recruiterEmail) properties['📧 Recruiter Email'] = { email: payload.recruiterEmail };
    if (payload.recruiterLinkedin) properties['🔗 LinkedIn URL'] = { url: payload.recruiterLinkedin };
    if (payload.location) properties['📍 Location'] = { select: { name: payload.location } };
    if (payload.workMode) properties['🏠 Work Mode'] = { select: { name: payload.workMode } };
    if (payload.salary) properties['💸 Salary'] = { select: { name: payload.salary } };
    if (payload.interviewMode) properties['🎥 Interview Mode'] = { select: { name: payload.interviewMode } };
    if (payload.employmentType) properties['📑 Employment Type'] = { select: { name: payload.employmentType } };
    if (payload.lastContactedDate) properties['⏳ Last Contacted'] = { date: { start: payload.lastContactedDate } };
    if (payload.companyType) properties['🏛️ Company Type'] = { select: { name: payload.companyType } };
    if (payload.resumeSent !== undefined) properties['📤 Resume Sent'] = { checkbox: payload.resumeSent };
    if (payload.resumeSentOn) properties['Resume Sent On'] = { date: { start: payload.resumeSentOn } };
    if (payload.receivedCallOn) properties['📞 Received Call On'] = { date: { start: payload.receivedCallOn } };
    if (payload.callStatus) properties['Call Status'] = { status: { name: payload.callStatus } };

    const updateRes = await notion.pages.update({
      page_id: pageId,
      properties
    });
    console.log('Full update successful');
  } catch(e) {
    console.error('Error updating:', e.body ? JSON.stringify(e.body, null, 2) : e);
  }
}
testUpdate();
