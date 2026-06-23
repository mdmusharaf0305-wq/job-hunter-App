'use client';

import { useState, useMemo, useRef } from 'react';
import { 
  MoveRight, 
  MoveLeft, 
  ExternalLink,
  Trash2,
  CheckCircle,
  User,
  Phone,
  Mail,
  Link2,
  Edit,
  MessageCircle,
  MessageSquare,
  Search
} from 'lucide-react';
import { formatDateShort } from '../../lib/dateUtils';
import { JobApplication, ApplicationStage } from '../../types';
import { 
  updateApplicationStageAction, 
  updateApplicationAction 
} from '../../actions/recruiterActions';
import ApplicationModal from '../../components/ApplicationModal';
import CustomSelect from '../../components/CustomSelect';
import RefreshButton from '../../components/RefreshButton';
import { mapRawStatusToBaseStage, NotionSchemaOptions } from '../../lib/notion/client';
import NotificationPopup from '../../components/NotificationPopup';
import LuffyLoader from '../../components/LuffyLoader';
import { triggerPhone, triggerWhatsApp, triggerGmail, triggerSMS } from '../../lib/linkUtils';

type Props = {
  initialApplications: JobApplication[];
  dbOptions: NotionSchemaOptions;
};

const ACTIVE_PIPELINE_COLUMNS = [
  { id: 'interview', title: 'Interview Loop', color: 'border-t-accent-blue', bg: 'bg-accent-blue/5' },
  { id: 'screening', title: 'Screening', color: 'border-t-accent-amber', bg: 'bg-accent-amber/5' }
];



const mapPipelineColumnToNotionStatus = (columnId: string): string => {
  if (columnId === 'screening') return '📞 HR Screening';
  if (columnId === 'interview') return '🗓️ Interview Scheduled';
  return '📄 Applied';
};

export default function PipelineClient({ initialApplications, dbOptions }: Props) {
  const [prevInitialApplications, setPrevInitialApplications] = useState(initialApplications);
  const [applications, setApplications] = useState<JobApplication[]>(initialApplications);
  const [draggedId, setDraggedId] = useState<string | null>(null);
  const [updatingId, setUpdatingId] = useState<string | null>(null);
  const [expandedId, setExpandedId] = useState<string | null>(null);
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

  const activeApplications = useMemo(() => {
    let apps = applications.filter(a => {
      const baseStage = mapRawStatusToBaseStage(a.status);
      if (baseStage === 'screening') {
        return a.type === 'inbound';
      }
      if (baseStage === 'interview') {
        return a.type === 'inbound' || a.type === 'outbound';
      }
      return false;
    });
    if (priorityFilter !== 'All') {
      apps = apps.filter(a => a.priority === priorityFilter);
    }
    if (search.trim()) {
      const q = search.toLowerCase();
      apps = apps.filter(a => 
        (a.company || '').toLowerCase().includes(q) ||
        (a.role || '').toLowerCase().includes(q) ||
        (a.recruiterName || '').toLowerCase().includes(q)
      );
    }
    if (sortBy === 'modified-desc') {
      apps.sort((a, b) => new Date(b.lastUpdated || 0).getTime() - new Date(a.lastUpdated || 0).getTime());
    } else if (sortBy === 'modified-asc') {
      apps.sort((a, b) => new Date(a.lastUpdated || 0).getTime() - new Date(b.lastUpdated || 0).getTime());
    }
    return apps;
  }, [applications, priorityFilter, search, sortBy]);

  // Group active applications by status
  const groupedApplications = useMemo(() => {
    return ACTIVE_PIPELINE_COLUMNS.reduce((acc, col) => {
      acc[col.id] = activeApplications.filter(a => mapRawStatusToBaseStage(a.status) === col.id);
      return acc;
    }, {} as Record<string, JobApplication[]>);
  }, [activeApplications]);

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
    if (item && mapRawStatusToBaseStage(item.status) === columnId) return;

    setDraggedId(null);
    const targetStatus = mapPipelineColumnToNotionStatus(columnId);
    await handleStageChange(id, targetStatus as ApplicationStage);
  };

  const moveLeft = (item: JobApplication) => {
    const currentBaseStage = mapRawStatusToBaseStage(item.status);
    const currentIndex = ACTIVE_PIPELINE_COLUMNS.findIndex(col => col.id === currentBaseStage);
    if (currentIndex > 0) {
      const targetColId = ACTIVE_PIPELINE_COLUMNS[currentIndex - 1].id;
      const targetStatus = mapPipelineColumnToNotionStatus(targetColId);
      handleStageChange(item.id, targetStatus as ApplicationStage);
    }
  };

  const moveRight = (item: JobApplication) => {
    const baseStage = mapRawStatusToBaseStage(item.status);
    const currentIndex = ACTIVE_PIPELINE_COLUMNS.findIndex(c => c.id === baseStage);
    if (currentIndex < ACTIVE_PIPELINE_COLUMNS.length - 1) {
      const nextStage = ACTIVE_PIPELINE_COLUMNS[currentIndex + 1].id;
      // Map back to Notion actual status
      let notionStatus = item.status; // fallback
      if (nextStage === 'screening') notionStatus = '📞 HR Screening';
      if (nextStage === 'interview') notionStatus = '🗓️ Interview Scheduled';
      handleStageChange(item.id, notionStatus as ApplicationStage);
    }
  };

  const handleEditSave = async (data: Partial<JobApplication>) => {
    if (!editApp) return;
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

  return (
    <div className="space-y-6">
      {/* Page Header */}
      <div className="border-b border-card-border pb-5 flex flex-col md:flex-row justify-between items-start md:items-center gap-4">
        <div>
          <h2 className="text-2xl font-bold tracking-tight text-foreground font-mono">
            Active Job Pipeline
          </h2>
          <p className="text-sm text-muted-foreground mt-1">
            Track and advance jobs under active recruitment stages (Screening and Interview). Drag cards to move stages.
          </p>
        </div>
        
        {/* KPI of Active Items */}
        <div className="flex items-center gap-2">
          <span className="inline-flex items-center px-3 py-1 rounded-xl text-xs font-mono font-bold bg-accent-blue/10 text-accent-blue border border-accent-blue/20">
            Active Board Opportunities: {activeApplications.length}
          </span>
          <RefreshButton />
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
            className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1 text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center"
          />
        </div>

        {/* Sort Filter */}
        <div className="flex items-center gap-1.5 py-0.5 shrink-0 bg-card/30 px-3.5 py-2 rounded-xl border border-card-border/60">
          <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Sort:</span>
          <CustomSelect
            value={sortBy}
            onChange={(val) => setSortBy(val as 'modified-desc' | 'modified-asc' | 'none')}
            options={[
              { value: 'modified-desc', label: 'Newest First' },
              { value: 'modified-asc', label: 'Oldest First' },
              { value: 'none', label: 'None' }
            ]}
            label="Sort Options"
            className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1 text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center"
          />
        </div>
      </div>

      {/* Kanban Board Container */}
      <div className="flex flex-col md:flex-row md:overflow-x-auto md:pb-6 gap-6 items-start custom-scrollbar">
        {ACTIVE_PIPELINE_COLUMNS.map((col) => {
          const items = groupedApplications[col.id] || [];
          return (
            <div
              key={col.id}
              onDragOver={handleDragOver}
              onDrop={(e) => handleDrop(e, col.id)}
              className={`w-full md:min-w-[280px] md:w-[280px] shrink-0 flex flex-col rounded-2xl border border-card-border p-4 min-h-[70vh] transition-all duration-200 ${col.bg} hover:bg-card/25`}
            >
              {/* Column Header */}
              <div className={`border-t-2 ${col.color} pt-3.5 pb-4 mb-4 flex items-center justify-between`}>
                <div className="flex items-center gap-2">
                  <h3 className="text-xs font-bold text-foreground font-mono uppercase tracking-wider">
                    {col.title}
                  </h3>
                  <span className="px-2 py-0.5 rounded-full text-xs font-mono font-bold border bg-card border-card-border text-muted-foreground">
                    {items.length}
                  </span>
                </div>
              </div>

              {/* Cards List */}
              <div className="flex-1 space-y-3">
                {items.length === 0 ? (
                  <div className="border border-dashed border-card-border rounded-xl py-12 text-center text-xs font-mono text-muted-foreground select-none">
                    No active opportunities
                  </div>
                ) : (
                  items.map((item) => {
                    const itemBaseStage = mapRawStatusToBaseStage(item.status);
                    return (
                      <div
                        key={item.id}
                        draggable
                        onDragStart={(e) => handleDragStart(e, item.id)}
                        onClick={(e) => {
                          const target = e.target as HTMLElement;
                          if (target.closest('a') || target.closest('button') || target.closest('input') || target.closest('textarea') || target.closest('select')) return;
                          setExpandedId(expandedId === item.id ? null : item.id);
                        }}
                        className={`glass-card-interactive p-4 rounded-xl space-y-3 cursor-pointer active:cursor-grabbing border border-card-border relative group transition-all duration-300 ease-in-out ${
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
                            <LuffyLoader size={16} />
                          </div>
                        )}

                        {/* Card Default View Content */}
                        <div className="space-y-1 select-none">
                          <div className="flex items-start justify-between gap-1.5">
                            <h4 className="text-xs font-bold text-foreground leading-snug group-hover:text-accent-blue transition-colors">
                              {item.role}
                            </h4>
                            <span className={`inline-flex items-center px-1.5 py-0.25 rounded text-[10px] font-mono font-bold uppercase shrink-0 border ${
                              item.type === 'inbound' 
                                ? 'bg-emerald-500/10 text-emerald-400 border-emerald-500/20' 
                                : 'bg-purple-500/10 text-purple-400 border-purple-500/20'
                            }`}>
                              {item.type}
                            </span>
                          </div>
                          <p className="text-xs text-muted-foreground font-semibold">
                            Company: <span className="text-foreground/90 font-bold">{item.company}</span>
                            {item.client && item.client !== 'Direct' && (
                              <>
                                {' '}➔ <span className="text-slate-400 font-semibold">{item.client}</span>
                              </>
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
                          {/* Main Details: Elite Badges Layout */}
                          <div className="flex flex-wrap gap-1.5 mt-2">
                            {item.company && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🏢</span> {item.company}
                              </span>
                            )}
                            {item.client && item.client !== 'Direct' && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🤝</span> {item.client}
                              </span>
                            )}
                            {item.role && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">💻</span> {item.role}
                              </span>
                            )}
                            {item.location && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">📍</span> {item.location}
                              </span>
                            )}
                            {item.workMode && (
                              <span className="bg-accent-blue/10 text-accent-blue px-2 py-0.5 rounded-md text-[10px] font-bold border border-accent-blue/20 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🏠</span> {item.workMode}
                              </span>
                            )}
                            {item.salary && (
                              <span className="bg-emerald-500/10 text-emerald-500 px-2 py-0.5 rounded-md text-[10px] font-bold border border-emerald-500/20 flex items-center gap-1.5 shadow-sm font-mono tracking-tight">
                                <span className="text-[10px] opacity-70">💰</span> {item.salary}
                              </span>
                            )}
                            {item.interviewMode && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🎥</span> {item.interviewMode}
                              </span>
                            )}
                            {item.employmentType && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">⏱️</span> {item.employmentType}
                              </span>
                            )}
                            {item.companyType && (
                              <span className="bg-foreground/5 text-foreground/80 px-2 py-0.5 rounded-md text-[10px] font-medium border border-card-border/40 flex items-center gap-1.5 shadow-sm">
                                <span className="text-[10px] opacity-70">🏢</span> {item.companyType}
                              </span>
                            )}
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
                                      {item.recruiterName} {item.recruiterCompany ? `(${item.recruiterCompany})` : ''}
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

                          {/* Rounds and Prep Plan */}
                          {(item.interviewRounds || item.roundPlan) && (
                            <div className="space-y-1.5 bg-card/50 p-2 rounded-lg border border-card-border/50 text-xs text-muted-foreground font-semibold">
                              {item.interviewRounds && (
                                <div>
                                  <span className="font-bold text-foreground/80 block">Total Rounds / Feedback:</span>
                                  <span className="text-muted-foreground/90 font-medium">{item.interviewRounds}</span>
                                </div>
                              )}
                              {item.roundPlan && (
                                <div>
                                  <span className="font-bold text-foreground/80 block">Round Prep Plan:</span>
                                  <span className="text-muted-foreground/90 font-medium">{item.roundPlan}</span>
                                </div>
                              )}
                            </div>
                          )}
                        </div>

                        {/* Footer: Date & Quick Actions */}
                        <div className="flex justify-between items-center pt-2.5 border-t border-card-border text-xs font-mono text-muted-foreground">
                          {item.receivedCallOn && (
                            <span className="flex items-center gap-1 text-green-500/80 font-semibold select-none">
                              <Phone size={10} />
                              {formatDateShort(item.receivedCallOn)}
                            </span>
                          )}
                          
                          {/* Interactive Migration and Resolution Actions */}
                          <div className="flex gap-1 opacity-100 md:opacity-0 md:group-hover:opacity-100 transition-opacity mt-2 md:mt-0">
                            {itemBaseStage !== 'sourcing' && (
                              <button
                                onClick={() => moveLeft(item)}
                                className="p-1.5 md:p-1 hover:bg-card border border-transparent hover:border-card-border rounded text-foreground cursor-pointer"
                                title="Move stage left"
                              >
                                <MoveLeft size={12} className="md:w-[10px] md:h-[10px]" />
                              </button>
                            )}
                            
                            <button
                              onClick={() => setEditApp(item)}
                              className="p-1.5 md:p-1 hover:bg-card border border-transparent hover:border-card-border rounded text-accent-blue cursor-pointer font-bold"
                              title="Edit Application"
                            >
                              <Edit size={12} className="md:w-[10px] md:h-[10px]" />
                            </button>
                            
                            {/* Quick Resolution Actions */}
                            <button
                              onClick={() => handleStageChange(item.id, '🎉 Offer Received')}
                              className="p-1.5 md:p-1 hover:bg-emerald-500/10 border border-transparent hover:border-emerald-500/20 rounded text-emerald-500 cursor-pointer font-bold"
                              title="Promote to Offer Won"
                            >
                              <CheckCircle size={12} className="md:w-[10px] md:h-[10px]" />
                            </button>
                            <button
                              onClick={() => handleStageChange(item.id, '❌ Rejected')}
                              className="p-1.5 md:p-1 hover:bg-accent-red/10 border border-transparent hover:border-accent-red/20 rounded text-accent-red cursor-pointer"
                              title="Mark as Rejected"
                            >
                              <Trash2 size={12} className="md:w-[10px] md:h-[10px]" />
                            </button>

                            {itemBaseStage !== 'interview' && (
                              <button
                                onClick={() => moveRight(item)}
                                className="p-1.5 md:p-1 hover:bg-card border border-transparent hover:border-card-border rounded text-foreground cursor-pointer"
                                title="Move stage right"
                              >
                                <MoveRight size={12} className="md:w-[10px] md:h-[10px]" />
                              </button>
                            )}
                          </div>
                        </div>
                      </div>
                    );
                  })
                )}
              </div>
            </div>
          );
        })}
      </div>

      <ApplicationModal 
        isOpen={!!editApp}
        onClose={() => setEditApp(null)}
        onSave={handleEditSave}
        dbOptions={dbOptions}
        application={editApp}
      />



      <NotificationPopup
        isOpen={notification.isOpen}
        onClose={() => setNotification(prev => ({ ...prev, isOpen: false }))}
        type={notification.type}
        title={notification.title}
        message={notification.message}
        updatedFields={notification.updatedFields}
        position="top"
      />
    </div>
  );
}
