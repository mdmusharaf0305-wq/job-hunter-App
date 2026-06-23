'use server';

import { revalidatePath, revalidateTag } from 'next/cache';

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
    return await withTimeout(getDashboardMetrics(), 8000, 'Dashboard metrics');
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
