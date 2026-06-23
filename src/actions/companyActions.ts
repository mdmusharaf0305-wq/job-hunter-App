'use server';

import fs from 'fs';
import path from 'path';
import { getCandidateProfileAction } from './jobActions';
import { getApplicationsAction } from './recruiterActions';

export interface Company {
  name: string;
  tier: number;
  techStack: string[];
  hiringFrequency: number;
  salaryPotential: number;
  engineeringCulture: number;
  remoteFlexibility: string[];
  growthPotential: number;
  website: string;
  headquarters: string;
  ats?: string;
  slug?: string;
  board?: string;
  relevanceScore?: number;
  authenticityScore?: number;
  authenticityBadge?: '✓ Direct Employer' | 'Product Company' | 'Service Company' | 'Recruitment Agency' | 'Needs Verification';
  scoreBreakdown?: {
    skillAlignment: number;
    hiringFrequency: number;
    salaryPotential: number;
    engineeringCulture: number;
    remoteFlexibility: number;
    growthPotential: number;
  };
}

// ----------------------------------------------------
// Company Authenticity Engine
// ----------------------------------------------------
function getCompanyAuthenticity(name: string, ats?: string, tier?: number): { score: number, badge: Company['authenticityBadge'] } {
  const nameLower = name.toLowerCase();
  
  // Rule 1: Agency/Consultancy Name Penalities
  const agencyKeywords = [
    'consulting', 'consultancy', 'staffing', 'talent', 'recruitment', 
    'solutions', 'placements', 'hr services', 'manpower', 'peoplefy', 
    'randstad', 'tekpillar', 'allegis', 'talent500', 'hiring', 'partners',
    'search', 'associates', 'careers group'
  ];
  
  const isAgencyPattern = agencyKeywords.some(keyword => nameLower.includes(keyword));

  // Determine base tier and score
  let score = 50; // Base score for unknown
  let badge: Company['authenticityBadge'] = 'Needs Verification';

  if (tier === 1) {
    score = 98;
    badge = '✓ Direct Employer';
  } else if (tier === 2) {
    score = 90;
    badge = 'Product Company';
  } else if (tier === 3) {
    score = 80;
    badge = 'Product Company';
  } else if (tier === 4) {
    score = 75;
    badge = 'Service Company';
  } else if (tier === 5) {
    score = 82;
    badge = 'Product Company'; // Hidden Gems default to Product Company
  }

  // Boost based on Greenhouse/Lever/Ashby ATS presence
  if (ats && ['greenhouse', 'lever', 'ashby'].includes(ats.toLowerCase())) {
    score += 15;
  }

  // Apply penalties if name matches consultancy/staffing patterns
  if (isAgencyPattern) {
    score = Math.max(10, score - 50); // Heavily reduce score
    badge = 'Recruitment Agency';
  }

  // Adjust score bounds to categories
  score = Math.max(0, Math.min(100, score));

  if (score >= 95) {
    badge = '✓ Direct Employer';
  } else if (score >= 80) {
    badge = 'Product Company';
  } else if (score >= 60) {
    badge = 'Service Company';
  } else if (score >= 20) {
    badge = 'Recruitment Agency';
  } else {
    badge = 'Needs Verification';
  }

  return { score, badge };
}

export async function getCompaniesAction(): Promise<Company[]> {
  const filePath = path.join(process.cwd(), 'src/config/companies.json');
  try {
    const fileContent = fs.readFileSync(filePath, 'utf-8');
    const companies: Company[] = JSON.parse(fileContent);

    // Get active candidate profile to compute dynamic scores
    const profile = await getCandidateProfileAction();

    // Fetch Notion application opportunities to dynamically add their companies/clients
    const apps = await getApplicationsAction().catch(() => []);
    const dbCompaniesSet = new Set<string>();
    
    apps.forEach(app => {
      // Avoid consultancies: only add direct companies (clients if available, or company if client is direct)
      let targetCompName = "";
      
      const isClientValid = app.client && !['direct', 'n/a', 'unknown', ''].includes(app.client.toLowerCase());
      if (isClientValid) {
        targetCompName = app.client!.trim();
      } else if (app.company && app.company.toLowerCase() !== 'unknown') {
        targetCompName = app.company.trim();
      }

      if (targetCompName) {
        // Filter out agency names before adding to DB watchlist
        const nameLower = targetCompName.toLowerCase();
        const agencyKeywords = ['consulting', 'consultancy', 'staffing', 'talent', 'recruitment', 'solutions', 'placements', 'hr services', 'manpower', 'agency', 'partners'];
        const isAgency = agencyKeywords.some(keyword => nameLower.includes(keyword));
        if (!isAgency) {
          dbCompaniesSet.add(targetCompName);
        }
      }
    });

    // Add DB companies that aren't already in companies.json
    dbCompaniesSet.forEach(dbCompName => {
      const exists = companies.some(c => c.name.toLowerCase() === dbCompName.toLowerCase());
      if (!exists) {
        companies.push({
          name: dbCompName,
          tier: 3, // Defaults to Tier 3 Startup
          techStack: [...profile.requiredSkills], // Align tech stack to profile for maximum matching score
          hiringFrequency: 75,
          salaryPotential: 80,
          engineeringCulture: 85,
          remoteFlexibility: [profile.remotePreference, "Remote", "Hybrid"],
          growthPotential: 80,
          website: `https://www.google.com/search?q=${encodeURIComponent(dbCompName)}+careers`,
          headquarters: "Bengaluru, India"
        });
      }
    });

    // Map and score all companies
    let enrichedCompanies = companies.map(c => {
      // Compute Authenticity Score
      const auth = getCompanyAuthenticity(c.name, c.ats, c.tier);

      // 1. Skill Alignment (35% Max)
      let skillAlignmentScore = 0;
      if (profile.requiredSkills.length > 0) {
        const matchingSkills = profile.requiredSkills.filter(skill =>
          c.techStack.some(ts => ts.toLowerCase().includes(skill.toLowerCase()))
        );
        skillAlignmentScore = Math.round((matchingSkills.length / profile.requiredSkills.length) * 100);
      } else {
        skillAlignmentScore = 100;
      }
      const weightedSkill = skillAlignmentScore * 0.35;

      // 2. Hiring Frequency (20% Max)
      const weightedHiring = c.hiringFrequency * 0.20;

      // 3. Salary Potential (15% Max)
      const weightedSalary = c.salaryPotential * 0.15;

      // 4. Engineering Culture (15% Max)
      const weightedCulture = c.engineeringCulture * 0.15;

      // 5. Remote Flexibility (10% Max)
      let remoteScore = 0;
      const profilePref = profile.remotePreference.toLowerCase();
      
      const hasRemote = c.remoteFlexibility.some(r => r.toLowerCase() === 'remote');
      const hasHybrid = c.remoteFlexibility.some(r => r.toLowerCase() === 'hybrid');
      const hasOnsite = c.remoteFlexibility.some(r => r.toLowerCase() === 'onsite');

      if (profilePref === 'remote' && hasRemote) remoteScore = 100;
      else if (profilePref === 'hybrid' && (hasHybrid || hasRemote)) remoteScore = 100;
      else if (profilePref === 'onsite' && (hasOnsite || hasHybrid)) remoteScore = 100;
      else if (hasHybrid) remoteScore = 50;

      const weightedRemote = remoteScore * 0.10;

      // 6. Growth Potential (5% Max)
      const weightedGrowth = c.growthPotential * 0.05;

      // Total Relevance Score (0-100)
      const totalScore = Math.round(
        weightedSkill +
        weightedHiring +
        weightedSalary +
        weightedCulture +
        weightedRemote +
        weightedGrowth
      );

      return {
        ...c,
        authenticityScore: auth.score,
        authenticityBadge: auth.badge,
        relevanceScore: totalScore,
        scoreBreakdown: {
          skillAlignment: Math.round(weightedSkill),
          hiringFrequency: Math.round(weightedHiring),
          salaryPotential: Math.round(weightedSalary),
          engineeringCulture: Math.round(weightedCulture),
          remoteFlexibility: Math.round(weightedRemote),
          growthPotential: Math.round(weightedGrowth)
        }
      };
    });

    // CRITICAL: Filter out recruitment agencies and unverified agencies (Score < 55) from the watchlist
    enrichedCompanies = enrichedCompanies.filter(c => (c.authenticityScore || 0) >= 55);

    return enrichedCompanies.sort((a, b) => (b.relevanceScore || 0) - (a.relevanceScore || 0));

  } catch (e) {
    console.error('Failed to load companies:', e);
    return [];
  }
}

export async function addCompanyToConfigAction(company: Omit<Company, 'relevanceScore' | 'authenticityScore' | 'authenticityBadge' | 'scoreBreakdown'>): Promise<boolean> {
  const filePath = path.join(process.cwd(), 'src/config/companies.json');
  try {
    const fileContent = fs.readFileSync(filePath, 'utf-8');
    const companies: Company[] = JSON.parse(fileContent);
    
    // Check if it already exists
    const exists = companies.some(c => c.name.toLowerCase() === company.name.toLowerCase());
    if (exists) {
      return false;
    }
    
    const titleCase = (str: string) => {
      return str
        .toLowerCase()
        .split(' ')
        .map(word => word.charAt(0).toUpperCase() + word.slice(1))
        .join(' ');
    };
    const upper = company.name.toUpperCase();
    const acronyms = ['TCS', 'IBM', 'JPMC', 'CRED', 'MNC', 'IT', 'LTI', 'EY', 'DXC', 'HCL', 'UST', 'JSW', 'NLB', 'CGI', 'PITCS', 'RGBSI', 'EY-3'];
    if (acronyms.includes(upper)) {
      company.name = upper;
    } else {
      company.name = titleCase(company.name);
    }
    companies.push(company);
    fs.writeFileSync(filePath, JSON.stringify(companies, null, 2), 'utf-8');
    return true;
  } catch (e) {
    console.error('Failed to add company to config:', e);
    return false;
  }
}
