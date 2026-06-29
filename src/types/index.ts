export type ContactStatus =
  | 'New Lead'
  | 'Contacted'
  | 'Follow-up'
  | 'sourcing'
  | 'screening'
  | 'interview'
  | 'offered'
  | 'rejected'
  | 'No Response'
  | string;

export type Recruiter = {
  id: string;
  company: string;
  client: string;
  role: string;
  recruiterName: string;
  recruiterPhone?: string;
  recruiterEmail?: string;
  recruiterLinkedin?: string;
  contactStatus: ContactStatus;
  contactMethod?: string;
  lastContacted?: string; // YYYY-MM-DD
  nextFollowUp?: string;  // YYYY-MM-DD
  priority?: 'High' | 'Medium' | 'Low';
  source?: string;
  applicationUrl?: string;
  dbSource: 'inbound' | 'outbound';
  relatedTimelineId?: string; // ID of the related page in Application Timeline
};

export type ApplicationStage =
  | 'sourcing'
  | 'screening'
  | 'interview'
  | 'offered'
  | 'rejected'
  | string;

export type JobApplication = {
  id: string;
  role: string;
  company: string;
  client: string;
  type: 'inbound' | 'outbound';
  status: ApplicationStage;
  lastUpdated: string; // YYYY-MM-DD
  location?: string;
  workMode?: string;
  salary?: string;
  interviewRounds?: string; // feedback
  roundPlan?: string;        // prep
  applicationUrl?: string;
  priority?: 'High' | 'Medium' | 'Low';
  recruiterName?: string;
  recruiterCompany?: string;
  recruiterPhone?: string;
  recruiterEmail?: string;
  recruiterLinkedin?: string;
  relatedTimelineId?: string; // ID of the related page in Application Timeline
  callStatus?: string;
  resumeSentOn?: string;
  receivedCallOn?: string;
  interviewMode?: string;
  employmentType?: string;
  lastContactedDate?: string;
  companyType?: string;
  companySize?: string;
  resumeSent?: boolean;
  followupChannel?: string;
  notes?: string;
};

export type DashboardMetrics = {
  totalOpportunities: number; // active applications (excluding rejected and offered)
  activeRecruiters: number;   // total recruiters
  interviewsCount: number;    // applications in interview stage
  offersCount: number;        // applications in offered stage
  responseRate: number;       // percentage of applications that replied (screening or beyond vs total)
  totalApplications: number;  // total applications tracked
  respondedApplications: number; // applications that replied (screening or beyond)
  applicationsPerWeek: { week: string; count: number }[];
  recruiterResponses: { name: string; count: number }[];
  interviewTrend: { date: string; count: number }[];
  followUpsDue: Recruiter[];
  latestActivity: JobApplication[];
  upcomingInterviews: JobApplication[];
  companiesCount?: number;
  inboundCount?: number;
  outboundCount?: number;
  historyCount?: number;
  allApplications: JobApplication[];
};

export type TimelineEvent = {
  id: string;
  opportunity: string;
  title: string;
  date: string;
  category: string;
  virtualMode: string;
  notes: string;
};
