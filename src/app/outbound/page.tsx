import { getApplicationsAction, getDatabaseSchemaOptionsAction } from '../../actions/recruiterActions';
import OutboundClient from './OutboundClient';

// Ensure data is fetched fresh
export const revalidate = 0;

export default async function OutboundPage() {
  const [initialApplications, schemaOptions] = await Promise.all([
    getApplicationsAction().catch((error) => {
      console.error('[JCC] Failed to load outbound applications:', error);
      return [];
    }),
    getDatabaseSchemaOptionsAction().catch((error) => {
      console.error('[JCC] Failed to load outbound schema options:', error);
      return undefined;
    }),
  ]);

  return (
    <div className="w-full relative">
      <OutboundClient initialApplications={initialApplications} dbOptions={schemaOptions} />
    </div>
  );
}
