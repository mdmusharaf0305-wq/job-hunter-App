import { getCompanyDirectoryAction } from '../../actions/companyDirectoryActions';
import { getDatabaseSchemaOptionsAction } from '../../actions/recruiterActions';
import CompanyDirectoryClient from './CompanyDirectoryClient';

export const revalidate = 0;

export default async function CompanyDirectoryPage() {
  const [initialCompanies, dbOptions] = await Promise.all([
    getCompanyDirectoryAction(),
    getDatabaseSchemaOptionsAction().catch(() => null),
  ]);

  return (
    <div className="w-full relative">
      <CompanyDirectoryClient initialCompanies={initialCompanies} dbOptions={dbOptions} />
    </div>
  );
}
