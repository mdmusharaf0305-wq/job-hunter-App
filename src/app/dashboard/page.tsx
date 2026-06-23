import { getDashboardMetricsAction } from '../../actions/recruiterActions';
import DashboardClient from './DashboardClient';

// Ensure data is fetched fresh
export const revalidate = 0;

export default async function DashboardPage() {
  const initialMetrics = await getDashboardMetricsAction();

  return (
    <div className="w-full relative">
      <DashboardClient initialMetrics={initialMetrics} />
    </div>
  );
}
