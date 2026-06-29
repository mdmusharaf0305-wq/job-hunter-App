'use server';

import { revalidatePath, revalidateTag } from 'next/cache';
import fs from 'fs';
import path from 'path';

import { 
  fetchRecruiters, 
  updateRecruiter, 
  fetchApplications, 
  updateApplicationStage, 
  updateApplication, 
  getDashboardMetrics,
  createApplication,
  getDatabaseSchemaOptions,
  NotionSchemaOptions,
  clearSchemaCache
} from '../lib/notion/client';
import { Recruiter, JobApplication, ApplicationStage, ContactStatus, DashboardMetrics } from '../types';

const EMPTY_DASHBOARD_METRICS: DashboardMetrics = {
  totalOpportunities: 0,
  activeRecruiters: 0,
  interviewsCount: 0,
  offersCount: 0,
  responseRate: 0,
  totalApplications: 0,
  respondedApplications: 0,
  applicationsPerWeek: [],
  recruiterResponses: [],
  interviewTrend: [],
  followUpsDue: [],
  latestActivity: [],
  upcomingInterviews: [],
  companiesCount: 0,
  inboundCount: 0,
  outboundCount: 0,
  historyCount: 0,
  allApplications: [],
};

function withTimeout<T>(promise: Promise<T>, timeoutMs: number, label: string): Promise<T> {
  return Promise.race([
    promise,
    new Promise<T>((_, reject) => {
      setTimeout(() => reject(new Error(`${label} timed out after ${timeoutMs}ms`)), timeoutMs);
    }),
  ]);
}

export async function getDatabaseSchemaOptionsAction(): Promise<NotionSchemaOptions> {
  try {
    return await getDatabaseSchemaOptions();
  } catch (error) {
    console.error('Action error getting schema options:', error);
    throw new Error('Failed to fetch schema options');
  }
}

export async function getRecruitersAction(): Promise<Recruiter[]> {
  try {
    return await fetchRecruiters();
  } catch (error) {
    console.error('Action error fetching recruiters:', error);
    throw new Error('Failed to fetch recruiters');
  }
}

export async function updateRecruiterStatusAction(id: string, newStatus: string): Promise<Recruiter> {
  try {
    // Maps status change to recruiter update
    const updated = await updateRecruiter(id, { 
      contactStatus: newStatus as ContactStatus,
      lastContacted: new Date().toISOString().split('T')[0]
    });
    revalidatePath('/', 'layout');
    return updated;
  } catch (error) {
    console.error('Action error updating recruiter status:', error);
    throw new Error('Failed to update recruiter status');
  }
}

export async function updateRecruiterAction(id: string, data: Partial<Recruiter>): Promise<Recruiter> {
  try {
    const updated = await updateRecruiter(id, data);
    revalidatePath('/', 'layout');
    return updated;
  } catch (error) {
    console.error('Action error updating recruiter details:', error);
    throw new Error('Failed to update recruiter details');
  }
}

export async function getDashboardMetricsAction(): Promise<DashboardMetrics> {
  try {
    const metrics = await withTimeout(getDashboardMetrics(), 8000, 'Dashboard metrics');
    
    // Compute companiesCount here on the server side
    let companiesCount = 0;
    try {
      const dbCompaniesSet = new Set<string>();
      const formatCompanyName = (name: string): string => {
        const titleCase = (str: string) => {
          return str
            .toLowerCase()
            .split(' ')
            .map(word => word.charAt(0).toUpperCase() + word.slice(1))
            .join(' ');
        };
        const upper = name.toUpperCase();
        const acronyms = ['TCS', 'IBM', 'JPMC', 'CRED', 'MNC', 'IT', 'LTI', 'EY', 'DXC', 'HCL', 'UST', 'JSW', 'NLB', 'CGI', 'PITCS', 'RGBSI', 'EY-3', 'ICICI', 'HP', 'GE', 'SBI', 'ITC'];
        if (acronyms.includes(upper)) return upper;
        return titleCase(name);
      };

      metrics.allApplications.forEach(app => {
        let targetCompName = "";
        const isClientValid = app.client && !['direct', 'n/a', 'unknown', ''].includes(app.client.toLowerCase());
        if (isClientValid) {
          targetCompName = app.client.trim();
        } else if (app.company && app.company.toLowerCase() !== 'unknown') {
          targetCompName = app.company.trim();
        }

        if (targetCompName) {
          const nameLower = targetCompName.toLowerCase();
          const agencyKeywords = ['consulting', 'consultancy', 'staffing', 'talent', 'recruitment', 'solutions', 'placements', 'hr services', 'manpower', 'agency', 'partners'];
          const isAgency = agencyKeywords.some(keyword => nameLower.includes(keyword));
          if (!isAgency) {
            dbCompaniesSet.add(formatCompanyName(targetCompName));
          }
        }
      });

      const filePath = path.join(process.cwd(), 'src/config/companies.json');
      if (fs.existsSync(filePath)) {
        const fileContent = fs.readFileSync(filePath, 'utf-8');
        const companies = JSON.parse(fileContent);
        companies.forEach((c: { name: string }) => {
          dbCompaniesSet.add(formatCompanyName(c.name));
        });
      }
      companiesCount = dbCompaniesSet.size;
    } catch (err) {
      console.error('Error computing companies count in action:', err);
    }
    
    return {
      ...metrics,
      companiesCount
    };
  } catch (error) {
    console.error('Action error getting dashboard metrics:', error);
    return EMPTY_DASHBOARD_METRICS;
  }
}

export async function getApplicationsAction(): Promise<JobApplication[]> {
  try {
    return await fetchApplications();
  } catch (error) {
    console.error('Action error fetching applications:', error);
    throw new Error('Failed to fetch applications');
  }
}

export async function updateApplicationStageAction(id: string, newStage: string): Promise<JobApplication> {
  try {
    const updated = await updateApplicationStage(id, newStage as ApplicationStage);
    revalidatePath('/', 'layout');
    return updated;
  } catch (error) {
    console.error('Action error updating application stage:', error);
    throw new Error('Failed to update application stage');
  }
}

export async function updateApplicationAction(id: string, data: Partial<JobApplication>): Promise<JobApplication> {
  try {
    const updated = await updateApplication(id, data);
    clearSchemaCache();
    revalidateTag('notion-schema', 'max');
    revalidatePath('/', 'layout');
    return updated;
  } catch (error) {
    const err = error as { body?: unknown; message?: string };
    console.error('Action error updating application details:', err.body || error);
    throw new Error(`Failed to update application details: ${err.message || JSON.stringify(err.body) || 'Unknown error'}`);
  }
}

export async function createApplicationAction(data: Partial<JobApplication>): Promise<JobApplication> {
  try {
    const created = await createApplication(data);
    clearSchemaCache();
    revalidateTag('notion-schema', 'max');
    revalidatePath('/', 'layout');
    return created;
  } catch (error) {
    const err = error as { body?: unknown; message?: string };
    console.error('Action error creating application:', err.body || error);
    throw new Error(`Failed to create application: ${err.message || JSON.stringify(err.body) || 'Unknown error'}`);
  }
}
