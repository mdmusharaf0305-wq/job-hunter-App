import { getTimelineEventsAction, getTimelineSchemaAction } from '../../actions/timelineActions';
import { getApplicationsAction } from '../../actions/recruiterActions';
import { getDatabaseSchemaOptions } from '../../lib/notion/client';
import TimelineClient from './TimelineClient';

export const revalidate = 0;

export default async function TimelinePage() {
  const [events, applications, dbOptions, timelineSchema] = await Promise.all([
    getTimelineEventsAction(),
    getApplicationsAction(),
    getDatabaseSchemaOptions(),
    getTimelineSchemaAction()
  ]);

  return (
    <div className="w-full relative">
      <TimelineClient initialEvents={events} applications={applications} dbOptions={dbOptions} etOptions={timelineSchema.etOptions} categoryOptions={timelineSchema.categoryOptions} virtualModeOptions={timelineSchema.virtualModeOptions} />
    </div>
  );
}
