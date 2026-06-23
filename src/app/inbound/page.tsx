import { getApplicationsAction, getDatabaseSchemaOptionsAction } from '../../actions/recruiterActions';
import InboundClient from './InboundClient';

// Ensure data is fetched fresh
export const revalidate = 0;

export default async function InboundPage() {
  const [initialApplications, schemaOptions] = await Promise.all([
    getApplicationsAction().catch((error) => {
      console.error('[JCC] Failed to load inbound applications:', error);
      return [];
    }),
    getDatabaseSchemaOptionsAction().catch((error) => {
      console.error('[JCC] Failed to load inbound schema options:', error);
      return undefined;
    }),
  ]);

  return (
    <div className="w-full relative">
      <InboundClient initialApplications={initialApplications} dbOptions={schemaOptions} />
    </div>
  );
}
