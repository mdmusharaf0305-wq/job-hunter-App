import React, { useMemo } from 'react';
import { CheckCircle2, Circle } from 'lucide-react';
import { JobApplication } from '../types';

const InboundTracker = ({ app }: { app: JobApplication }) => {
  const journeySteps = useMemo(() => {
    const sLower = (app.status || '').toLowerCase();
    
    // Parse dynamic rounds from roundPlan
    const dynamicRounds = app.roundPlan 
      ? app.roundPlan.split(',').map(r => r.trim()).filter(r => r.length > 0)
      : [];
      
    // Base journey starts with Applied and ends with a placeholder for the final step
    const journey = ['Applied', ...dynamicRounds, 'Final Stage'];

    // Map current status to an active index
    let activeIdx = 0;
    const clean = sLower;
    let baseStage = 'sourcing';
    if (clean === 'hr screening' || clean === 'shortlisted' || clean === 'screening') baseStage = 'screening';
    else if (
      clean === 'ai round' ||
      clean === 'test scheduled' ||
      clean === 'test attempted' ||
      clean === 'interview scheduled' ||
      clean === 'technical round 1' ||
      clean === 'technical round 2' ||
      clean === 'manager round' ||
      clean === 'client round' ||
      clean === 'final hr' ||
      clean === 'interview pipeline' ||
      clean === 'interview loop' ||
      clean === 'interview missed' ||
      clean === 'attention needed'
    ) baseStage = 'interview';
    else if (clean === 'offer received' || clean === 'offer stage' || clean === 'offered') baseStage = 'offered';
    else if (clean === 'rejected') baseStage = 'rejected';

    let foundIdx = -1;
    for (let i = 0; i < dynamicRounds.length; i++) {
      const roundName = dynamicRounds[i].toLowerCase();
      // Only match if there's a strong correlation
      if (
        sLower === roundName ||
        (sLower.includes('tech') && roundName.includes('tech') && sLower.match(/\d/)?.toString() === roundName.match(/\d/)?.toString()) ||
        (sLower.includes('manager') && roundName.includes('manager')) ||
        (sLower.includes('client') && roundName.includes('client')) ||
        (sLower.includes('hr') && roundName.includes('hr') && !sLower.includes('screening'))
      ) {
        foundIdx = i + 1; // +1 because 'Applied' is at index 0
        break;
      }
    }

    const isRejected = baseStage === 'rejected' || sLower.includes('rejected') || sLower.includes('closed') || sLower.includes('better luck') || sLower.includes('drop');
    const isOffered = baseStage === 'offered' || sLower.includes('offer');

    if (foundIdx !== -1) {
      activeIdx = foundIdx;
    } else {
      if (baseStage === 'sourcing' || sLower.includes('not started') || sLower.includes('applied') || sLower.includes('resume shared')) {
        activeIdx = 0;
      } else if (isOffered) {
        activeIdx = journey.length - 1;
      } else if (isRejected) {
        activeIdx = 0; // if we don't know where they rejected, just show rejected at applied/current
      } else if (baseStage === 'screening') {
        // If they are in screening but screening is not in round plan, stay at 0 but show 'Screening' description
        activeIdx = 0;
      } else if (baseStage === 'interview') {
        // In interview but exact round not matched, let's put them at the first dynamic round or 0
        activeIdx = dynamicRounds.length > 0 ? 1 : 0;
      } else {
        activeIdx = 0;
      }
    }

    const subDays = (dateStr: string | undefined, days: number): string => {
      const d = dateStr ? new Date(dateStr) : new Date();
      d.setDate(d.getDate() - days);
      return d.toISOString().split('T')[0];
    };

    return journey.map((label, idx) => {
      const daysAgo = (activeIdx - idx) * 3; 
      let dateVal: string | null = null;
      if (idx <= activeIdx) {
         if (idx === 0) dateVal = app.receivedCallOn || subDays(app.lastUpdated, Math.max(0, activeIdx * 3));
         else if (idx === activeIdx) dateVal = app.lastUpdated;
         else dateVal = subDays(app.lastUpdated, daysAgo > 0 ? daysAgo : 0);
      }

      let stepStatus = 'pending';
      if (idx < activeIdx) stepStatus = 'completed';
      else if (idx === activeIdx) {
        if (isRejected) {
           stepStatus = 'rejected';
        } else if (isOffered && idx === journey.length - 1) {
           stepStatus = 'offered';
        } else {
           stepStatus = 'active';
        }
      }
      
      let finalLabel = label;
      if (idx === activeIdx && isRejected) {
         finalLabel = label === 'Final Stage' ? 'Closed 💔' : `${label} (Failed)`;
      } else if (idx === journey.length - 1) {
         if (isOffered) finalLabel = 'Offer Won 🎉';
         else if (isRejected) finalLabel = 'Closed 💔';
      }

      let desc = '';
      if (idx === 0 && baseStage === 'screening') desc = 'Shortlisted / Screening';
      else if (idx === 0) desc = 'Application Tracked';
      else if (idx === journey.length - 1 && isOffered) desc = 'Offer Accepted';
      else if (idx === activeIdx && isRejected) desc = app.status || 'Rejected here';
      else desc = stepStatus === 'completed' ? 'Cleared round' : (stepStatus === 'active' ? (app.status || 'Current stage') : 'Awaiting');

      return {
        label: finalLabel,
        date: dateVal,
        status: stepStatus,
        description: desc
      };
    });
  }, [app]);

  return (
    <div className="mt-3 bg-card/40 rounded-lg p-3 border border-card-border/50">
      <h4 className="text-xs font-bold uppercase tracking-wider text-muted-foreground font-mono mb-3">Application Journey</h4>
      <div className="relative pl-1">
        <div className="absolute left-[8px] top-2 bottom-2 w-0.5 bg-card-border" />
        <div className="space-y-4">
          {journeySteps.map((step, idx) => (
            <div key={idx} className="relative flex items-start gap-3">
              <div className="relative z-10 flex items-center justify-center bg-card mt-0.5">
                {step.status === 'completed' ? (
                  <CheckCircle2 size={12} className="text-emerald-500 fill-emerald-500/20" />
                ) : step.status === 'active' ? (
                  <div className="w-3 h-3 rounded-full border-2 border-accent-blue bg-card flex items-center justify-center">
                    <div className="w-1.5 h-1.5 bg-accent-blue rounded-full animate-pulse" />
                  </div>
                ) : step.status === 'offered' ? (
                  <CheckCircle2 size={12} className="text-emerald-500 fill-emerald-500/20" />
                ) : step.status === 'rejected' ? (
                  <Circle size={12} className="text-rose-500" />
                ) : (
                  <Circle size={12} className="text-slate-600" />
                )}
              </div>
              <div className="flex-1">
                <div className="flex items-center justify-between">
                  <span className={`text-xs font-bold ${
                    step.status === 'completed' ? 'text-foreground' : 
                    step.status === 'active' ? 'text-accent-blue' :
                    step.status === 'offered' ? 'text-emerald-500' :
                    step.status === 'rejected' ? 'text-rose-500' :
                    'text-muted-foreground'
                  }`}>
                    {step.label}
                  </span>
                  {step.date && (
                    <span className="text-xs font-mono text-muted-foreground">{step.date}</span>
                  )}
                </div>
                <div className="text-xs text-muted-foreground mt-0.5">{step.description}</div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default InboundTracker;
