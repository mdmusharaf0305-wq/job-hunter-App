'use client';

import { useState, useMemo, useRef, useEffect } from 'react';
import { useRouter } from 'next/navigation';
import { JobApplication, TimelineEvent } from '../../types';
import { mapRawStatusToBaseStage, type NotionSchemaOptions } from '../../lib/notion/client';
import { Calendar, PlusCircle, X, Briefcase, StickyNote, ChevronDown, ChevronUp, CheckCircle2, Search } from 'lucide-react';
import { createTimelineEventAction, updateTimelineEventAction } from '../../actions/timelineActions';
import RefreshButton from '../../components/RefreshButton';
import NotificationPopup from '../../components/NotificationPopup';
import LuffyLoader from '../../components/LuffyLoader';
import CustomSelect from '../../components/CustomSelect';

type Props = {
  initialEvents: TimelineEvent[];
  applications: JobApplication[];
  dbOptions: NotionSchemaOptions;
  etOptions: string[];
  categoryOptions: string[];
  virtualModeOptions: string[];
};

export default function TimelineClient({ initialEvents, applications, etOptions, categoryOptions, virtualModeOptions }: Props) {
  const router = useRouter();
  const [events, setEvents] = useState<TimelineEvent[]>(initialEvents);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [notification, setNotification] = useState<{ isOpen: boolean, type: 'success' | 'error', title: string, message: string }>({ isOpen: false, type: 'success', title: '', message: '' });


  // Form State
  const [opportunityId, setOpportunityId] = useState('');
  const [title, setTitle] = useState('');
  const [date, setDate] = useState(new Date().toISOString().split('T')[0]);
  const [category, setCategory] = useState('');
  const [virtualMode, setVirtualMode] = useState('');
  const [notes, setNotes] = useState('');
  const [sortOption, setSortOption] = useState<'recent' | 'company-asc' | 'company-desc' | 'modified-desc' | 'modified-asc'>('modified-desc');

  // Custom Combobox state for Opportunity
  const [searchOpp, setSearchOpp] = useState('');
  const [isOppDropdownOpen, setIsOppDropdownOpen] = useState(false);
  const filteredOpps = applications.filter(a => (a.company + ' ' + a.role).toLowerCase().includes(searchOpp.toLowerCase()));

  const [expandedOpps, setExpandedOpps] = useState<string[]>([]);
  const [statusFilter, setStatusFilter] = useState<string>('Active');

  const [search, setSearch] = useState('');
  const [updatingEventId, setUpdatingEventId] = useState<string | null>(null);
  const originalNotesVal = useRef<string>('');

  const handleEventUpdate = async (eventId: string, data: Partial<TimelineEvent>) => {
    setUpdatingEventId(eventId);
    try {
      const res = await updateTimelineEventAction(eventId, data);
      if (res.success) {
        setEvents(prev => prev.map(e => e.id === eventId ? { ...e, ...data } : e));
      } else {
        alert(res.error || 'Failed to update event details.');
      }
    } catch (err) {
      const errorVal = err as { message?: string };
      console.error(err);
      alert(errorVal.message || 'Error occurred while updating event.');
    } finally {
      setUpdatingEventId(null);
    }
  };

  const handleLocalEventNotesChange = (eventId: string, notes: string) => {
    setEvents(prev => prev.map(e => e.id === eventId ? { ...e, notes } : e));
  };

  const toggleOpp = (id: string) => {
    setExpandedOpps(p => p.includes(id) ? p.filter(x => x !== id) : [...p, id]);
  };

  const today = new Date().toISOString().split('T')[0];
  const pastEvents = useMemo(() => events.filter(e => {
    return e.date <= today;
  }), [events, today]);

  const groupedByOpp = useMemo(() => pastEvents.reduce((acc, event) => {
    if (!event.opportunity) return acc;
    if (!acc[event.opportunity]) acc[event.opportunity] = [];
    acc[event.opportunity].push(event);
    return acc;
  }, {} as Record<string, TimelineEvent[]>), [pastEvents]);

  const opportunitiesWithEvents = useMemo(() => Object.entries(groupedByOpp)
    .map(([oppId, evts]) => {
      const opp = applications.find(a => a.id === oppId);
      evts.sort((a, b) => new Date(b.date).getTime() - new Date(a.date).getTime());

      let appState = 'Active';
      const oppStatus = opp?.status?.toLowerCase() || '';
      if (oppStatus.includes('reject')) appState = 'Rejected';
      else if (oppStatus.includes('drop')) appState = 'Dropped';
      else if (oppStatus.includes('hold')) appState = 'On Hold';

      const terminalEvent = evts.find(e => {
        const cat = e.category.toLowerCase();
        return cat.includes('reject') || cat.includes('drop') || cat.includes('hold');
      });

      if (terminalEvent) {
        const cat = terminalEvent.category.toLowerCase();
        if (cat.includes('reject')) appState = 'Rejected';
        else if (cat.includes('drop')) appState = 'Dropped';
        else if (cat.includes('hold')) appState = 'On Hold';
      }

      let displayState = appState;
      if (appState === 'Active') {
        const baseStage = mapRawStatusToBaseStage(opp?.status);
        const hasScreeningEvent = evts.length > 0 && (
          evts[0].category.toLowerCase().includes('screening') ||
          evts[0].title.toLowerCase().includes('screening')
        );
        
        if (baseStage === 'screening' || hasScreeningEvent) {
          displayState = 'Screening';
        } else {
          displayState = 'Ongoing';
        }
      }

      return { oppId, opp, events: evts, appState, displayState, terminalEvent };
    })
    .filter(g => {
      const q = search.toLowerCase().trim();
      const matchesSearch = !q ||
        (g.opp!.company || '').toLowerCase().includes(q) ||
        (g.opp!.role || '').toLowerCase().includes(q) ||
        (g.opp!.recruiterName || '').toLowerCase().includes(q);
      
      let matchesStatus = false;
      if (statusFilter === 'All') {
        matchesStatus = true;
      } else if (statusFilter === 'Active') {
        matchesStatus = g.appState === 'Active';
      } else if (statusFilter === 'Screening') {
        matchesStatus = g.displayState === 'Screening';
      } else if (statusFilter === 'Ongoing') {
        matchesStatus = g.displayState === 'Ongoing';
      } else {
        matchesStatus = g.appState === statusFilter;
      }

      return g.opp && matchesStatus && matchesSearch;
    })
    .sort((a, b) => {
      if (sortOption === 'company-asc') {
        return a.opp!.company.localeCompare(b.opp!.company);
      }
      if (sortOption === 'company-desc') {
        return b.opp!.company.localeCompare(a.opp!.company);
      }
      if (sortOption === 'modified-desc') {
        return new Date(b.opp!.lastUpdated || 0).getTime() - new Date(a.opp!.lastUpdated || 0).getTime();
      }
      if (sortOption === 'modified-asc') {
        return new Date(a.opp!.lastUpdated || 0).getTime() - new Date(b.opp!.lastUpdated || 0).getTime();
      }
      return new Date(b.events[0].date).getTime() - new Date(a.events[0].date).getTime();
    }), [groupedByOpp, applications, sortOption, statusFilter, search]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!title || !date) return;

    setIsSubmitting(true);
    try {
      const result = await createTimelineEventAction({
        opportunity: opportunityId,
        title,
        date,
        category,
        virtualMode,
        notes
      });

      if (!result.success) {
        setNotification({ isOpen: true, type: 'error', title: 'Error', message: result.error || 'Failed to save timeline event.' });
        setIsSubmitting(false);
        return;
      }

      const newEvent: TimelineEvent = {
        id: Math.random().toString(),
        title,
        date,
        category,
        virtualMode,
        notes,
        opportunity: opportunityId
      };

      setEvents(prev => [...prev, newEvent]);
      setNotification({ isOpen: true, type: 'success', title: 'Success', message: 'Application Saved Successfully!' });
      setIsModalOpen(false);
      setTitle(''); setCategory(''); setVirtualMode(''); setNotes(''); setOpportunityId(''); setSearchOpp('');
      router.refresh();
    } catch (err) {
      console.error(err);
      alert('Failed to save timeline event. Make sure the database ID is a DB not a page.');
    } finally {
      setIsSubmitting(false);
    }
  };

  const isEventFormDirty = () => {
    return (
      opportunityId !== '' ||
      title !== '' ||
      category !== '' ||
      virtualMode !== '' ||
      notes !== ''
    );
  };

  const handleEventModalClose = () => {
    if (isEventFormDirty()) {
      if (window.confirm('You have unsaved changes. Are you sure you want to discard them?')) {
        setIsModalOpen(false);
      }
    } else {
      setIsModalOpen(false);
    }
  };

  const handleEventModalCloseRef = useRef(handleEventModalClose);
  useEffect(() => {
    handleEventModalCloseRef.current = handleEventModalClose;
  });

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape' && isModalOpen) {
        handleEventModalCloseRef.current();
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, [isModalOpen]);

  return (
    <div className="p-6 max-w-5xl mx-auto space-y-6">
      <NotificationPopup
        isOpen={notification.isOpen}
        type={notification.type}
        title={notification.title}
        message={notification.message}
        onClose={() => setNotification(prev => ({ ...prev, isOpen: false }))}
      />
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-4 border-b border-card-border pb-5">
        <div>
          <h2 className="text-2xl font-bold tracking-tight text-foreground font-mono flex items-center gap-2">
            📜 Applications History
          </h2>
          <p className="text-muted-foreground text-sm font-mono mt-1">
            Track completed events and interview progress
          </p>
        </div>
        
        <div className="flex items-center gap-2">
          <span className="text-xs font-mono font-bold bg-card border border-card-border/60 text-muted-foreground px-3 py-1.5 rounded-xl flex items-center gap-1.5 shadow-sm">
            <span className="w-1.5 h-1.5 rounded-full bg-accent-blue animate-pulse"></span>
            {opportunitiesWithEvents.length} Found
          </span>
        </div>
      </div>

      {/* Search and Filters Bar */}
      <div className="flex flex-col sm:flex-row gap-3 items-stretch sm:items-center w-full">
        {/* Search Bar */}
        <div className="relative flex-1 min-w-0">
          <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 text-muted-foreground" size={16} />
          <input
            type="text"
            placeholder="Search company, role, recruiter..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 bg-card border border-card-border rounded-xl text-xs font-mono text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-accent-blue transition-colors"
          />
        </div>
        
        {/* Filters and buttons */}
        <div className="flex flex-wrap items-center gap-2">
          {/* Status Filter Dropdown */}
          <div className="flex items-center gap-1.5 py-0.5 bg-card/30 px-3.5 py-2 rounded-xl border border-card-border/60">
            <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Status:</span>
            <CustomSelect
              value={statusFilter}
              onChange={(val) => setStatusFilter(val)}
              options={['All', 'Active', 'Screening', 'Ongoing', 'Rejected', 'Dropped', 'On Hold']}
              label="Status Filter"
              className="bg-card border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1 text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center"
            />
          </div>

          {/* Sort Dropdown */}
          <div className="flex items-center gap-1.5 py-0.5 bg-card/30 px-3.5 py-2 rounded-xl border border-card-border/60">
            <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Sort:</span>
            <CustomSelect
              value={sortOption}
              onChange={(val) => setSortOption(val as 'recent' | 'company-asc' | 'company-desc' | 'modified-desc' | 'modified-asc')}
              options={[
                { value: 'modified-desc', label: 'Last Modified (Newest)' },
                { value: 'modified-asc', label: 'Last Modified (Oldest)' },
                { value: 'recent', label: 'Recent Event' },
                { value: 'company-asc', label: 'Company A-Z' },
                { value: 'company-desc', label: 'Company Z-A' },
              ]}
              label="Sort Options"
              className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1 text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center"
            />
          </div>

          <RefreshButton position="center" />

          <button
            onClick={() => setIsModalOpen(true)}
            className="flex items-center justify-center gap-1.5 bg-accent-blue text-white px-3.5 py-2.5 rounded-xl hover:bg-accent-blue/90 transition-colors shadow-sm text-xs font-bold font-mono whitespace-nowrap cursor-pointer"
          >
            <PlusCircle size={14} />
            Add Event
          </button>
        </div>
      </div>

      <div className="space-y-4">
        {opportunitiesWithEvents.length === 0 ? (
          <div className="text-center p-12 text-muted-foreground font-mono border border-dashed border-card-border rounded-xl">
            No previous events found.
          </div>
        ) : (
          opportunitiesWithEvents.map((group) => {
            const isExpanded = expandedOpps.includes(group.oppId);
            return (
              <div key={group.oppId} className="glass-panel rounded-2xl overflow-hidden border border-card-border shadow-sm">
                <div
                  onClick={() => toggleOpp(group.oppId)}
                  className="p-4 flex items-center justify-between cursor-pointer hover:bg-card/50 transition-colors"
                >
                  <div className="flex items-center gap-3">
                    <div className="w-10 h-10 rounded-xl bg-accent-blue/10 text-accent-blue flex items-center justify-center">
                      <Briefcase size={18} />
                    </div>
                    <div>
                      <div className="flex items-center gap-2 flex-wrap">
                        <h3 className="font-bold text-foreground text-base leading-snug">{group.opp!.company}</h3>
                        <span className={`px-2 py-0.5 rounded-full text-[9px] font-bold uppercase tracking-wider leading-none shadow-sm text-white ${
                          group.displayState === 'Screening' ? 'bg-amber-500 dark:bg-amber-600' :
                          group.displayState === 'Ongoing' ? 'bg-indigo-600' :
                          group.displayState === 'Rejected' ? 'bg-red-500 dark:bg-red-600' :
                          group.displayState === 'Dropped' ? 'bg-fuchsia-600' :
                          'bg-amber-600' // On Hold
                        }`}>
                          {group.displayState}
                        </span>
                      </div>
                      <p className="text-xs text-muted-foreground font-mono">{group.opp!.role} &bull; {group.events.length} Events</p>
                    </div>
                  </div>
                  <div className="text-muted-foreground">
                    {isExpanded ? <ChevronUp size={20} /> : <ChevronDown size={20} />}
                  </div>
                </div>

                {isExpanded && (() => {
                  const roundPlanStr = group.opp?.roundPlan || '';
                  const plannedRounds = roundPlanStr ? roundPlanStr.split(',').map(s => s.trim()).filter(s => s) : [];

                  const sortedEvents = [...group.events].sort((a, b) => new Date(a.date).getTime() - new Date(b.date).getTime());
                  const appState = group.appState;
                  const terminalEvent = group.terminalEvent;


                  type TimelineNode =
                    | { type: 'event', event: TimelineEvent, isTerminal: boolean }
                    | { type: 'pending', title: string };

                  const unifiedNodes: TimelineNode[] = [];

                  sortedEvents.forEach(e => {
                    const isTerm = e.id === terminalEvent?.id;
                    unifiedNodes.push({ type: 'event', event: e, isTerminal: isTerm });
                  });

                  if (!terminalEvent) {
                    const matchedRoundTitles = sortedEvents.map(e => e.title.trim().toLowerCase());
                    const pendingRounds = plannedRounds.filter(pr => !matchedRoundTitles.includes(pr.trim().toLowerCase()));

                    pendingRounds.forEach(pr => {
                      unifiedNodes.push({ type: 'pending', title: pr });
                    });
                  }

                  let activeBg = 'bg-accent-blue';
                  let activeBorder = 'border-accent-blue';

                  if (appState === 'Rejected') {
                    activeBg = 'bg-red-500';
                    activeBorder = 'border-red-500';
                  } else if (appState === 'Dropped') {
                    activeBg = 'bg-fuchsia-500';
                    activeBorder = 'border-fuchsia-500';
                  } else if (appState === 'On Hold') {
                    activeBg = 'bg-amber-500';
                    activeBorder = 'border-amber-500';
                  }

                  return (
                    <div className="border-t border-card-border bg-card/30 p-4">
                      <div className="p-5 bg-background border border-card-border rounded-xl shadow-sm">
                        <div className="flex justify-between items-center mb-6">
                          <h4 className="text-xs font-bold text-muted-foreground uppercase tracking-wider font-mono flex items-center gap-2">
                            <span className={`px-2 py-0.5 rounded text-[10px] font-bold uppercase text-white ${
                              group.displayState === 'Screening' ? 'bg-amber-500 dark:bg-amber-600' :
                              group.displayState === 'Ongoing' ? 'bg-indigo-600' :
                              group.displayState === 'Rejected' ? 'bg-red-500 dark:bg-red-600' :
                              group.displayState === 'Dropped' ? 'bg-fuchsia-600' :
                              'bg-amber-600' // On Hold
                            }`}>
                              {group.displayState}
                            </span>
                          </h4>
                          {group.opp?.interviewRounds && (
                            <span className="text-[10px] font-mono bg-accent-blue/10 text-accent-blue border border-accent-blue/20 px-2.5 py-1 rounded-full font-bold uppercase tracking-wider">
                              Total Rounds: {group.opp.interviewRounds}
                            </span>
                          )}
                        </div>

                        <div className="flex w-full relative overflow-x-auto pb-4 pt-2" style={{ scrollbarWidth: 'thin' }}>
                          {unifiedNodes.length > 0 ? unifiedNodes.map((node, idx) => {
                            const isLast = idx === unifiedNodes.length - 1;
                            const isEvent = node.type === 'event';
                            const isTerm = isEvent && node.isTerminal;

                            let circleBg = isEvent ? 'bg-accent-blue' : 'bg-card';
                            let circleBorder = isEvent ? 'border-accent-blue' : 'border-card-border';
                            let circleIcon = isEvent ? <CheckCircle2 size={12} className="text-white relative z-10" /> : <span className="w-1.5 h-1.5 rounded-full bg-card-border relative z-10"></span>;
                            let lineColor = isEvent ? 'bg-accent-blue/50' : 'border-t-2 border-dashed border-card-border';

                            if (isTerm) {
                              circleBg = activeBg;
                              circleBorder = activeBorder;
                              circleIcon = <X size={12} className="text-white relative z-10" />;
                              lineColor = 'bg-card-border';
                            }

                            return (
                              <div key={idx} className={`flex-none w-[280px] flex flex-col relative pr-4 group ${!isEvent ? 'opacity-60' : ''}`}>
                                <div className="flex items-center mb-4 relative z-10 w-full">
                                  <div className={`relative w-8 h-8 shrink-0 rounded-full flex items-center justify-center border-2 ${circleBg} ${circleBorder} z-10 shadow-sm`}>
                                    {circleIcon}
                                  </div>
                                  {!isLast && (
                                    <div className={`flex-1 h-[2px] ml-1.5 ${lineColor} ${!isEvent ? 'bg-transparent' : ''}`}></div>
                                  )}
                                </div>

                                <div className="pr-4 flex-1">
                                  <h5 className={`font-bold text-sm mb-3 ${isEvent ? 'text-foreground' : 'text-muted-foreground'}`}>
                                    {isEvent ? node.event.title : node.title}
                                    {!isEvent && <span className="text-[10px] font-mono font-normal opacity-70 ml-2">(Pending)</span>}
                                    {isEvent && <span className="text-[10px] font-mono px-2 py-0.5 rounded-full bg-card border border-card-border text-muted-foreground ml-2">{node.event.category}</span>}
                                  </h5>

                                  {isEvent && (
                                    <div className={`bg-card border rounded-xl p-3 shadow-sm space-y-3 transition-colors ${isTerm ? `border-${activeBorder}` : 'border-card-border hover:border-accent-blue/40'} ${updatingEventId === node.event.id ? 'opacity-50 pointer-events-none' : ''}`}>
                                      <div className="flex items-center justify-between gap-1.5">
                                        <div className="flex items-center gap-1 text-[10px] font-mono text-muted-foreground bg-foreground/5 px-2 py-0.5 rounded-md">
                                          <Calendar size={10} />
                                          <input
                                            type="date"
                                            value={node.event.date ? node.event.date.split('T')[0] : ''}
                                            onChange={async (e) => {
                                              const newDate = e.target.value;
                                              if (!newDate) return;
                                              await handleEventUpdate(node.event.id, { date: newDate });
                                            }}
                                            disabled={updatingEventId === node.event.id}
                                            className="bg-transparent border-0 text-foreground font-mono font-bold text-[9px] p-0 focus:outline-none cursor-pointer text-center"
                                          />
                                        </div>
                                        {node.event.virtualMode && (
                                          <span className="text-[9px] font-mono font-bold uppercase tracking-wider px-2 py-0.5 rounded bg-emerald-500/10 text-emerald-500 border border-emerald-500/20">
                                            {node.event.virtualMode}
                                          </span>
                                        )}
                                      </div>
                                      
                                      <div className="text-[12px] text-muted-foreground flex flex-col gap-1.5 bg-foreground/5 p-2 rounded-lg border border-card-border/50">
                                        <div className="flex items-center gap-1 opacity-70">
                                          <StickyNote size={12} className="shrink-0" />
                                          <span className="text-[9px] font-mono font-bold uppercase tracking-wider">Notes</span>
                                        </div>
                                        <textarea
                                          value={node.event.notes || ''}
                                          placeholder="Add notes... (auto-saves on blur)"
                                          onChange={(e) => handleLocalEventNotesChange(node.event.id, e.target.value)}
                                          onFocus={(e) => {
                                            originalNotesVal.current = e.target.value;
                                          }}
                                          onBlur={async (e) => {
                                            if (e.target.value !== originalNotesVal.current) {
                                              await handleEventUpdate(node.event.id, { notes: e.target.value });
                                            }
                                          }}
                                          disabled={updatingEventId === node.event.id}
                                          rows={2}
                                          className="w-full bg-transparent border-0 text-xs font-sans text-foreground placeholder:text-muted-foreground/50 focus:outline-none resize-none font-medium custom-scrollbar"
                                        />
                                      </div>
                                    </div>
                                  )}

                                  {!isEvent && (
                                    <div className="bg-card/50 border border-dashed border-card-border rounded-xl p-3 flex items-center justify-center min-h-[72px]">
                                      <span className="text-xs font-mono text-muted-foreground">Awaiting Update</span>
                                    </div>
                                  )}
                                </div>
                              </div>
                            );
                          }) : (
                            <div className="w-full text-xs text-muted-foreground font-mono text-center py-6 border border-dashed border-card-border rounded-xl">No round plan defined and no events logged.</div>
                          )}
                        </div>
                      </div>
                    </div>
                  );
                })()}
              </div>
            );
          })
        )}
      </div>

      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-start justify-center p-4 pt-[60px] pb-10 overflow-y-auto">
          {/* Backdrop Scrim */}
          <div 
            className="fixed inset-0 bg-black/50 transition-opacity duration-300 cursor-pointer"
            onClick={handleEventModalClose}
          />
          {/* Modal Dialog Card */}
          <div className="relative bg-card w-full max-w-md rounded-3xl overflow-hidden shadow-[0_40px_80px_-20px_rgba(0,0,0,0.3)] dark:shadow-[0_40px_80px_-20px_rgba(0,0,0,0.7)] border border-slate-200/60 dark:border-white/10 flex flex-col max-h-[calc(100vh-100px)] animate-slide-down z-10">
            <div className="p-5 border-b border-card-border flex items-center justify-between bg-card">
              <h3 className="text-sm font-bold text-foreground font-mono uppercase tracking-wide">
                Add Event
              </h3>
              <button onClick={handleEventModalClose} className="text-muted-foreground hover:text-foreground border-0 bg-transparent cursor-pointer">
                <X size={16} />
              </button>
            </div>

            <form onSubmit={handleSubmit} className="p-5 space-y-4 overflow-y-auto flex-1 text-xs">
              <div className="space-y-1 relative">
                <label className="font-mono text-[10px] font-bold uppercase text-muted-foreground">Opportunity</label>
                <input
                  type="text"
                  value={searchOpp}
                  onChange={e => {
                    setSearchOpp(e.target.value);
                    setOpportunityId('');
                    setIsOppDropdownOpen(true);
                  }}
                  onFocus={() => setIsOppDropdownOpen(true)}
                  placeholder="Search company or role..."
                  className="w-full px-3 py-2 bg-background border border-card-border rounded-xl focus:border-accent-blue"
                />
                {isOppDropdownOpen && (
                  <div className="absolute top-full left-0 right-0 mt-1 bg-card border border-card-border rounded-xl shadow-xl max-h-48 overflow-y-auto z-50">
                    {filteredOpps.map(app => (
                      <div
                        key={app.id}
                        className="px-3 py-2 hover:bg-foreground/5 cursor-pointer text-[11px] border-b border-card-border/50 last:border-0"
                        onClick={() => {
                          setOpportunityId(app.id);
                          setSearchOpp(`${app.company} - ${app.role}`);
                          setIsOppDropdownOpen(false);
                        }}
                      >
                        <span className="font-bold">{app.company}</span> - <span className="text-muted-foreground">{app.role}</span>
                      </div>
                    ))}
                    {filteredOpps.length === 0 && (
                      <div className="px-3 py-2 text-muted-foreground text-[11px]">No matches</div>
                    )}
                  </div>
                )}
              </div>
              <div className="space-y-1">
                <label className="font-mono text-[10px] font-bold uppercase text-muted-foreground">ET *</label>
                <CustomSelect
                  required
                  value={title}
                  onChange={setTitle}
                  options={etOptions}
                  placeholder="Select ET..."
                  label="ET"
                  className="w-full px-3 py-2 bg-background border border-card-border rounded-xl focus:border-accent-blue"
                />
              </div>

              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1">
                  <label className="font-mono text-[10px] font-bold uppercase text-muted-foreground">Event Category *</label>
                  <CustomSelect
                    required
                    value={category}
                    onChange={(val) => {
                      setCategory(val);
                      if (!val.includes('Interview')) {
                        setVirtualMode('');
                        setTitle('');
                      }
                    }}
                    options={categoryOptions || []}
                    placeholder="Select..."
                    label="Category"
                    className="w-full px-3 py-2 bg-background border border-card-border rounded-xl focus:border-accent-blue"
                  />
                </div>
                <div className="space-y-1">
                  <label className="font-mono text-[10px] font-bold uppercase text-muted-foreground">Virtual Mode</label>
                  <CustomSelect
                    value={virtualMode}
                    onChange={setVirtualMode}
                    options={virtualModeOptions || []}
                    placeholder="Select..."
                    label="Virtual Mode"
                    className="w-full px-3 py-2 bg-background border border-card-border rounded-xl focus:border-accent-blue"
                  />
                </div>   </div>

              <div className="space-y-1">
                <label className="font-mono text-[10px] font-bold uppercase text-muted-foreground">Date *</label>
                <input required type="date" value={date} onChange={e => setDate(e.target.value)} className="w-full px-3 py-2 bg-background border border-card-border rounded-xl focus:border-accent-blue" />
              </div>

              <div className="space-y-1">
                <label className="font-mono text-[10px] font-bold uppercase text-muted-foreground">Notes</label>
                <textarea value={notes} onChange={e => setNotes(e.target.value)} placeholder="Any specific details..." className="w-full px-3 py-2 bg-background border border-card-border rounded-xl focus:border-accent-blue min-h-[80px]" />
              </div>
              
              <div className="p-3 border-t border-card-border flex justify-end gap-3 pt-5 bg-card -mx-5 -mb-5 mt-6 rounded-b-2xl">
                <button type="button" onClick={handleEventModalClose} className="px-4 py-2 border border-card-border hover:bg-card/50 bg-card rounded-lg font-semibold font-mono text-xs text-foreground transition-all cursor-pointer">
                  Cancel
                </button>
                <button type="submit" disabled={isSubmitting} className="px-4 py-2 bg-gradient-to-r from-blue-900 via-blue-600 to-sky-400 hover:opacity-90 disabled:opacity-50 text-white rounded-lg border-0 font-semibold font-mono text-xs transition-all flex items-center gap-1.5 cursor-pointer shadow-sm">
                  {isSubmitting ? <><LuffyLoader size={12} /> Saving...</> : 'Save'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
