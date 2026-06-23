import { getApplicationsAction, getDatabaseSchemaOptionsAction } from '../../actions/recruiterActions';
import PipelineClient from './PipelineClient';

// Ensure data is fetched fresh
export const revalidate = 0;

export default async function PipelinePage() {
  const initialApplications = await getApplicationsAction();
  const dbOptions = await getDatabaseSchemaOptionsAction();

  return (
    <div className="w-full relative">
      <PipelineClient initialApplications={initialApplications} dbOptions={dbOptions} />
    </div>
  );
}
