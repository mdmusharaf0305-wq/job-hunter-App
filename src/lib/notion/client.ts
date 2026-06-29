/* eslint-disable @typescript-eslint/no-explicit-any */
import { Client } from '@notionhq/client';
import { Recruiter, JobApplication, DashboardMetrics, ApplicationStage } from '../../types';

// Check if credentials are valid and not placeholders
const isTokenConfigured = !!(
  process.env.NOTION_TOKEN &&
  process.env.NOTION_TOKEN !== 'secret_your_notion_token_here' &&
  !process.env.NOTION_TOKEN.includes('your_notion_token')
);

const isOpportunitiesConfigured = !!(
  process.env.OPPORTUNITIES_DB_ID &&
  process.env.OPPORTUNITIES_DB_ID !== 'your_database_id_here'
);

const isTimelineConfigured = !!(
  process.env.APPLICATION_TIMELINE_DB_ID &&
  process.env.APPLICATION_TIMELINE_DB_ID !== 'your_database_id_here'
);

// Initialize Notion Client safely
export const notion = isTokenConfigured
  ? new Client({ auth: process.env.NOTION_TOKEN, notionVersion: '2022-06-28' })
  : null;

const OPPORTUNITIES_DB_ID = process.env.OPPORTUNITIES_DB_ID || '';
const APPLICATION_TIMELINE_DB_ID = process.env.APPLICATION_TIMELINE_DB_ID || '';

export type NotionSchemaOptions = {
  roles: string[];
  salaries: string[];
  roundPlans: string[];
  totalRounds: string[];
  employmentTypes: string[];
  companyTypes: string[];
  companySizes: string[];
  locations: string[];
  clients: string[];
  statuses: string[];
  eventCategories: string[];
  virtualModes: string[];
  interviewModes: string[];
  callStatuses: string[];
  followupChannels: string[];
};

let cachedSchemaOptions: NotionSchemaOptions | null = null;

export function clearSchemaCache() {
  cachedSchemaOptions = null;
}

export async function getDatabaseSchemaOptions(): Promise<NotionSchemaOptions> {
  if (cachedSchemaOptions) return cachedSchemaOptions;

  if (!notion || !isOpportunitiesConfigured || !OPPORTUNITIES_DB_ID) {
    return {
      roles: ['Frontend Developer', 'Backend Developer', 'Full Stack Developer'],
      salaries: ['10LPA - 12LPA', '12lpa', '13lpa'],
      roundPlans: ['HR Screening', 'Technical Round 1', 'Technical Round 2', 'Manager Round'],
      totalRounds: ['1 Round', '2 Rounds', '3 Rounds', '4 Rounds'],
      employmentTypes: ['Full-Time', 'Contract', 'Freelance'],
      companyTypes: ['Product Based', 'Service Based', 'Startup'],
      companySizes: ['101-500', '500-10000', '1000-2000', '2000-3000', '3000+'],
      locations: ['Bangalore', 'Pune', 'Hyderabad', 'Remote'],
      clients: ['Direct'],
      statuses: ['📄 Applied', '📞 HR Screening', '🤖 AI Round', '❌ Rejected', '🎉 Offer Received'],
      eventCategories: ['Interview', 'Assignment', 'Follow-up'],
      virtualModes: ['Google Meet', 'Zoom', 'Teams'],
      interviewModes: ['Google Meet', 'Zoom', 'Teams'],
      callStatuses: ['Scheduled', 'Completed', 'Missed'],
      followupChannels: ['Email', 'LinkedIn', 'WhatsApp', 'Phone Call']
    };
  }

  try {
    const res = await fetch(`https://api.notion.com/v1/databases/${toUUID(OPPORTUNITIES_DB_ID)}`, {
      method: 'GET',
      headers: {
        'Authorization': `Bearer ${process.env.NOTION_TOKEN}`,
        'Notion-Version': '2022-06-28'
      },
      cache: 'no-store'
    });
    
    if (!res.ok) {
      throw new Error(`Failed to fetch schema: ${res.statusText}`);
    }
    
    const data = await res.json();
    const props = data.properties;

    const extractOptions = (propName: string) => {
      const p = props[propName];
      if (!p) return [];
      if (p.type === 'select' && p.select?.options) {
        return p.select.options.map((o: any) => o.name);
      }
      if (p.type === 'multi_select' && p.multi_select?.options) {
        return p.multi_select.options.map((o: any) => o.name);
      }
      return [];
    };

    cachedSchemaOptions = {
      roles: extractOptions('💼 Role'),
      salaries: extractOptions('💸 Salary'),
      roundPlans: extractOptions('🗺️ Round Plan'),
      totalRounds: extractOptions('🪜 Total Rounds'),
      employmentTypes: extractOptions('📑 Employment Type'),
      companyTypes: extractOptions('🏛️ Company Type'),
      companySizes: (() => {
        const fromCount = extractOptions('Company Count');
        if (fromCount && fromCount.length > 0) return fromCount;
        return extractOptions('🏢 Company Size');
      })(),
      locations: extractOptions('📍 Location'),
      clients: extractOptions('🤝 Client'),
      statuses: (() => {
        const p = props['Status'];
        if (!p) return [];
        return p.status?.options?.map((o: any) => o.name) || p.select?.options?.map((o: any) => o.name) || [];
      })(),
      callStatuses: (() => {
        const p = props['Call Status'];
        if (!p) return [];
        return p.status?.options?.map((o: any) => o.name) || p.select?.options?.map((o: any) => o.name) || [];
      })(),
      interviewModes: extractOptions('🎥 Interview Mode'),
      followupChannels: (() => {
        const opts = extractOptions('Follow-up Channel');
        if (opts && opts.length > 0) return opts;
        return extractOptions('Followup Channel');
      })(),
      eventCategories: [],
      virtualModes: []
    };

    // Also fetch Timeline DB schema if configured
    if (isTimelineConfigured && APPLICATION_TIMELINE_DB_ID) {
      try {
        const timelineRes = await fetch(`https://api.notion.com/v1/databases/${toUUID(APPLICATION_TIMELINE_DB_ID)}`, {
          method: 'GET',
          headers: {
            'Authorization': `Bearer ${process.env.NOTION_TOKEN}`,
            'Notion-Version': '2022-06-28'
          },
          cache: 'no-store'
        });
        if (timelineRes.ok) {
          const timelineData = await timelineRes.json();
          const tProps = timelineData.properties;
          
          const extractTimelineOptions = (propName: string) => {
            const p = tProps[propName];
            if (!p) return [];
            if (p.type === 'select' && p.select?.options) return p.select.options.map((o: any) => o.name);
            if (p.type === 'multi_select' && p.multi_select?.options) return p.multi_select.options.map((o: any) => o.name);
            return [];
          };

          cachedSchemaOptions.eventCategories = extractTimelineOptions('🎯 Event Category');
          cachedSchemaOptions.virtualModes = extractTimelineOptions('💻 Virtual Mode');
        }
      } catch (err) {
        console.error('[JCC] Error fetching timeline schema options:', err);
      }
    }

    return cachedSchemaOptions;
  } catch (error) {
    console.error('[JCC] Error fetching database schema options:', error);
    // Fallback empty options if fetch fails
    return {
      roles: [], salaries: [], roundPlans: [], totalRounds: [],
      employmentTypes: [], companyTypes: [], companySizes: [], locations: [], clients: [],
      statuses: [], eventCategories: [], virtualModes: [], interviewModes: [], callStatuses: [],
      followupChannels: []
    };
  }
}

// --- MOCK DATA ENGINE ---

// Opportunities List (Opportunities DB)
const mockApplications: JobApplication[] = [
  {
    id: 'app-1',
    role: 'Frontend Developer',
    company: 'Deloitte',
    client: 'Deloitte',
    type: 'outbound',
    status: '🗓️ Interview Scheduled',
    lastUpdated: '2026-06-03',
    location: 'Bengaluru',
    workMode: 'Hybrid',
    priority: 'High',
    recruiterName: 'Reena Gupta',
    recruiterCompany: 'Innova Solutions',
    recruiterPhone: '+91 98765 43210',
    recruiterEmail: 'reena.g@innovasolutions.com',
    recruiterLinkedin: 'https://linkedin.com/in/reenagupta',
    interviewRounds: 'HR screening completed. Technical round scheduled.',
    roundPlan: 'Review React Concurrent Mode features and Webpack/Turbopack custom configurations.',
    applicationUrl: 'https://linkedin.com/jobs/view/deloitte-frontend',
    relatedTimelineId: 'time-1',
    companySize: '2000-3000',
    companyType: 'Service Based'
  },
  {
    id: 'app-2',
    role: 'Frontend Developer',
    company: 'IBM',
    client: 'IBM',
    type: 'outbound',
    status: '🤖 AI Round',
    lastUpdated: '2026-06-02',
    location: 'Delhi NCR',
    workMode: 'Remote',
    priority: 'High',
    recruiterName: 'Amit',
    recruiterCompany: 'ArcTech',
    recruiterPhone: '+91 99999 11111',
    recruiterEmail: 'amit.hr@arctech.com',
    recruiterLinkedin: 'https://linkedin.com/in/amit-recruiter',
    interviewRounds: 'Cleared Round 1 MCQ. Round 2 Coding interview scheduled next.',
    roundPlan: 'Practice dynamic programming, graph traversal, and arrays manipulations.',
    relatedTimelineId: 'time-2',
    companySize: '3000+',
    companyType: 'Product Based'
  },
  {
    id: 'app-3',
    role: 'Frontend Architect',
    company: 'JK Group',
    client: 'JKDTL',
    type: 'inbound',
    status: '🧠 Technical Round 1',
    lastUpdated: '2026-06-01',
    location: 'Noida',
    workMode: 'Hybrid',
    priority: 'High',
    recruiterName: 'Vartika Mehta',
    recruiterCompany: 'Diensten Tech',
    recruiterPhone: '+91 88888 22222',
    recruiterEmail: 'vartika@dienstentech.com',
    recruiterLinkedin: 'https://linkedin.com/in/vartika-mehta',
    interviewRounds: 'HR interview cleared. Technical panel interview on systems architecture scheduled.',
    roundPlan: 'Revise micro-frontend designs, Module Federation, and custom caching strategies.',
    relatedTimelineId: 'time-3',
    companySize: '1000-2000',
    companyType: 'Service Based'
  },
  {
    id: 'app-4',
    role: 'React Developer',
    company: 'Capgemini',
    client: 'Direct',
    type: 'inbound',
    status: '🎉 Offer Received',
    lastUpdated: '2026-05-29',
    location: 'Bengaluru',
    workMode: 'Hybrid',
    priority: 'High',
    recruiterName: 'Sanjay Kumar',
    recruiterCompany: 'ArcTech',
    recruiterPhone: '+91 77777 33333',
    recruiterEmail: 'sanjay.recruiter@capgemini.com',
    recruiterLinkedin: 'https://linkedin.com/in/sanjaykumar',
    interviewRounds: 'All rounds complete. Verbal offer received. Awaiting written letter.',
    roundPlan: 'Review benefits and prepare negotiation arguments.',
    relatedTimelineId: 'time-4',
    companySize: '3000+',
    companyType: 'Service Based'
  },
  {
    id: 'app-5',
    role: 'UI Developer',
    company: 'TCS',
    client: 'Direct',
    type: 'outbound',
    status: '🎉 Offer Received',
    lastUpdated: '2026-05-25',
    location: 'Pune',
    workMode: 'Onsite',
    priority: 'Medium',
    recruiterName: 'Pooja',
    recruiterCompany: 'Direct',
    recruiterPhone: '+91 66666 44444',
    recruiterEmail: 'pooja.talent@tcs.com',
    recruiterLinkedin: 'https://linkedin.com/in/pooja-recruiter',
    relatedTimelineId: 'time-5',
    companySize: '3000+',
    companyType: 'Service Based'
  },
  {
    id: 'app-6',
    role: 'UI Developer',
    company: 'Gloify',
    client: 'Direct',
    type: 'inbound',
    status: '📞 HR Screening',
    lastUpdated: '2026-05-30',
    location: 'Bengaluru',
    workMode: 'Onsite',
    priority: 'Medium',
    recruiterName: 'Neha Limje',
    recruiterCompany: 'Gloify',
    recruiterPhone: '+91 55555 55555',
    recruiterEmail: 'neha.limje@gloify.com',
    recruiterLinkedin: 'https://linkedin.com/in/nehalimje',
    relatedTimelineId: 'time-6',
    companySize: '101-500',
    companyType: 'Startup'
  },
  {
    id: 'app-7',
    role: 'React.js Specialist',
    company: 'Ekfrazo',
    client: 'Direct',
    type: 'inbound',
    status: '📄 Applied',
    lastUpdated: '2026-05-28',
    location: 'Mumbai',
    workMode: 'Remote',
    priority: 'Medium',
    recruiterName: 'Aman',
    recruiterCompany: 'Ekfrazo',
    recruiterPhone: '+91 44444 66666',
    recruiterEmail: 'aman@ekfrazo.com',
    recruiterLinkedin: 'https://linkedin.com/in/aman-ekfrazo',
    relatedTimelineId: 'time-7',
    companySize: '101-500',
    companyType: 'Startup'
  },
  {
    id: 'app-8',
    role: 'Frontend Architect',
    company: 'Cognizant',
    client: 'JPMC',
    type: 'outbound',
    status: '❌ Rejected',
    lastUpdated: '2026-05-20',
    location: 'Chennai',
    workMode: 'Onsite',
    priority: 'Low',
    recruiterName: 'Meera',
    recruiterCompany: 'Cognizant',
    recruiterPhone: '+91 33333 77777',
    recruiterEmail: 'meera.consulting@cognizant.com',
    recruiterLinkedin: 'https://linkedin.com/in/meera-recruiter',
    relatedTimelineId: 'time-8',
    companySize: '3000+',
    companyType: 'Service Based'
  },
  {
    id: 'app-9',
    role: 'Frontend Developer',
    company: 'Wipro',
    client: 'Shell',
    type: 'inbound',
    status: '🚫 No Openings',
    lastUpdated: '2026-05-15',
    location: 'Kolkata',
    priority: 'Low',
    recruiterName: 'Aman',
    recruiterCompany: 'Wipro',
    recruiterPhone: '+91 22222 88888',
    recruiterEmail: 'aman.careers@wipro.com',
    recruiterLinkedin: 'https://linkedin.com/in/aman-wipro',
    relatedTimelineId: 'time-9',
    companySize: '3000+',
    companyType: 'Service Based'
  }
];





// Convert Notion property value safely
function getPropertyValue(prop: any): string {
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
      return prop.multi_select?.map((s: any) => s.name).join(', ') || '';
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

// Strip emoji and extra whitespace from a string for fuzzy property matching
function stripEmoji(str: string): string {
  return str.replace(/[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}\u{FE00}-\u{FE0F}\u{1F900}-\u{1F9FF}\u{200D}\u{20E3}\u{E0020}-\u{E007F}]/gu, '').trim().toLowerCase();
}

// Find a property by trying exact match first, then fuzzy match (strip emoji + case-insensitive)
function findProp(props: any, ...candidates: string[]): any {
  // 1. Try exact key match
  for (const c of candidates) {
    if (props[c]) return props[c];
  }
  // 2. Try fuzzy match (strip emoji from both sides)
  const propEntries = Object.entries(props);
  for (const c of candidates) {
    const needle = stripEmoji(c);
    for (const [key, val] of propEntries) {
      if (stripEmoji(key) === needle) return val;
    }
  }
  return undefined;
}

export function mapRawStatusToBaseStage(status: string | undefined): 'sourcing' | 'screening' | 'interview' | 'offered' | 'rejected' | 'not_started' {
  if (!status) return 'not_started';
  const s = status.trim();
  const clean = s.replace(/[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}\u{FE00}-\u{FE0F}\u{1F900}-\u{1F9FF}\u{200D}\u{20E3}\u{E0020}-\u{E007F}]/gu, '').trim().toLowerCase();
  
  if (clean === 'not started' || clean === '') {
    return 'not_started';
  }
  if (clean === 'applied' || clean === 'resume shared' || clean === 'no response' || clean === 'sourcing') {
    return 'sourcing';
  }
  if (clean === 'hr screening' || clean === 'shortlisted' || clean === 'screening') {
    return 'screening';
  }
  if (
    clean === 'ai round' ||
    clean === 'test scheduled' ||
    clean === 'test attempted' ||
    clean === 'interview scheduled' ||
    clean === 'technical round 1' ||
    clean === 'technical round 2' ||
    clean === 'manager round' ||
    clean === 'client round' ||
    clean === 'final hr' ||
    clean === 'interview pipeline' ||
    clean === 'interview loop' ||
    clean === 'interview missed' ||
    clean === 'attention needed'
  ) {
    return 'interview';
  }
  if (clean === 'offer received' || clean === 'offer stage' || clean === 'offered') {
    return 'offered';
  }
  if (
    clean === 'rejected' ||
    clean === 'drop' ||
    clean === 'duplicated profile' ||
    clean === 'better luck next time' ||
    clean === 'no openings' ||
    clean === 'position closed' ||
    clean === 'on hold' ||
    clean === 'paused' ||
    clean === 'closed'
  ) {
    return 'rejected';
  }
  return 'sourcing';
}

export function mapNotionStatusToFormulaStatus(status: string | undefined): string {
  const s = status ? status.trim() : "";
  if (!s) return "⚪ Not Started";
  
  if (s === "📄 Applied" || s === "📨 Resume Shared" || s === "👻 No Response" || s === "sourcing") {
    return "📥 Sourcing";
  }
  if (s === "📞 HR Screening" || s === "🔍 Shortlisted" || s === "screening") {
    return "☎️ Screening";
  }
  if (
    s === "🤖 AI Round" ||
    s === "📝 Test Scheduled" ||
    s === "🧪 Test Attempted" ||
    s === "🗓️ Interview Scheduled" ||
    s === "🧠 Technical Round 1" ||
    s === "⚙️ Technical Round 2" ||
    s === "👨💼 Manager Round" ||
    s === "🏢 Client Round" ||
    s === "💬 Final HR" ||
    s === "interview"
  ) {
    return "🎯 Interview Pipeline";
  }
  if (s === "⏸️ On Hold" || s === "paused") {
    return "⏸️ Paused";
  }
  if (s === "🎉 Offer Received" || s === "offered") {
    return "💰 Offer Stage";
  }
  if (s === "❌ Rejected" || s === "🚶 Drop" || s === "🚫 Duplicated Profile" || s === "rejected") {
    return "💔 Better Luck Next Time";
  }
  if (s === "🚫 No Openings") {
    return "📭 Position Closed";
  }
  if (s === "⚠️ Interview Missed") {
    return "⏸️ Attention Needed";
  }
  return "❌ Closed";
}

// Map Notion page to Job Application Type
export function mapPageToApplication(page: any): JobApplication {
  const props = page.properties;
  
  // Dynamic Title field detection (Notion title property is the Company name)
  let company = '';
  for (const key in props) {
    if (props[key]?.type === 'title') {
      company = getPropertyValue(props[key]);
      break;
    }
  }

  const role = getPropertyValue(findProp(props, 'Role', 'role')) || 'Unknown Role';
  const client = getPropertyValue(findProp(props, 'Client', 'client')) || 'Direct';
  
  // Determine inbound/outbound from Recruiter Type or Type property
  const recruiterType = getPropertyValue(findProp(props, 'Recruiter Type', 'Type', 'Source Type')).toLowerCase();
  const type = recruiterType.includes('inbound') ? 'inbound' : 'outbound';
  
  const lastUpdated = getPropertyValue(findProp(props, 'Last Updated', 'Last Contacted', 'last_updated'));
  const location = getPropertyValue(findProp(props, 'Location', 'location'));
  const workMode = getPropertyValue(findProp(props, 'Work Mode', 'work_mode'));
  const salary = getPropertyValue(findProp(props, 'Salary', 'salary'));
  const interviewRounds = getPropertyValue(findProp(props, 'Interview Rounds', 'Total Rounds', 'interviewRounds'));
  const roundPlan = getPropertyValue(findProp(props, 'Round Plan', 'roundPlan'));
  const applicationUrl = getPropertyValue(findProp(props, 'Application URL', 'applicationUrl', 'Url'));
  const priority = getPropertyValue(findProp(props, 'Priority', 'priority')) as 'High' | 'Medium' | 'Low' | undefined;
  
  const recruiterName = getPropertyValue(findProp(props, 'Recruiter Name', 'recruiterName', 'Recruiter'));
  const recruiterCompany = getPropertyValue(findProp(props, 'Recruiter Company', 'recruiter_company', 'Vendor'));
  const recruiterPhone = getPropertyValue(findProp(props, 'Recruiter Contact', 'Recruiter Phone', 'Phone', 'Number', 'phone'));
  const recruiterEmail = getPropertyValue(findProp(props, 'Recruiter Email', 'Email', 'Mail', 'email'));
  const recruiterLinkedin = getPropertyValue(findProp(props, 'LinkedIn URL', 'LinkedIn', 'Linkedin', 'LinkedIn Link', 'LinkedIn Profile', 'linkedin'));

  // Extract status directly from the Status property, preserving raw format
  const status = getPropertyValue(findProp(props, 'Status', 'status')) || '⚪ Not Started';

  // Extract timeline page relation (if exists)
  const relationProp = findProp(props, 'Application Timeline', 'Timeline', 'timeline');
  const relatedTimelineId = getPropertyValue(relationProp) || undefined;

  // Extract callStatus directly from Call Status property
  const callStatus = getPropertyValue(findProp(props, 'Call Status', 'callStatus', 'call_status')) || '';
  const resumeSent = getPropertyValue(findProp(props, '📤 Resume Sent', 'Resume Sent', 'resumeSent', 'resume_sent')) === 'true';
  const resumeSentOn = getPropertyValue(findProp(props, 'Resume Sent On', 'resumeSentOn'));
  const receivedCallOn = getPropertyValue(findProp(props, '📞 Received Call On', 'Received Call On', 'receivedCallOn'));
  const interviewMode = getPropertyValue(findProp(props, 'Interview Mode', 'interviewMode', 'interview_mode'));
  const employmentType = getPropertyValue(findProp(props, 'Employment Type', 'employmentType', 'employment_type'));
  const lastContactedDate = getPropertyValue(findProp(props, '⏳ Last Contacted', 'Last Contacted', 'lastContactedDate', 'last_contacted'));
  const companyType = getPropertyValue(findProp(props, '🏛️ Company Type', 'Company Type', 'companyType', 'company_type'));
  const companySize = getPropertyValue(findProp(props, 'Company Count', '🏢 Company Size', 'Company Size', 'companySize', 'company_size'));
  const followupChannel = getPropertyValue(findProp(props, 'Followup Channel', 'Follow-up Channel', 'followup_channel'));
  const notes = getPropertyValue(findProp(props, '📚 Notes', 'Notes', 'notes'));

  return {
    id: page.id,
    role: role || 'Unknown Role',
    company: company || 'Unknown Company',
    client,
    type,
    status,
    lastUpdated: lastUpdated || new Date().toISOString().split('T')[0],
    location: location || undefined,
    workMode: workMode || undefined,
    salary: salary || undefined,
    interviewRounds: interviewRounds || undefined,
    roundPlan: roundPlan || undefined,
    applicationUrl: applicationUrl || undefined,
    priority: priority || undefined,
    recruiterName: recruiterName || undefined,
    recruiterCompany: recruiterCompany || undefined,
    recruiterPhone: recruiterPhone || undefined,
    recruiterEmail: recruiterEmail || undefined,
    recruiterLinkedin: recruiterLinkedin || undefined,
    relatedTimelineId,
    callStatus: callStatus || undefined,
    resumeSentOn: resumeSentOn || undefined,
    receivedCallOn: receivedCallOn || undefined,
    interviewMode: interviewMode || undefined,
    employmentType: employmentType || undefined,
    lastContactedDate: lastContactedDate || undefined,
    companyType: companyType || undefined,
    companySize: companySize || undefined,
    resumeSent,
    followupChannel: followupChannel || undefined,
    notes: notes || undefined
  };
}

// --- PAGINATED NOTION QUERY HELPER ---
// Notion API returns max 100 results per page. This helper loops through
// all pages using has_more / next_cursor to fetch every single record.

// Normalize a 32-char hex ID to proper UUID format (8-4-4-4-12)
function toUUID(id: string): string {
  const clean = id.replace(/-/g, '');
  if (clean.length === 32) {
    return `${clean.slice(0,8)}-${clean.slice(8,12)}-${clean.slice(12,16)}-${clean.slice(16,20)}-${clean.slice(20)}`;
  }
  return id; // already formatted or unknown format
}

async function queryAllPages(databaseId: string, sorts?: any[]): Promise<any[]> {
  const token = process.env.NOTION_TOKEN;
  if (!token) return [];
  const allResults: any[] = [];
  let cursor: string | undefined = undefined;
  let hasMore = true;
  const normalizedId = toUUID(databaseId);

  while (hasMore) {
    const requestBody: any = { page_size: 100 };
    if (cursor) requestBody.start_cursor = cursor;
    if (sorts) requestBody.sorts = sorts;

    const res = await fetch(`https://api.notion.com/v1/databases/${normalizedId}/query`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(requestBody),
      cache: 'no-store'
    });

    const data = await res.json();
    if (data.object === 'error') {
      console.error('[JCC] Notion API error:', data.code, data.message);
      throw new Error(`Notion API: ${data.message}`);
    }

    allResults.push(...(data.results || []));
    hasMore = !!data.has_more;
    cursor = data.next_cursor || undefined;
  }

  return allResults;
}

// --- API ACTIONS ---

export async function fetchApplications(): Promise<JobApplication[]> {
  if (!isTokenConfigured || !isOpportunitiesConfigured || !OPPORTUNITIES_DB_ID) {
    console.log('[JCC] Notion not configured — using mock data fallback.');
    return mockApplications;
  }

  try {
    // Fetch ALL Opportunities (paginated — handles 100+ records)
    console.log('[JCC] Fetching all opportunities from Notion (paginated)...');
    const allPages = await queryAllPages(OPPORTUNITIES_DB_ID, [
      { timestamp: 'last_edited_time', direction: 'descending' }
    ]);
    console.log(`[JCC] Fetched ${allPages.length} opportunity records from Notion.`);

    const apps: JobApplication[] = allPages.map(mapPageToApplication).filter(a => {
      const isTest = a.company.toLowerCase().includes('test') || a.role.toLowerCase().includes('test');
      return !isTest;
    });
    // Status is now resolved directly from the Status property in mapPageToApplication
    return apps;
  } catch (e) {
    console.error('[JCC] Error fetching opportunities from Notion:', e);
    return mockApplications;
  }
}

export async function fetchRecruiters(): Promise<Recruiter[]> {
  const applications = await fetchApplications();
  
  // Extract unique recruiters from applications
  const recruitersMap = new Map<string, Recruiter>();
  
  applications.forEach(app => {
    if (app.recruiterName) {
      const key = `${app.recruiterName.toLowerCase()}-${(app.recruiterCompany || '').toLowerCase()}`;
      if (!recruitersMap.has(key)) {
        // Derive next follow-up and last contacted mock values if not defined
        const lastContactedDate = new Date();
        lastContactedDate.setDate(lastContactedDate.getDate() - 3);
        const lastContacted = lastContactedDate.toISOString().split('T')[0];

        const nextFollowUpDate = new Date();
        nextFollowUpDate.setDate(nextFollowUpDate.getDate()); // Today
        const nextFollowUp = nextFollowUpDate.toISOString().split('T')[0];

        recruitersMap.set(key, {
          id: app.id, // binds write action directly to the Opportunity page ID
          company: app.recruiterCompany || app.company,
          client: app.company,
          role: app.role,
          recruiterName: app.recruiterName,
          recruiterPhone: app.recruiterPhone || undefined,
          recruiterEmail: app.recruiterEmail || undefined,
          recruiterLinkedin: app.recruiterLinkedin || undefined,
          contactStatus: app.status,
          priority: app.priority || 'Low',
          lastContacted: lastContacted,
          nextFollowUp: app.status === 'sourcing' || app.status === 'screening' || app.status === 'interview' ? nextFollowUp : undefined,
          applicationUrl: app.applicationUrl,
          dbSource: app.type,
          relatedTimelineId: app.relatedTimelineId
        });
      }
    }
  });
  
  return Array.from(recruitersMap.values());
}

export async function updateRecruiter(id: string, data: Partial<Recruiter>): Promise<Recruiter> {
  // Check mock index
  const idx = mockApplications.findIndex(a => a.id === id);
  if (idx > -1) {
    if (data.recruiterName) mockApplications[idx].recruiterName = data.recruiterName;
    if (data.company) mockApplications[idx].recruiterCompany = data.company;
    if (data.priority) mockApplications[idx].priority = data.priority;
    if (data.contactStatus) mockApplications[idx].status = data.contactStatus as ApplicationStage;
    
    const recruiters = await fetchRecruiters();
    const r = recruiters.find(rec => rec.id === id);
    if (r) return r;
    throw new Error('Failed to retrieve updated recruiter from mock applications');
  }

  if (!notion) {
    throw new Error('Notion client not initialized');
  }

  try {
    const properties: any = {};
    if (data.recruiterName) properties['Recruiter Name'] = { rich_text: [{ text: { content: data.recruiterName } }] };
    if (data.company) properties['Recruiter Company'] = { rich_text: [{ text: { content: data.company } }] };
    if (data.priority) properties['Priority'] = { select: { name: data.priority } };
    if (data.applicationUrl) properties['Application URL'] = { url: data.applicationUrl };

    const response = await notion.request<any>({
      path: `pages/${id}`,
      method: 'patch',
      body: { properties }
    });

    // Extract updated fields and return
    const app = mapPageToApplication(response);
    const recruiters = await fetchRecruiters();
    return recruiters.find(rec => rec.id === app.id) || {
      id: app.id,
      company: app.recruiterCompany || app.company,
      client: app.company,
      role: app.role,
      recruiterName: app.recruiterName || 'Unknown Recruiter',
      contactStatus: app.status,
      dbSource: app.type
    };
  } catch (e) {
    console.error('Failed to update recruiter details in Notion:', e);
    throw e;
  }
}

export function mapStageToNotionStatus(stage: string): string {
  if (!stage) return 'Not started';
  const clean = stage.trim().toLowerCase();
  if (clean === 'sourcing' || clean === 'applied') return '📄 Applied';
  if (clean === 'screening' || clean === 'hr screening' || clean === '📞 hr screening' || clean === '☎️ hr screening') return '☎️ HR Screening';
  if (clean === 'interview' || clean === 'interview scheduled' || clean === '🗓️ interview scheduled') return '🗓️ Interview Scheduled';
  if (clean === 'offered' || clean === 'offer received') return '🎉 Offer Received';
  if (clean === 'rejected') return '❌ Rejected';
  if (clean === 'on hold') return '⏸️ On Hold';
  if (clean === 'drop' || clean === 'dropped') return '🚶 Drop';
  return stage;
}

function cleanOptionLabel(value: string): string {
  return value
    .replace(/[\u{1F300}-\u{1FAFF}\u{2600}-\u{27BF}\u{FE00}-\u{FE0F}\u{200D}]/gu, '')
    .replace(/[^\p{L}\p{N}\s]/gu, '')
    .trim()
    .toLowerCase();
}

function findSchemaOption(options: string[], value?: string): string | undefined {
  if (!value) return undefined;
  if (options.length === 0) return value;

  const cleanValue = cleanOptionLabel(value);
  return options.find(option => option === value)
    || options.find(option => cleanOptionLabel(option) === cleanValue)
    || options.find(option => {
      const cleanOption = cleanOptionLabel(option);
      return cleanOption.includes(cleanValue) || cleanValue.includes(cleanOption);
    });
}

function resolveStatusOption(options: string[], stage?: string): string | undefined {
  if (!stage) return undefined;
  const mapped = mapStageToNotionStatus(stage);
  const clean = cleanOptionLabel(stage);
  const candidates = [mapped, stage];

  if (clean.includes('sourcing') || clean.includes('applied') || clean.includes('not started')) {
    candidates.push('Applied', 'Not Started');
  } else if (clean.includes('screen') || clean.includes('shortlist')) {
    candidates.push('HR Screening', 'Shortlisted');
  } else if (clean.includes('interview') || clean.includes('round') || clean.includes('test')) {
    candidates.push('Interview Scheduled', 'Technical Round 1');
  } else if (clean.includes('offer')) {
    candidates.push('Offer Received');
  } else if (clean.includes('reject')) {
    candidates.push('Rejected');
  } else if (clean.includes('hold') || clean.includes('pause')) {
    candidates.push('On Hold');
  }

  for (const candidate of candidates) {
    const option = findSchemaOption(options, candidate);
    if (option) return option;
  }

  return options.length === 0 ? mapped : undefined;
}



async function getOpportunityDatabaseProperties(): Promise<Record<string, any>> {
  if (!notion || !OPPORTUNITIES_DB_ID) return {};
  const res = await fetch(`https://api.notion.com/v1/databases/${toUUID(OPPORTUNITIES_DB_ID)}`, {
    method: 'GET',
    headers: {
      'Authorization': `Bearer ${process.env.NOTION_TOKEN}`,
      'Notion-Version': '2022-06-28'
    },
    cache: 'no-store'
  });
  if (!res.ok) throw new Error(`Failed to fetch Opportunity schema: ${res.statusText}`);
  const data = await res.json();
  return data.properties || {};
}

function findPropertyKey(schema: Record<string, any>, candidates: string[], type?: string): string | undefined {
  const entries = Object.entries(schema);
  const exact = candidates.find(candidate => schema[candidate] && (!type || schema[candidate].type === type));
  if (exact) return exact;

  for (const candidate of candidates) {
    const cleanCandidate = cleanOptionLabel(candidate);
    const match = entries.find(([key, prop]) => {
      if (type && (prop as any).type !== type) return false;
      return cleanOptionLabel(key) === cleanCandidate || cleanOptionLabel(key).includes(cleanCandidate);
    });
    if (match) return match[0];
  }

  return entries.find(([, prop]) => !type || (prop as any).type === type)?.[0];
}

function schemaOptionsForProperty(prop: any): string[] {
  if (!prop) return [];
  if (prop.type === 'select') return prop.select?.options?.map((option: any) => option.name) || [];
  if (prop.type === 'multi_select') return prop.multi_select?.options?.map((option: any) => option.name) || [];
  if (prop.type === 'status') return prop.status?.options?.map((option: any) => option.name) || [];
  return [];
}

function setSchemaTitle(properties: any, schema: Record<string, any>, value?: string) {
  const key = findPropertyKey(schema, ['Company', 'Name'], 'title');
  if (key && value) properties[key] = { title: [{ text: { content: value } }] };
}

function setSchemaRichText(properties: any, schema: Record<string, any>, candidates: string[], value?: string) {
  const key = findPropertyKey(schema, candidates, 'rich_text');
  if (key && value !== undefined) properties[key] = { rich_text: [{ text: { content: value || '' } }] };
}

function setSchemaUrl(properties: any, schema: Record<string, any>, candidates: string[], value?: string) {
  const key = findPropertyKey(schema, candidates, 'url');
  if (key && value) properties[key] = { url: value };
}

function setSchemaEmail(properties: any, schema: Record<string, any>, candidates: string[], value?: string) {
  const key = findPropertyKey(schema, candidates, 'email');
  if (key && value) properties[key] = { email: value };
}

function setSchemaDate(properties: any, schema: Record<string, any>, candidates: string[], value?: string) {
  const key = findPropertyKey(schema, candidates, 'date');
  if (key && value) properties[key] = { date: { start: value } };
}

function setSchemaCheckbox(properties: any, schema: Record<string, any>, candidates: string[], value?: boolean) {
  const key = findPropertyKey(schema, candidates, 'checkbox');
  if (key && value !== undefined) properties[key] = { checkbox: value };
}

function setSchemaSelect(properties: any, schema: Record<string, any>, candidates: string[], value?: string, allowNew = false) {
  const key = findPropertyKey(schema, candidates, 'select');
  if (!key || !value) return;
  const option = findSchemaOption(schemaOptionsForProperty(schema[key]), value);
  if (option || allowNew) properties[key] = { select: { name: option || value } };
}

function setSchemaStatus(properties: any, schema: Record<string, any>, candidates: string[], value?: string) {
  const key = findPropertyKey(schema, candidates, 'status');
  if (!key || !value) return;
  const option = resolveStatusOption(schemaOptionsForProperty(schema[key]), value);
  if (option) properties[key] = { status: { name: option } };
}

function setSchemaMultiSelect(properties: any, schema: Record<string, any>, candidates: string[], value?: string) {
  const key = findPropertyKey(schema, candidates, 'multi_select');
  if (!key || !value) return;
  const options = schemaOptionsForProperty(schema[key]);
  const selected = value
    .split(',')
    .map(item => findSchemaOption(options, item.trim()))
    .filter(Boolean)
    .map(name => ({ name }));
  if (selected.length > 0) properties[key] = { multi_select: selected };
}

function buildOpportunityPropertiesFromSchema(schema: Record<string, any>, data: Partial<JobApplication>) {
  const properties: any = {};

  setSchemaTitle(properties, schema, data.company);
  setSchemaSelect(properties, schema, ['Role'], data.role);
  setSchemaSelect(properties, schema, ['Client'], data.client, true);
  setSchemaSelect(properties, schema, ['Recruiter Type', 'Type', 'Source Type'], data.type === 'inbound' ? 'Inbound' : data.type === 'outbound' ? 'Outbound' : undefined, true);
  setSchemaSelect(properties, schema, ['Priority'], data.priority, true);
  setSchemaSelect(properties, schema, ['Work Mode'], data.workMode, true);
  setSchemaSelect(properties, schema, ['Location'], data.location, true);
  setSchemaSelect(properties, schema, ['Salary'], data.salary);
  setSchemaSelect(properties, schema, ['Total Rounds', 'Interview Rounds'], data.interviewRounds);
  setSchemaMultiSelect(properties, schema, ['Round Plan'], data.roundPlan);
  setSchemaSelect(properties, schema, ['Interview Mode'], data.interviewMode);
  setSchemaSelect(properties, schema, ['Employment Type'], data.employmentType);
  setSchemaSelect(properties, schema, ['Company Type'], data.companyType);
  setSchemaSelect(properties, schema, ['Company Count', 'Company Size'], data.companySize);
  setSchemaStatus(properties, schema, ['Status'], data.status);
  setSchemaStatus(properties, schema, ['Call Status'], data.callStatus);
  setSchemaSelect(properties, schema, ['Follow-up Channel', 'Followup Channel'], data.followupChannel);
  setSchemaRichText(properties, schema, ['Recruiter Name', 'Recruiter'], data.recruiterName);
  setSchemaRichText(properties, schema, ['Recruiter Contact', 'Recruiter Phone', 'Phone', 'Number'], data.recruiterPhone);
  setSchemaEmail(properties, schema, ['Recruiter Email', 'Email', 'Mail'], data.recruiterEmail);
  setSchemaUrl(properties, schema, ['LinkedIn URL', 'LinkedIn', 'Linkedin'], data.recruiterLinkedin);
  setSchemaUrl(properties, schema, ['Application URL', 'Url'], data.applicationUrl);
  setSchemaDate(properties, schema, ['Last Contacted'], data.lastContactedDate || data.lastUpdated);
  setSchemaDate(properties, schema, ['Resume Sent On'], data.resumeSentOn);
  setSchemaDate(properties, schema, ['Received Call On'], data.receivedCallOn);
  setSchemaCheckbox(properties, schema, ['Resume Sent'], data.resumeSent);
  setSchemaRichText(properties, schema, ['Notes'], data.notes);

  return properties;
}

async function createApplicationViaSchema(data: JobApplication, timelineId?: string): Promise<JobApplication> {
  const schema = await getOpportunityDatabaseProperties();
  const properties = buildOpportunityPropertiesFromSchema(schema, data);
  const timelineKey = findPropertyKey(schema, ['Application Timeline', 'Timeline'], 'relation');
  if (timelineKey && timelineId) {
    properties[timelineKey] = { relation: [{ id: timelineId }] };
  }

  const response = await notion!.pages.create({
    parent: { database_id: toUUID(OPPORTUNITIES_DB_ID) },
    properties
  });
  const created = mapPageToApplication(response);
  created.status = data.status;
  created.relatedTimelineId = timelineId || undefined;
  return created;
}

async function updateApplicationViaSchema(id: string, data: Partial<JobApplication>): Promise<JobApplication> {
  const schema = await getOpportunityDatabaseProperties();
  const properties = buildOpportunityPropertiesFromSchema(schema, data);
  if (Object.keys(properties).length === 0) {
    const page = await notion!.pages.retrieve({ page_id: id });
    return mapPageToApplication(page);
  }

  const response = await notion!.pages.update({ page_id: id, properties });
  const updated = mapPageToApplication(response);
  if (data.status) updated.status = data.status;
  return updated;
}

export async function updateApplicationStage(id: string, newStage: ApplicationStage): Promise<JobApplication> {
  const idx = mockApplications.findIndex(a => a.id === id);
  if (idx > -1) {
    mockApplications[idx].status = newStage;
    mockApplications[idx].lastUpdated = new Date().toISOString().split('T')[0];
    return mockApplications[idx];
  }

  if (!notion) {
    throw new Error('Notion client not initialized');
  }

  const app = (await fetchApplications()).find(a => a.id === id);
  if (!app) {
    throw new Error(`Opportunity not found: ${id}`);
  }

  let timelineId = app.relatedTimelineId;

  // Auto-create connected timeline page if missing
  if (!timelineId && isTimelineConfigured && APPLICATION_TIMELINE_DB_ID) {
    try {
      const timelineResponse = await notion.pages.create({
        parent: { database_id: APPLICATION_TIMELINE_DB_ID },
        properties: {
          'Name': {
            title: [{ text: { content: newStage } }]
          }
        }
      });
      timelineId = timelineResponse.id;
      
      // Update the relation on the Opportunity page
      await notion.pages.update({
        page_id: id,
        properties: {
          'Application Timeline': { relation: [{ id: timelineId }] }
        }
      });
    } catch (createErr) {
      console.error('[JCC] Failed to auto-create missing timeline page:', createErr);
    }
  }

  if (timelineId) {
    try {
      // Try updating Name title
      await notion.pages.update({
        page_id: timelineId,
        properties: {
          'Name': {
            title: [{ text: { content: newStage } }]
          }
        }
      });
    } catch {
      // Fallback to title property
      try {
        await notion.pages.update({
          page_id: timelineId,
          properties: {
            'title': {
              title: [{ text: { content: newStage } }]
            }
          }
        });
      } catch (e2) {
        console.error('[JCC] Failed to update stage in connected timeline page:', e2);
      }
    }
  }

  // Update Last Updated and Status on Opportunity page
  // Resolve status against live schema to avoid crashes from invalid status names
  try {
    const mappedStatus = mapStageToNotionStatus(newStage);
    const properties: any = {
      '⏳ Last Contacted': {
        date: { start: new Date().toISOString().split('T')[0] }
      }
    };

    // Try schema-aware status resolution first
    try {
      const schema = await getOpportunityDatabaseProperties();
      const statusKey = findPropertyKey(schema, ['Status'], 'status');
      if (statusKey) {
        const options = schemaOptionsForProperty(schema[statusKey]);
        const resolved = resolveStatusOption(options, newStage);
        if (resolved) {
          properties[statusKey] = { status: { name: resolved } };
        }
      }
    } catch {
      // Schema fetch failed — use hardcoded property name with mapped value
      properties['Status'] = { status: { name: mappedStatus } };
    }

    const response = await notion.pages.update({
      page_id: id,
      properties
    });

    const updatedApp = mapPageToApplication(response);
    updatedApp.status = newStage; // local override since Notion cache might lag
    updatedApp.relatedTimelineId = timelineId || undefined;
    return updatedApp;
  } catch (err) {
    console.error('[JCC] Failed to update Status on Opportunity:', err);
    throw err;
  }
}

export async function updateApplication(id: string, data: Partial<JobApplication>): Promise<JobApplication> {
  const idx = mockApplications.findIndex(a => a.id === id);
  if (idx > -1) {
    mockApplications[idx] = { ...mockApplications[idx], ...data };
    return mockApplications[idx];
  }

  if (!notion) {
    throw new Error('Notion client not initialized');
  }

  try {
    const updated = await updateApplicationViaSchema(id, data);
    cachedSchemaOptions = null;
    return updated;
  } catch (schemaWriteError) {
    console.error('[JCC] Schema-driven opportunity update failed; trying legacy writer:', schemaWriteError);
  }

  try {
    const properties: any = {};
    if (data.role) {
      properties['💼 Role'] = {
        select: { name: data.role.split(',')[0].trim() }
      };
    }
    if (data.company) {
      properties['🏢 Company'] = { title: [{ text: { content: data.company } }] };
    }
    if (data.client) {
      properties['🤝 Client'] = { select: { name: data.client } };
    }
    if (data.type) {
      properties['🧭 Recruiter Type'] = { select: { name: data.type === 'inbound' ? '📥 Inbound' : '📤 Outbound' } };
    }
    if (data.interviewRounds) {
      properties['🪜 Total Rounds'] = { select: { name: data.interviewRounds } };
    }
    if (data.roundPlan) {
      properties['🗺️ Round Plan'] = {
        multi_select: data.roundPlan.split(',').map(r => ({ name: r.trim() })).filter(r => r.name !== '')
      };
    }
    if (data.priority) {
      properties['🔥 Priority'] = { select: { name: data.priority } };
    }
    if (data.recruiterName !== undefined) {
      properties['👤 Recruiter Name'] = { rich_text: [{ text: { content: data.recruiterName } }] };
    }
    if (data.recruiterPhone) {
      properties['📱 Recruiter Contact'] = { rich_text: [{ text: { content: data.recruiterPhone } }] };
    }
    if (data.recruiterEmail) {
      properties['📧 Recruiter Email'] = { email: data.recruiterEmail };
    }
    if (data.recruiterLinkedin) {
      properties['🔗 LinkedIn URL'] = { url: data.recruiterLinkedin };
    }
    if (data.location) {
      properties['📍 Location'] = { select: { name: data.location } };
    }
    if (data.workMode) {
      properties['🏠 Work Mode'] = { select: { name: data.workMode } };
    }
    if (data.salary) {
      properties['💸 Salary'] = { select: { name: data.salary } };
    }
    if (data.interviewMode) {
      properties['🎥 Interview Mode'] = { select: { name: data.interviewMode } };
    }
    if (data.employmentType) {
      properties['📑 Employment Type'] = { select: { name: data.employmentType } };
    }
    if (data.lastContactedDate) {
      properties['⏳ Last Contacted'] = { date: { start: data.lastContactedDate } };
    }
    if (data.companyType) {
      properties['🏛️ Company Type'] = { select: { name: data.companyType } };
    }
    if (data.companySize) {
      properties['Company Count'] = { select: { name: data.companySize } };
    }
    if (data.resumeSent !== undefined) {
      properties['📤 Resume Sent'] = { checkbox: data.resumeSent };
    }
    if (data.resumeSentOn) {
      properties['Resume Sent On'] = { date: { start: data.resumeSentOn } };
    }
    if (data.receivedCallOn) {
      properties['📞 Received Call On'] = { date: { start: data.receivedCallOn } };
    }
    // NOTE: callStatus is a status property — skip in legacy writer to avoid
    // crashes when the value doesn't match the DB schema. The schema-driven
    // writer (updateApplicationViaSchema) handles this safely.
    if (data.followupChannel) {
      properties['Follow-up Channel'] = { select: { name: data.followupChannel } };
    }
    if (data.notes !== undefined) {
      properties['📚 Notes'] = { rich_text: [{ text: { content: data.notes } }] };
    }

    const response = await notion.pages.update({
      page_id: id,
      properties
    });

    const updated = mapPageToApplication(response);
    cachedSchemaOptions = null;
    if (data.status) {
      return await updateApplicationStage(id, data.status);
    }
    return updated;
  } catch (e) {
    console.error('Failed to update opportunity details in Notion:', e);
    throw e;
  }
}

export async function getDashboardMetrics(): Promise<DashboardMetrics> {
  const applications = await fetchApplications();
  const recruiters = await fetchRecruiters();
  const todayStr = '2026-06-04';

  // 1. Total Opportunities = Active applications in pipeline (sourcing, screening, interview)
  const activeApplications = applications.filter(a => 
    ['sourcing', 'screening', 'interview'].includes(mapRawStatusToBaseStage(a.status))
  );
  const totalOpportunities = activeApplications.length;

  // 2. Active Recruiters = Unique recruiters extracted
  const activeRecruiters = recruiters.length;

  // 3. Interviews Count = Applications in interview stage
  const interviewsCount = applications.filter(a => mapRawStatusToBaseStage(a.status) === 'interview').length;

  // 4. Offers Count = Applications with offered stage
  const offersCount = applications.filter(a => mapRawStatusToBaseStage(a.status) === 'offered').length;

  // 5. Response Rate: percentage of applications that replied (screening or beyond vs total)
  const totalApplications = applications.length;
  const respondedApplications = applications.filter(
    a => ['screening', 'interview', 'offered', 'rejected'].includes(mapRawStatusToBaseStage(a.status))
  ).length;
  const responseRate = totalApplications > 0 ? Math.round((respondedApplications / totalApplications) * 100) : 0;

  // Group applications dynamically per week (past 3 weeks relative to 2026-06-04)
  const today = new Date('2026-06-04');
  const msInWeek = 7 * 24 * 60 * 60 * 1000;
  
  const w3Count = applications.filter(a => {
    const diff = today.getTime() - new Date(a.lastUpdated).getTime();
    return diff >= 0 && diff < msInWeek;
  }).length;
  const w2Count = applications.filter(a => {
    const diff = today.getTime() - new Date(a.lastUpdated).getTime();
    return diff >= msInWeek && diff < 2 * msInWeek;
  }).length;
  const w1Count = applications.filter(a => {
    const diff = today.getTime() - new Date(a.lastUpdated).getTime();
    return diff >= 2 * msInWeek && diff < 3 * msInWeek;
  }).length;

  const applicationsPerWeek = [
    { week: '2 Weeks Ago', count: w1Count },
    { week: 'Last Week', count: w2Count },
    { week: 'This Week', count: w3Count }
  ];

  // Recruiter responses per vendor
  const responseCountsMap: Record<string, number> = {};
  recruiters.forEach(r => {
    if (r.company) {
      responseCountsMap[r.company] = (responseCountsMap[r.company] || 0) + 1;
    }
  });
  const recruiterResponses = Object.entries(responseCountsMap)
    .map(([name, count]) => ({ name, count }))
    .slice(0, 5);

  // Interview Trend dynamically grouped by weekday
  const daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  const dayCounts: Record<string, number> = { Mon: 0, Tue: 0, Wed: 0, Thu: 0, Fri: 0 };
  
  applications.filter(a => mapRawStatusToBaseStage(a.status) === 'interview').forEach(a => {
    const date = new Date(a.lastUpdated);
    const dayName = daysOfWeek[date.getDay()];
    if (dayCounts[dayName] !== undefined) {
      dayCounts[dayName]++;
    } else {
      if (dayName === 'Sat') dayCounts['Fri']++;
      else if (dayName === 'Sun') dayCounts['Mon']++;
    }
  });

  const interviewTrend = Object.entries(dayCounts).map(([date, count]) => ({
    date,
    count
  }));

  // Follow-ups due: active recruiters with nextFollowUp <= today
  const followUpsDue = recruiters.filter(r => {
    if (!r.nextFollowUp) return false;
    return r.nextFollowUp <= todayStr && r.contactStatus !== 'offered' && r.contactStatus !== 'rejected';
  });

  // Latest activity: sorted by lastUpdated desc
  const latestActivity = [...applications]
    .sort((a, b) => (b.lastUpdated || '').localeCompare(a.lastUpdated || ''))
    .slice(0, 5);

  // Upcoming interviews: applications in interview status or timeline events in next 24 hours
  const nowTime = new Date();
  const twentyFourHoursFromNow = new Date(nowTime.getTime() + 24 * 60 * 60 * 1000);
  const todayDateStr = nowTime.toISOString().split('T')[0];
  const tomorrowDateStr = new Date(nowTime.getTime() + 24 * 60 * 60 * 1000).toISOString().split('T')[0];

  const isUpcoming24h = (dateStr?: string) => {
    if (!dateStr) return false;
    const d = new Date(dateStr);
    if (isNaN(d.getTime())) return false;
    const cleanDate = dateStr.split('T')[0];
    if (cleanDate === todayDateStr || cleanDate === tomorrowDateStr) return true;
    return d >= nowTime && d <= twentyFourHoursFromNow;
  };

  let upcomingInterviews: JobApplication[] = [];

  if (isTokenConfigured && isTimelineConfigured && APPLICATION_TIMELINE_DB_ID && notion) {
    try {
      console.log('[JCC] Querying timeline events for upcoming interviews...');
      const allEvents = await queryAllPages(APPLICATION_TIMELINE_DB_ID);
      
      const upcomingEventOppIds = allEvents.filter(page => {
        const props = page.properties;
        const category = props['🎯 Event Category']?.select?.name || '';
        const dateStr = props['📅 Event Date']?.date?.start || '';
        if (!category.toLowerCase().includes('interview') || !dateStr) return false;
        return isUpcoming24h(dateStr);
      }).map(page => page.properties['Oppurtunity']?.relation?.[0]?.id).filter(Boolean);
      
      upcomingInterviews = applications.filter(a => upcomingEventOppIds.includes(a.id));
    } catch (e) {
      console.error('[JCC] Failed to fetch upcoming interviews from timeline:', e);
    }
  }

  // Also check direct fields on the application for upcoming 24h
  const directUpcoming = applications.filter(a => {
    const isInterviewStage = mapRawStatusToBaseStage(a.status) === 'interview';
    return isInterviewStage && (isUpcoming24h(a.receivedCallOn) || isUpcoming24h(a.lastContactedDate));
  });

  // Combine them without duplicates
  const upcomingMap = new Map<string, JobApplication>();
  upcomingInterviews.forEach(a => upcomingMap.set(a.id, a));
  directUpcoming.forEach(a => upcomingMap.set(a.id, a));
  upcomingInterviews = Array.from(upcomingMap.values());

  // Fallback: if no upcoming interviews are found from timeline/fields,
  // we fallback to showing applications in interview status
  if (upcomingInterviews.length === 0) {
    upcomingInterviews = applications
      .filter(a => mapRawStatusToBaseStage(a.status) === 'interview')
      .slice(0, 4);
  }

  const inboundCount = applications.filter(a => a.type === 'inbound').length;
  const outboundCount = applications.filter(a => a.type === 'outbound').length;
  const historyCount = applications.length;

  return {
    totalOpportunities,
    activeRecruiters,
    interviewsCount,
    offersCount,
    responseRate,
    totalApplications,
    respondedApplications,
    applicationsPerWeek,
    recruiterResponses,
    interviewTrend,
    followUpsDue,
    latestActivity,
    upcomingInterviews,
    companiesCount: 0,
    inboundCount,
    outboundCount,
    historyCount,
    allApplications: applications
  };
}

export async function createApplication(data: Partial<JobApplication>): Promise<JobApplication> {
  const newApp: JobApplication = {
    id: `app-generated-${Date.now()}`,
    role: data.role || 'Frontend Developer',
    company: data.company || 'New Company',
    client: data.client || 'Direct',
    type: data.type || 'outbound',
    status: data.status || 'sourcing',
    lastUpdated: new Date().toISOString().split('T')[0],
    priority: data.priority || 'Medium',
    recruiterName: data.recruiterName || '',
    recruiterCompany: data.recruiterCompany || '',
    recruiterPhone: data.recruiterPhone || '',
    recruiterEmail: data.recruiterEmail || '',
    recruiterLinkedin: data.recruiterLinkedin || '',
    applicationUrl: data.applicationUrl || '',
    location: data.location || '',
    workMode: data.workMode || 'Hybrid',
    salary: data.salary,
    employmentType: data.employmentType,
    companyType: data.companyType,
    interviewRounds: data.interviewRounds,
    roundPlan: data.roundPlan,
    interviewMode: data.interviewMode,
    receivedCallOn: data.receivedCallOn,
    callStatus: data.callStatus,
    resumeSent: data.resumeSent,
    resumeSentOn: data.resumeSentOn,
    lastContactedDate: data.lastContactedDate,
    followupChannel: data.followupChannel,
    notes: data.notes
  };

  mockApplications.unshift(newApp);

  if (!notion || !isOpportunitiesConfigured || !OPPORTUNITIES_DB_ID) {
    return newApp;
  }

  try {
    let timelineId = '';
    if (isTimelineConfigured && APPLICATION_TIMELINE_DB_ID) {
      try {
        const timelineResponse = await notion.request<any>({
          path: 'pages',
          method: 'post',
          body: {
            parent: { database_id: APPLICATION_TIMELINE_DB_ID },
            properties: {
              'Name': {
                title: [{ text: { content: mapStageToNotionStatus(newApp.status) } }]
              }
            }
          }
        });
        timelineId = timelineResponse.id;
      } catch (err) {
        console.error('[JCC] Warning: Failed to create timeline page. Will create opportunity without timeline.', err);
      }
    }

    const properties: any = {
      '🏢 Company': { title: [{ text: { content: newApp.company } }] },
      '🤝 Client': { select: { name: newApp.client } },
      '🧭 Recruiter Type': { select: { name: newApp.type === 'inbound' ? '📥 Inbound' : '📤 Outbound' } },
      '🔥 Priority': { select: { name: newApp.priority } },
      '🏠 Work Mode': { select: { name: newApp.workMode } },
      '⏳ Last Contacted': { date: { start: newApp.lastContactedDate || newApp.lastUpdated } }
    };

    if (newApp.role) properties['💼 Role'] = { select: { name: newApp.role.split(',')[0].trim() } };
    if (newApp.location) properties['📍 Location'] = { select: { name: newApp.location } };
    if (newApp.recruiterName) properties['👤 Recruiter Name'] = { rich_text: [{ text: { content: newApp.recruiterName } }] };
    if (newApp.companyType) properties['🏛️ Company Type'] = { select: { name: newApp.companyType } };
    if (newApp.companySize) properties['🏢 Company Size'] = { select: { name: newApp.companySize } };
    if (newApp.recruiterPhone) properties['📱 Recruiter Contact'] = { rich_text: [{ text: { content: newApp.recruiterPhone } }] };
    if (newApp.recruiterEmail) properties['📧 Recruiter Email'] = { email: newApp.recruiterEmail };
    if (newApp.recruiterLinkedin) properties['🔗 LinkedIn URL'] = { url: newApp.recruiterLinkedin };
    // NOTE: Status is a status property — skip in legacy writer to avoid
    // crashes when the mapped value doesn't match the DB schema.
    // The schema-driven writer (createApplicationViaSchema) handles this safely.
    
    // New properties
    if (newApp.interviewRounds) properties['🪜 Total Rounds'] = { select: { name: newApp.interviewRounds } };
    if (newApp.roundPlan) properties['🗺️ Round Plan'] = { multi_select: newApp.roundPlan.split(',').map(r => ({ name: r.trim() })).filter(r => r.name !== '') };
    if (newApp.salary) properties['💸 Salary'] = { select: { name: newApp.salary } };
    if (newApp.interviewMode) properties['🎥 Interview Mode'] = { select: { name: newApp.interviewMode } };
    if (newApp.employmentType) properties['📑 Employment Type'] = { select: { name: newApp.employmentType } };
    if (newApp.receivedCallOn) properties['📞 Received Call On'] = { date: { start: newApp.receivedCallOn } };
    // NOTE: callStatus is a status property — skip in legacy writer (same reason as Status above).
    if (newApp.resumeSent !== undefined) properties['📤 Resume Sent'] = { checkbox: newApp.resumeSent };
    if (newApp.resumeSentOn) properties['Resume Sent On'] = { date: { start: newApp.resumeSentOn } };
    if (newApp.followupChannel) properties['Follow-up Channel'] = { select: { name: newApp.followupChannel } };
    if (newApp.notes !== undefined) properties['📚 Notes'] = { rich_text: [{ text: { content: newApp.notes } }] };
    
    if (timelineId) {
      properties['Application Timeline'] = { relation: [{ id: timelineId }] };
    }

    try {
      const created = await createApplicationViaSchema(newApp, timelineId || undefined);
      cachedSchemaOptions = null;
      return created;
    } catch (schemaWriteError) {
      console.error('[JCC] Schema-driven opportunity create failed; trying legacy writer:', schemaWriteError);
    }

    const response = await notion.request<any>({
      path: 'pages',
      method: 'post',
      body: {
        parent: { database_id: OPPORTUNITIES_DB_ID },
        properties
      }
    });

    const created = mapPageToApplication(response);
    created.status = newApp.status;
    created.relatedTimelineId = timelineId || undefined;
    cachedSchemaOptions = null;
    return created;
  } catch (e) {
    console.error('Failed to create opportunity in Notion:', e);
    throw e;
  }
}

// ----------------------------------------------------
// DYNAMIC NOTION JOB STORE ENGINE
// ----------------------------------------------------
let JOB_STORE_DB_ID_CACHE: string | null = null;

export async function getOrInitializeJobStoreDb(): Promise<string | null> {
  if (JOB_STORE_DB_ID_CACHE) return JOB_STORE_DB_ID_CACHE;
  if (!notion || !isTokenConfigured) return null;

  try {
    // 1. Search for existing "💼 Job Store" database
    const searchRes = await fetch('https://api.notion.com/v1/search', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.NOTION_TOKEN}`,
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        query: '💼 Job Store',
        filter: { property: 'object', value: 'database' }
      }),
      cache: 'no-store'
    });

    if (searchRes.ok) {
      const data = await searchRes.json();
      const existing = data.results?.find((d: any) => d.title?.[0]?.plain_text === '💼 Job Store');
      if (existing) {
        JOB_STORE_DB_ID_CACHE = existing.id;
        return existing.id;
      }
    }

    // 2. Not found: create a new database inside the parent page container
    // We target the page_id of 'Application Timeline' since it is a regular page in the workspace parent.
    const parentBody = { type: 'page_id', page_id: '47d5bede-0c3a-8374-9b0a-01db0554254c' };

    const createRes = await fetch('https://api.notion.com/v1/databases', {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${process.env.NOTION_TOKEN}`,
        'Notion-Version': '2022-06-28',
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        parent: parentBody,
        title: [
          {
            type: 'text',
            text: { content: '💼 Job Store' }
          }
        ],
        properties: {
          'Name': { title: {} },
          'Company': { rich_text: {} },
          'Location': { rich_text: {} },
          'Portal': { select: {} },
          'URL': { url: {} },
          'YOE': { rich_text: {} },
          'Skills': { multi_select: {} },
          'Relevance Score': { number: {} },
          'Date Sync': { date: {} }
        }
      })
    });

    if (!createRes.ok) {
      const errText = await createRes.text();
      console.error('[JCC] Failed to dynamically create Notion Job Store:', errText);
      return null;
    }

    const newDb = await createRes.json();
    JOB_STORE_DB_ID_CACHE = newDb.id;
    console.log('[JCC] Dynamically created 💼 Job Store Database in Notion with ID:', newDb.id);
    return newDb.id;

  } catch (e) {
    console.error('[JCC] Failed to initialize Notion Job Store database:', e);
    return null;
  }
}

export async function fetchJobsFromNotionStore(): Promise<any[]> {
  const dbId = await getOrInitializeJobStoreDb();
  if (!dbId || !notion) return [];

  try {
    const rawPages = await queryAllPages(dbId);
    return rawPages.map((page: any) => {
      const props = page.properties;
      return {
        id: page.id,
        title: props['Name']?.title?.[0]?.plain_text || 'Untitled Job',
        company: props['Company']?.rich_text?.[0]?.plain_text || 'Unknown Company',
        location: props['Location']?.rich_text?.[0]?.plain_text || 'Remote',
        portal: props['Portal']?.select?.name || 'Career Site',
        url: props['URL']?.url || '',
        experience: props['YOE']?.rich_text?.[0]?.plain_text || '4-5 Years',
        skills: props['Skills']?.multi_select?.map((x: any) => x.name) || [],
        companyScore: props['Relevance Score']?.number || undefined,
        datePosted: props['Date Sync']?.date?.start || 'Today'
      };
    });
  } catch (e) {
    console.error('[JCC] Failed to fetch cached jobs from Notion Store:', e);
    return [];
  }
}

export async function bulkUpsertJobsToNotionStore(jobsList: any[]): Promise<void> {
  const dbId = await getOrInitializeJobStoreDb();
  if (!dbId || !notion) return;

  try {
    // Fetch existing jobs to avoid duplicating URLs
    const existing = await fetchJobsFromNotionStore();
    const existingUrls = new Set(existing.map(j => j.url.toLowerCase()));

    for (const job of jobsList) {
      if (existingUrls.has(job.url.toLowerCase())) continue;

      const properties: any = {
        'Name': { title: [{ text: { content: job.title } }] },
        'Company': { rich_text: [{ text: { content: job.company } }] },
        'Location': { rich_text: [{ text: { content: job.location } }] },
        'Portal': { select: { name: job.portal } },
        'URL': { url: job.url },
        'YOE': { rich_text: [{ text: { content: job.experience } }] },
        'Skills': { multi_select: job.skills.map((s: string) => ({ name: s.slice(0, 100) })).slice(0, 100) },
        'Date Sync': { date: { start: new Date().toISOString().split('T')[0] } }
      };

      if (job.companyScore !== undefined) {
        properties['Relevance Score'] = { number: job.companyScore };
      }

      await notion.pages.create({
        parent: { database_id: dbId },
        properties
      }).catch(err => {
        console.error('[JCC] Failed to write job page to Notion Store:', err.message);
      });
    }
  } catch (e) {
    console.error('[JCC] Bulk upsert failed:', e);
  }
}
