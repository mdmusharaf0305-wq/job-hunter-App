import { getRecruitersAction, getApplicationsAction, getDatabaseSchemaOptionsAction } from '../../actions/recruiterActions';
import RecruitersClient from './RecruitersClient';

// Ensure data is fetched fresh
export const revalidate = 0;

export default async function RecruitersPage() {
  const initialRecruiters = await getRecruitersAction();
  const applications = await getApplicationsAction();
  const dbOptions = await getDatabaseSchemaOptionsAction();

  return (
    <div className="w-full relative">
      <RecruitersClient 
        initialRecruiters={initialRecruiters} 
        applications={applications} 
        dbOptions={dbOptions}
      />
    </div>
  );
}
