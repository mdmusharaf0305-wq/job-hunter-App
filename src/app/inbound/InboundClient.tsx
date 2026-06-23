'use client';

import { useState, useMemo, useRef } from 'react';
import { 
  MoveRight, 
  MoveLeft, 
  ExternalLink,
  Plus,
  User,
  Phone,
  Mail,
  Link2,
  MessageCircle,
  MessageSquare,
  Edit,
  CheckCircle2,
  Trash2,
  Search
} from 'lucide-react';
import { useRouter } from 'next/navigation';
import { formatDateShort } from '../../lib/dateUtils';
import { JobApplication, ApplicationStage } from '../../types';
import { updateApplicationStageAction, createApplicationAction, updateApplicationAction } from '../../actions/recruiterActions';
import { NotionSchemaOptions } from '../../lib/notion/client';
import ApplicationModal from '../../components/ApplicationModal';
import NotificationPopup from '../../components/NotificationPopup';
import RefreshButton from '../../components/RefreshButton';
import CustomSelect from '../../components/CustomSelect';
import LuffyLoader from '../../components/LuffyLoader';
import { triggerPhone, triggerWhatsApp, triggerGmail, triggerSMS } from '../../lib/linkUtils';


type Props = {
  initialApplications: JobApplication[];
  dbOptions?: NotionSchemaOptions;
};

const INBOUND_COLUMNS = [
  { id: '🎯 Interview Pipeline', title: '🎯 Interview Pipeline', color: 'border-t-accent-blue', bg: 'bg-accent-blue/5' },
  { id: '☎️ Screening', title: '☎️ Screening', color: 'border-t-accent-amber', bg: 'bg-accent-amber/5' },
  { id: '⏸️ Paused', title: '⏸️ Paused', color: 'border-t-zinc-400', bg: 'bg-zinc-500/5' },
  { id: '💔 Better Luck Next Time', title: '💔 Better Luck Next Time', color: 'border-t-rose-500', bg: 'bg-rose-500/5' }
];

const mapNotionStatusToFormulaStatus = (status: string | undefined): string => {
  const s = status ? status.trim() : "";
  if (!s) return "⚪ Not Started";
  
  if (s === "📄 Applied" || s === "📨 Resume Shared" || s === "👻 No Response" || s === "sourcing") {
    return "📥 Sourcing";
  }
  if (s === "📞 HR Screening" || s === "🔍 Shortlisted" || s === "screening") {
    return "☎️ Screening";
  }
  if (
    s === "🤖 AI Round" ||
    s === "📝 Test Scheduled" ||
    s === "🧪 Test Attempted" ||
    s === "🗓️ Interview Scheduled" ||
    s === "🧠 Technical Round 1" ||
    s === "⚙️ Technical Round 2" ||
    s === "👨💼 Manager Round" ||
    s === "🏢 Client Round" ||
    s === "💬 Final HR" ||
    s === "interview"
  ) {
    return "🎯 Interview Pipeline";
  }
  if (s === "⏸️ On Hold" || s === "paused") {
    return "⏸️ Paused";
  }
  if (s === "🎉 Offer Received" || s === "offered") {
    return "💰 Offer Stage";
  }
  if (s === "❌ Rejected" || s === "🚶 Drop" || s === "🚫 Duplicated Profile" || s === "rejected") {
    return "💔 Better Luck Next Time";
  }
  if (s === "🚫 No Openings") {
    return "📭 Position Closed";
  }
  if (s === "⚠️ Interview Missed") {
    return "⏸️ Attention Needed";
  }
  return "❌ Closed";
};

const mapFormulaStageToNotionStatus = (formulaStage: string): string => {
  switch (formulaStage) {
    case '⚪ Not Started':
      return '⚪ Not Started';
    case '📥 Sourcing':
      return '📄 Applied';
    case '☎️ Screening':
      return '📞 HR Screening';
    case '🎯 Interview Pipeline':
      return '🗓️ Interview Scheduled';
    case '⏸️ Paused':
      return '⏸️ On Hold';
    case '💰 Offer Stage':
      return '🎉 Offer Received';
    case '💔 Better Luck Next Time':
      return '❌ Rejected';
    case '📭 Position Closed':
      return '🚫 No Openings';
    case '⏸️ Attention Needed':
      return '⚠️ Interview Missed';
    case '❌ Closed':
      return '❌ Closed';
    default:
      return formulaStage;
  }
};



// Tracker logic moved to All Applications

export default function InboundClient({ initialApplications, dbOptions }: Props) {
  const router = useRouter();
  // Filter only inbound applications
  const [prevInitialApplications, setPrevInitialApplications] = useState(initialApplications);
  const [applications, setApplications] = useState<JobApplication[]>(initialApplications);
  const [draggedId, setDraggedId] = useState<string | null>(null);
  const [updatingId, setUpdatingId] = useState<string | null>(null);
  const [expandedId, setExpandedId] = useState<string | null>(null);
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [editApp, setEditApp] = useState<JobApplication | null>(null);
  const [search, setSearch] = useState('');
  const [priorityFilter, setPriorityFilter] = useState<'All' | 'High' | 'Medium' | 'Low'>('All');
  const [sortBy, setSortBy] = useState<'modified-desc' | 'modified-asc' | 'none'>('modified-desc');

  if (initialApplications !== prevInitialApplications) {
    setPrevInitialApplications(initialApplications);
    setApplications(initialApplications);
  }
  
  const [notification, setNotification] = useState<{
    isOpen: boolean;
    type: 'success' | 'error';
    title: string;
    message?: string;
    updatedFields?: Record<string, unknown>;
  }>({ isOpen: false, type: 'success', title: '' });



  const originalNotesVal = useRef<string>('');

  // Group inbound applications by status
  const groupedInbound = useMemo(() => {
    let inboundApps = applications.filter(a => a.type === 'inbound');
    if (priorityFilter !== 'All') {
      inboundApps = inboundApps.filter(a => a.priority === priorityFilter);
    }
    if (search.trim()) {
      const q = search.toLowerCase();
      inboundApps = inboundApps.filter(a => 
        (a.company || '').toLowerCase().includes(q) ||
        (a.role || '').toLowerCase().includes(q) ||
        (a.recruiterName || '').toLowerCase().includes(q)
      );
    }
    if (sortBy === 'modified-desc') {
      inboundApps.sort((a, b) => new Date(b.lastUpdated || 0).getTime() - new Date(a.lastUpdated || 0).getTime());
    } else if (sortBy === 'modified-asc') {
      inboundApps.sort((a, b) => new Date(a.lastUpdated || 0).getTime() - new Date(b.lastUpdated || 0).getTime());
    }
    return INBOUND_COLUMNS.reduce((acc, col) => {
      acc[col.id] = inboundApps.filter(a => mapNotionStatusToFormulaStatus(a.status) === col.id);
      return acc;
    }, {} as Record<string, JobApplication[]>);
  }, [applications, priorityFilter, search, sortBy]);

  const handleStageChange = async (id: string, newStage: ApplicationStage) => {
    setUpdatingId(id);
    try {
      const updated = await updateApplicationStageAction(id, newStage);
      setApplications(prev => prev.map(a => a.id === id ? updated : a));
    } catch (e) {
      console.error('Failed to update stage:', e);
    } finally {
      setUpdatingId(null);
    }
  };

  const handleSave = async (data: Partial<JobApplication>) => {
    if (editApp) {
      setUpdatingId(editApp.id);
      try {
        const updated = await updateApplicationAction(editApp.id, data);
        
        const updatedFields: Record<string, unknown> = {};
        Object.keys(data).forEach(k => {
          const key = k as keyof JobApplication;
          if (data[key] !== undefined && data[key] !== editApp[key]) {
            updatedFields[key] = data[key];
          }
        });

        setApplications(prev => prev.map(a => a.id === editApp.id ? updated : a));
        setNotification({
          isOpen: true,
          type: 'success',
          title: 'Application Updated',
          message: `${updated.role} at ${updated.company}`,
          updatedFields
        });
        router.refresh();
      } catch (e) {
        const err = e as { message?: string };
        console.error('Failed to update application:', e);
        setNotification({
          isOpen: true,
          type: 'error',
          title: 'Update Failed',
          message: err.message || 'Failed to update application details.'
        });
      } finally {
        setUpdatingId(null);
        setEditApp(null);
      }
    } else {
      setUpdatingId('new-app');
      try {
        const created = await createApplicationAction({
          ...data,
          type: 'inbound'
        });

        setApplications(prev => [created, ...prev]);
        setNotification({
          isOpen: true,
          type: 'success',
          title: 'Application Created',
          message: `${created.role} at ${created.company}`
        });
        router.refresh();
      } catch (error) {
        const err = error as { message?: string };
        console.error(err);
        setNotification({
          isOpen: true,
          type: 'error',
          title: 'Creation Failed',
          message: err.message || 'Failed to create application.'
        });
      } finally {
        setUpdatingId(null);
        setIsModalOpen(false);
      }
    }
  };



  const handleInlineUpdate = async (id: string, data: Partial<JobApplication>) => {
    setUpdatingId(id);
    try {
      const updated = await updateApplicationAction(id, data);
      setApplications(prev => prev.map(a => a.id === id ? updated : a));
    } catch (e) {
      console.error('Failed to update inline:', e);
      alert('Failed to save changes.');
    } finally {
      setUpdatingId(null);
    }
  };

  const handleLocalNotesChange = (id: string, notes: string) => {
    setApplications(prev => prev.map(a => a.id === id ? { ...a, notes } : a));
  };

  const handleDragStart = (e: React.DragEvent, id: string) => {
    setDraggedId(id);
    e.dataTransfer.setData('text/plain', id);
    e.dataTransfer.effectAllowed = 'move';
  };

  const handleDragOver = (e: React.DragEvent) => {
    e.preventDefault();
  };

  const handleDrop = async (e: React.DragEvent, columnId: string) => {
    e.preventDefault();
    const id = e.dataTransfer.getData('text/plain') || draggedId;
    if (!id) return;
    
    const item = applications.find(a => a.id === id);
    if (item && mapNotionStatusToFormulaStatus(item.status) === columnId) return;

    setDraggedId(null);
    await handleStageChange(id, mapFormulaStageToNotionStatus(columnId));
  };

  const moveLeft = (item: JobApplication) => {
    const currentFormulaStage = mapNotionStatusToFormulaStatus(item.status);
    const currentIndex = INBOUND_COLUMNS.findIndex(col => col.id === currentFormulaStage);
    if (currentIndex > 0) {
      handleStageChange(item.id, mapFormulaStageToNotionStatus(INBOUND_COLUMNS[currentIndex - 1].id));
    }
  };

  const moveRight = (item: JobApplication) => {
    const currentFormulaStage = mapNotionStatusToFormulaStatus(item.status);
    const currentIndex = INBOUND_COLUMNS.findIndex(col => col.id === currentFormulaStage);
    if (currentIndex < INBOUND_COLUMNS.length - 1) {
      handleStageChange(item.id, mapFormulaStageToNotionStatus(INBOUND_COLUMNS[currentIndex + 1].id));
    }
  };



  return (
    <div className="space-y-6">
      <NotificationPopup 
        {...notification} 
        onClose={() => setNotification(prev => ({ ...prev, isOpen: false }))} 
        autoCloseMs={1000}
        position="top"
      />
      {/* Page Header */}
      <div className="border-b border-card-border pb-5 flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h2 className="text-2xl font-bold tracking-tight text-foreground font-mono flex items-center gap-2">
            Inbound Applications
          </h2>
          <p className="text-sm text-muted-foreground mt-1">
            Browse opportunities where recruiters or clients reached out directly to you, grouped by status.
          </p>
        </div>
        
        {/* Actions */}
        <div className="flex gap-2">
          <RefreshButton />
          <button
            onClick={() => setIsModalOpen(true)}
            className="px-4 py-2 bg-gradient-to-r from-blue-900 via-blue-600 to-sky-400 hover:opacity-90 rounded-xl text-xs font-mono font-bold text-white transition-all flex items-center gap-2 cursor-pointer shadow-md hover:scale-[1.02]"
          >
            <Plus size={14} />
            Add Inbound Job
          </button>
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
        
        {/* Priority Filter */}
        <div className="flex items-center gap-1.5 py-0.5 shrink-0 bg-card/30 px-3.5 py-2 rounded-xl border border-card-border/60">
          <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Priority:</span>
          <CustomSelect
            value={priorityFilter}
            onChange={(val) => setPriorityFilter(val as 'All' | 'High' | 'Medium' | 'Low')}
            options={[
              { value: 'High', label: '🔴 High' },
              { value: 'Medium', label: '🟡 Medium' },
              { value: 'Low', label: '🔵 Low' },
              { value: 'All', label: 'All Priorities' }
            ]}
            label="Priority Filter"
            className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1.5 text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center"
          />
        </div>

        {/* Sort Filter */}
        <div className="flex items-center gap-1.5 py-0.5 shrink-0 bg-card/30 px-3.5 py-2 rounded-xl border border-card-border/60">
          <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Sort:</span>
          <CustomSelect
            value={sortBy}
            onChange={(val) => setSortBy(val as 'modified-desc' | 'modified-asc' | 'none')}
            options={[
              { value: 'modified-desc', label: '📅 Last Modified (Newest)' },
              { value: 'modified-asc', label: '📅 Last Modified (Oldest)' },
              { value: 'none', label: 'Default Order' }
            ]}
            label="Sort By"
            className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1.5 text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center"
          />
        </div>
      </div>

      {/* Kanban Board Container */}
      <div className="flex flex-col md:flex-row md:overflow-x-auto pb-6 gap-4 items-start custom-scrollbar w-full">
          {INBOUND_COLUMNS.map((col) => {
            const items = groupedInbound[col.id] || [];
            return (
              <div
                key={col.id}
                onDragOver={handleDragOver}
                onDrop={(e) => handleDrop(e, col.id)}
                className={`w-full md:snap-none md:min-w-[280px] md:w-[280px] shrink-0 flex flex-col rounded-2xl border border-card-border p-3 min-h-[150px] md:min-h-[70vh] transition-all duration-200 ${col.bg} hover:bg-card/25`}
              >
                {/* Column Header */}
                <div className={`border-t-2 ${col.color} pt-3 pb-3.5 mb-3 flex items-center justify-between`}>
                  <div className="flex items-center gap-2">
                    <h3 className="text-xs font-bold text-foreground font-mono uppercase tracking-wider truncate max-w-[190px]" title={col.title}>
                      {col.title}
                    </h3>
                    <span className="px-2 py-0.25 rounded-full text-xs font-mono font-bold border bg-card border-card-border text-muted-foreground">
                      {items.length}
                    </span>
                  </div>
                </div>

                {/* Cards List */}
                <div className="flex-1 space-y-3">
                  {items.length === 0 ? (
                    <div className="border border-dashed border-card-border rounded-xl py-10 text-center text-xs font-mono text-muted-foreground select-none">
                      Drop items here
                    </div>
                  ) : (
                    items.map((item) => (
                      <div
                        key={item.id}
                        draggable
                        onDragStart={(e) => handleDragStart(e, item.id)}
                        onClick={(e) => {
                          const target = e.target as HTMLElement;
                          if (target.closest('a') || target.closest('button') || target.closest('input') || target.closest('textarea') || target.closest('select')) return;
                          setExpandedId(expandedId === item.id ? null : item.id);
                        }}
                        className={`glass-card-interactive p-3.5 rounded-xl cursor-pointer active:cursor-grabbing border border-card-border relative group transition-all duration-300 ease-in-out ${
                          item.priority === 'High' 
                            ? 'hover:border-rose-500/35 hover:shadow-rose-500/[0.04]' 
                            : item.priority === 'Low'
                            ? 'hover:border-accent-blue/35 hover:shadow-accent-blue/[0.04]'
                            : 'hover:border-accent-amber/35 hover:shadow-accent-amber/[0.04]'
                        } ${
                          updatingId === item.id ? 'opacity-40 pointer-events-none' : ''
                        }`}
                      >
                        {/* Loading Spinner Overlays */}
                        {updatingId === item.id && (
                          <div className="absolute inset-0 flex items-center justify-center bg-black/10 rounded-xl">
                            <LuffyLoader size={14} />
                          </div>
                        )}

                        {/* Default View: Company, Role */}
                        <div className="space-y-2">
                          <h4 className="text-xs font-bold text-foreground leading-snug group-hover:text-accent-blue transition-colors">
                            {item.role}
                          </h4>
                          <p className="text-xs text-muted-foreground font-semibold">
                            <span className="text-foreground/90 font-bold">{item.company}</span>
                            {item.client && item.client !== 'Direct' && (
                              <span className="text-slate-400 font-semibold"> ➔ {item.client}</span>
                            )}
                          </p>
                          <div className="flex items-center justify-between gap-2 text-[10px] text-muted-foreground font-semibold flex-wrap">
                            {item.recruiterName ? (
                              <div>Recruiter: <span className="text-foreground/95 font-bold">{item.recruiterName}</span></div>
                            ) : (
                              <div>Recruiter: <span className="text-foreground/40 italic">N/A</span></div>
                            )}
                            <div className="flex items-center gap-1">
                              <span>Priority:</span>
                              <CustomSelect
                                value={item.priority || 'Medium'}
                                onChange={async (val) => {
                                  await handleInlineUpdate(item.id, { priority: val as 'High' | 'Medium' | 'Low' });
                                }}
                                disabled={updatingId === item.id}
                                options={[
                                  { value: 'High', label: '🔴 High' },
                                  { value: 'Medium', label: '🟡 Medium' },
                                  { value: 'Low', label: '🔵 Low' },
                                ]}
                                label="Priority"
                                className="bg-foreground/5 dark:bg-white/5 border border-card-border/40 text-foreground font-mono font-bold text-[9px] px-1 py-0.5 rounded focus:outline-none focus:ring-1 focus:ring-accent-blue/50 cursor-pointer w-auto"
                              />
                            </div>
                          </div>

                          <div className="grid grid-cols-2 gap-2 text-[10px] text-muted-foreground font-semibold mt-2.5 pt-1.5 border-t border-card-border/30">
                            <div className="flex flex-col gap-1">
                              <span className="text-[9px] uppercase tracking-wider font-bold">Status:</span>
                              <CustomSelect
                                value={item.status || ''}
                                onChange={async (val) => {
                                  await handleInlineUpdate(item.id, { status: val });
                                }}
                                disabled={updatingId === item.id}
                                options={dbOptions?.statuses || []}
                                label="Status"
                                className="w-full bg-foreground/5 dark:bg-white/5 border border-card-border/40 text-foreground font-mono font-bold text-[9px] px-2.5 py-1.5 rounded-full focus:outline-none focus:ring-1 focus:ring-accent-blue/50 cursor-pointer text-center w-full"
                              />
                            </div>
                            <div className="flex flex-col gap-1">
                              <span className="text-[9px] uppercase tracking-wider font-bold">Follow-up:</span>
                              <CustomSelect
                                value={item.followupChannel || ''}
                                onChange={async (val) => {
                                  await handleInlineUpdate(item.id, { followupChannel: val });
                                }}
                                disabled={updatingId === item.id}
                                options={dbOptions?.followupChannels || []}
                                placeholder="-- Channel --"
                                label="Follow-up Channel"
                                className="w-full bg-foreground/5 dark:bg-white/5 border border-card-border/40 text-foreground font-mono font-bold text-[9px] px-2.5 py-1.5 rounded-full focus:outline-none focus:ring-1 focus:ring-accent-blue/50 cursor-pointer text-center w-full"
                              />
                            </div>
                          </div>

                          <div className="flex items-center justify-between gap-1 text-[10px] text-muted-foreground font-semibold pt-1">
                            <span>Last Contacted:</span>
                            <input
                              type="date"
                              value={item.lastContactedDate ? item.lastContactedDate.split('T')[0] : ''}
                              onChange={async (e) => {
                                const newDate = e.target.value;
                                if (!newDate) return;
                                  await handleInlineUpdate(item.id, { lastContactedDate: newDate });
                              }}
                              disabled={updatingId === item.id}
                              className="bg-foreground/5 dark:bg-white/5 border border-card-border/40 text-foreground font-mono font-bold text-[9px] px-2 py-1 rounded-full focus:outline-none focus:ring-1 focus:ring-accent-blue/50 cursor-pointer text-center"
                            />
                          </div>

                          {(item.recruiterPhone || item.recruiterEmail) && (
                            <div className="flex items-center gap-1 mt-1 pb-1">
                              {item.recruiterPhone && (
                                <>
                                  <button
                                    type="button"
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      triggerPhone(item.recruiterPhone);
                                    }}
                                    className="comm-btn-pill hover:bg-green-500/10 border border-card-border/50 hover:border-green-500/20 rounded bg-card/50 text-green-500 transition-colors"
                                    title="Call Recruiter"
                                  >
                                    <Phone size={10} />
                                    <span className="text-[9px] font-bold uppercase tracking-wider">Call</span>
                                  </button>
                                  <button
                                    type="button"
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      triggerWhatsApp(item.recruiterPhone, item.recruiterName);
                                    }}
                                    className="comm-btn-pill hover:bg-emerald-500/10 border border-card-border/50 hover:border-emerald-500/20 rounded bg-card/50 text-emerald-500 transition-colors"
                                    title="Message on WhatsApp"
                                  >
                                    <MessageCircle size={10} />
                                    <span className="text-[9px] font-bold uppercase tracking-wider">WhatsApp</span>
                                  </button>
                                  <button
                                    type="button"
                                    onClick={(e) => {
                                      e.stopPropagation();
                                      triggerSMS(item.recruiterPhone, item.recruiterName);
                                    }}
                                    className="comm-btn-pill hover:bg-sky-500/10 border border-card-border/50 hover:border-sky-500/20 rounded bg-card/50 text-sky-500 transition-colors"
                                    title="Google Messages SMS"
                                  >
                                    <MessageSquare size={10} />
                                    <span className="text-[9px] font-bold uppercase tracking-wider">SMS</span>
                                  </button>
                                </>
                              )}
                              {item.recruiterEmail && (
                                <button
                                  type="button"
                                  onClick={(e) => {
                                    e.stopPropagation();
                                    triggerGmail(item.recruiterEmail, item.recruiterName);
                                  }}
                                  className="comm-btn-pill hover:bg-accent-blue/10 border border-card-border/50 hover:border-accent-blue/20 rounded bg-card/50 text-accent-blue transition-colors"
                                  title="Email Recruiter"
                                >
                                  <Mail size={10} />
                                  <span className="text-[9px] font-bold uppercase tracking-wider">Mail</span>
                                </button>
                              )}
                            </div>
                          )}

                          <div className="mt-1.5 pt-1.5 border-t border-card-border/30">
                            <span className="text-[9px] font-mono text-slate-500 uppercase tracking-widest font-bold flex items-center gap-1.5 mb-1.5">
                              <span>📚</span> Notes
                            </span>
                            <textarea
                              value={item.notes || ''}
                              placeholder="Notes... (auto-saves on blur)"
                              onChange={(e) => handleLocalNotesChange(item.id, e.target.value)}
                              onFocus={(e) => {
                                originalNotesVal.current = e.target.value;
                              }}
                              onBlur={async (e) => {
                                if (e.target.value !== originalNotesVal.current) {
                                  await handleInlineUpdate(item.id, { notes: e.target.value });
                                }
                              }}
                              disabled={updatingId === item.id}
                              className="w-full bg-foreground/[0.03] dark:bg-white/[0.03] text-foreground/80 font-medium leading-normal p-1.5 rounded border border-card-border/40 text-[10px] focus:outline-none focus:border-accent-blue/40 focus:bg-card transition-all resize-none min-h-[36px]"
                            />
                          </div>
                        </div>

                        {/* Hover/Tap Expanded Details View */}
                        <div
                          className={`overflow-hidden card-details-transition space-y-3 border-t border-card-border/50 ${
                            expandedId === item.id 
                              ? 'max-h-[800px] opacity-100 mt-3 pt-3' 
                              : 'group-hover:max-h-[800px] group-hover:opacity-100 group-hover:mt-3 group-hover:pt-3 max-h-0 opacity-0'
                          }`}
                        >
                          {/* 13 Details Grid */}
                          {/* Main Details: Elite Badges Layout */}
                          <div className="flex flex-wrap gap-1.5 mt-2">
                            {item.company && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🏢</span> {item.company}
                              </span>
                            )}
                            {item.client && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🤝</span> {item.client}
                              </span>
                            )}
                            {item.role && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🎯</span> {item.role}
                              </span>
                            )}
                            {item.location && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">📍</span> {item.location}
                              </span>
                            )}
                            {item.workMode && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">💻</span> {item.workMode}
                              </span>
                            )}
                            {item.employmentType && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">⏱️</span> {item.employmentType}
                              </span>
                            )}
                            {item.companyType && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🏛️</span> {item.companyType}
                              </span>
                            )}
                            {item.interviewMode && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🎥</span> {item.interviewMode}
                              </span>
                            )}
                            {item.salary && (
                              <span className="bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 px-2 py-0.5 rounded-md text-[10px] font-bold border border-emerald-500/20 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">💰</span> {item.salary}
                              </span>
                            )}
                          </div>

                          {/* Activity / Follow-up List */}
                          <div className="space-y-2 border-t border-card-border/40 pt-3 mt-3">



                          </div>



                          {/* Recruiter Details Sub-section */}
                          {(item.recruiterName || item.recruiterPhone || item.recruiterEmail || item.recruiterLinkedin) && (
                            <div className="space-y-1 text-xs text-muted-foreground border-t border-card-border/30 pt-2 bg-foreground/[0.02] p-2 rounded-lg">
                              <span className="text-[7px] font-mono text-slate-500 uppercase tracking-wider block font-bold mb-1.5">Recruiter</span>
                              
                              {/* Recruiter Info List */}
                              <div className="space-y-1 mb-2">
                                {item.recruiterName && (
                                  <div className="flex items-center gap-1.5">
                                    <User size={8} className="shrink-0 text-slate-400" />
                                    <span className="truncate font-mono font-bold text-foreground/80">
                                      {item.recruiterName}
                                    </span>
                                  </div>
                                )}
                                {item.recruiterPhone && (
                                  <div className="flex items-center gap-1.5">
                                    <Phone size={8} className="shrink-0 text-slate-400" />
                                    <span className="truncate font-mono">{item.recruiterPhone}</span>
                                  </div>
                                )}
                                {item.recruiterEmail && (
                                  <div className="flex items-center gap-1.5">
                                    <Mail size={8} className="shrink-0 text-slate-400" />
                                    <a 
                                      href="#"
                                      onClick={(e) => {
                                        e.preventDefault();
                                        triggerGmail(item.recruiterEmail, item.recruiterName);
                                      }}
                                      className="truncate font-mono hover:text-accent-blue hover:underline"
                                    >
                                      {item.recruiterEmail}
                                    </a>
                                  </div>
                                )}
                                {item.recruiterLinkedin && (
                                  <div className="flex items-center gap-1.5">
                                    <Link2 size={8} className="shrink-0 text-slate-400" />
                                    <a href={item.recruiterLinkedin} target="_blank" rel="noreferrer" className="truncate font-mono hover:text-accent-blue hover:underline flex items-center gap-0.5">
                                      LinkedIn <ExternalLink size={6} />
                                    </a>
                                  </div>
                                )}
                              </div>


                            </div>
                          )}

                          {/* Round Details Sub-section */}
                          {(item.interviewRounds || item.roundPlan) && (
                            <div className="space-y-1 text-xs text-muted-foreground border-t border-card-border/30 pt-2 bg-foreground/[0.02] p-2 rounded-lg">
                              <span className="text-[7px] font-mono text-slate-500 uppercase tracking-wider block font-bold">Interview Plan</span>
                              {item.interviewRounds && (
                                <div className="flex items-center justify-between">
                                  <span className="font-mono text-slate-500">Total Rounds</span>
                                  <span className="font-bold text-foreground/80">{item.interviewRounds}</span>
                                </div>
                              )}
                              {item.roundPlan && (
                                <div className="flex flex-col gap-0.5 mt-1 text-xs font-mono">
                                  <span className="text-slate-500">Rounds:</span>
                                  <span className="font-bold text-foreground/80 leading-tight">
                                    {item.roundPlan.split(',').map(r => r.trim()).join(' → ')}
                                  </span>
                                </div>
                              )}
                            </div>
                          )}



                          {/* Footer details & Action links */}
                          <div className="flex justify-between items-center pt-2.5 border-t border-card-border/50 text-xs font-mono text-muted-foreground">
                            {item.receivedCallOn && (
                              <span className="flex items-center gap-1 text-green-500/80">
                                <Phone size={9} />
                                {formatDateShort(item.receivedCallOn)}
                              </span>
                            )}
                            
                            <div className="flex gap-1 opacity-100 md:opacity-0 md:group-hover:opacity-100 transition-opacity mt-2 md:mt-0">
                              <button
                                onClick={() => moveLeft(item)}
                                className="p-1.5 md:p-1 hover:bg-card border border-transparent hover:border-card-border rounded text-foreground cursor-pointer"
                                title="Move stage left"
                              >
                                <MoveLeft size={12} className="md:w-[10px] md:h-[10px]" />
                              </button>
                              
                              <button
                                onClick={() => setEditApp(item)}
                                className="p-1.5 md:p-1 hover:bg-card border border-transparent hover:border-card-border rounded text-accent-blue cursor-pointer font-bold"
                                title="Edit Application"
                              >
                                <Edit size={12} className="md:w-[10px] md:h-[10px]" />
                              </button>
                              
                              {item.applicationUrl && (
                                <a
                                  href={item.applicationUrl}
                                  target="_blank"
                                  rel="noreferrer"
                                  className="p-1.5 md:p-1 hover:bg-card border border-transparent hover:border-card-border rounded text-foreground cursor-pointer"
                                  title="Link"
                                >
                                  <ExternalLink size={12} className="md:w-[10px] md:h-[10px]" />
                                </a>
                              )}
                              
                              {/* Quick Resolution Actions */}
                              <button
                                onClick={() => handleStageChange(item.id, '🎉 Offer Received')}
                                className="p-1.5 md:p-1 hover:bg-emerald-500/10 border border-transparent hover:border-emerald-500/20 rounded text-emerald-500 cursor-pointer font-bold"
                                title="Promote to Offer Won"
                              >
                                <CheckCircle2 size={12} className="md:w-[10px] md:h-[10px]" />
                              </button>
                              <button
                                onClick={() => handleStageChange(item.id, '❌ Rejected')}
                                className="p-1.5 md:p-1 hover:bg-accent-red/10 border border-transparent hover:border-accent-red/20 rounded text-accent-red cursor-pointer"
                                title="Mark as Rejected"
                              >
                                <Trash2 size={12} className="md:w-[10px] md:h-[10px]" />
                              </button>

                              <button
                                onClick={() => moveRight(item)}
                                className="p-1.5 md:p-1 hover:bg-card border border-transparent hover:border-card-border rounded text-foreground cursor-pointer"
                                title="Move stage right"
                              >
                                <MoveRight size={12} className="md:w-[10px] md:h-[10px]" />
                              </button>
                            </div>
                          </div>
                        </div>
                      </div>
                    ))
                  )}
                </div>
              </div>
            );
          })}
        </div>



      <ApplicationModal 
        isOpen={isModalOpen || !!editApp}
        onClose={() => {
          setIsModalOpen(false);
          setEditApp(null);
        }}
        onSave={handleSave}
        dbOptions={dbOptions}
        application={editApp}
        defaultType="inbound"
      />


    </div>
  );
}
