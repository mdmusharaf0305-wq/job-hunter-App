'use server';

import fs from 'fs';
import path from 'path';

export interface CandidateProfile {
  experience: number;
  preferredRoles: string[];
  preferredLocations: string[];
  requiredSkills: string[];
  salaryExpectations: string;
  remotePreference: string;
}

const PROFILE_FILE_PATH = path.join(process.cwd(), 'src/config/candidateProfile.json');

function defaultCandidateProfile(): CandidateProfile {
  return {
    experience: 4.4,
    preferredRoles: ['Frontend Engineer', 'React Developer', 'Next.js Developer', 'Full Stack Developer'],
    preferredLocations: ['Bengaluru', 'Hyderabad', 'Remote'],
    requiredSkills: ['React', 'Next.js', 'TypeScript'],
    salaryExpectations: '15L - 25L',
    remotePreference: 'Hybrid',
  };
}

export async function getCandidateProfileAction(): Promise<CandidateProfile> {
  try {
    return JSON.parse(fs.readFileSync(PROFILE_FILE_PATH, 'utf-8'));
  } catch {
    return defaultCandidateProfile();
  }
}

export async function updateCandidateProfileAction(profile: CandidateProfile): Promise<boolean> {
  try {
    fs.writeFileSync(PROFILE_FILE_PATH, JSON.stringify(profile, null, 2), 'utf-8');
    return true;
  } catch (error) {
    console.error('Failed to save profile:', error);
    return false;
  }
}
