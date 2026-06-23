import { getDashboardMetricsAction, getApplicationsAction } from '../../actions/recruiterActions';
import ChatClient from './ChatClient';

export const revalidate = 0;

export default async function ChatPage() {
  const [initialMetrics, initialApplications] = await Promise.all([
    getDashboardMetricsAction(),
    getApplicationsAction(),
  ]);

  return (
    <div className="w-full relative">
      <ChatClient initialMetrics={initialMetrics} initialApplications={initialApplications} />
    </div>
  );
}
