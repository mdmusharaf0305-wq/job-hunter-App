'use client';

import { useState, useEffect } from 'react';
import { motion, Variants } from 'framer-motion';
import { 
  Briefcase, 
  Users, 
  Calendar, 
  Award, 
  Percent, 
  Sparkles, 
  Clock, 
  Phone, 
  Filter, 
  ChevronDown
} from 'lucide-react';
import { FcPhone, FcSms } from 'react-icons/fc';
import { SiWhatsapp, SiGmail } from 'react-icons/si';
import { DashboardMetrics } from '../../types';
import { updateApplicationAction, getDatabaseSchemaOptionsAction } from '../../actions/recruiterActions';
import { mapRawStatusToBaseStage, mapNotionStatusToFormulaStatus, NotionSchemaOptions } from '../../lib/notion/client';
import RefreshButton from '../../components/RefreshButton';
import CustomSelect from '../../components/CustomSelect';
import { triggerPhone, triggerWhatsApp, triggerGmail, triggerSMS } from '../../lib/linkUtils';

type Props = {
  initialMetrics: DashboardMetrics;
};

export default function DashboardClient({ initialMetrics }: Props) {
  const [prevInitialMetrics, setPrevInitialMetrics] = useState(initialMetrics);
  const [metrics, setMetrics] = useState<DashboardMetrics>(initialMetrics);
  const [schemaOptions, setSchemaOptions] = useState<NotionSchemaOptions | null>(null);

  if (initialMetrics !== prevInitialMetrics) {
    setPrevInitialMetrics(initialMetrics);
    setMetrics(initialMetrics);
  }

  useEffect(() => {
    const fetchOptions = async () => {
      try {
        const opts = await getDatabaseSchemaOptionsAction();
        setSchemaOptions(opts);
      } catch (err) {
        console.error("Failed to load schema options", err);
      }
    };
    fetchOptions();
  }, []);

  const [activeTab, setActiveTab] = useState<'all' | 'high' | 'medium'>('all');
  const [isMarking, setIsMarking] = useState(false);
  const [screeningSearch, setScreeningSearch] = useState('');
  const [isFiltersExpanded, setIsFiltersExpanded] = useState(false);

  // Filter for Screening Applications
  const screeningApps = metrics.allApplications?.filter(app => {
    const isStandardScreening = mapNotionStatusToFormulaStatus(app.status) === '☎️ Screening';
    
    const cStatus = (app.callStatus || '').toLowerCase();
    const aStatus = (app.status || '').toLowerCase();
    
    const isOutboundScreening = app.type === 'outbound' && 
                                (cStatus.includes('dialed') || cStatus.includes('dailed')) && 
                                (aStatus.includes('resume shared') || aStatus.includes('📨 resume shared'));
                                
    return isStandardScreening || isOutboundScreening;
  }) || [];

  const filteredScreeningApps = screeningApps.filter(app => {
    let matchesTab = true;
    if (activeTab === 'high') matchesTab = app.priority === 'High';
    if (activeTab === 'medium') matchesTab = app.priority === 'Medium';
    
    let matchesSearch = true;
    if (screeningSearch) {
      matchesSearch = app.company?.toLowerCase().includes(screeningSearch.toLowerCase()) || 
                      app.role?.toLowerCase().includes(screeningSearch.toLowerCase());
    }
    return matchesTab && matchesSearch;
  });

  const handleStatusChange = async (appId: string, newStatus: string) => {
    setIsMarking(true);
    try {
      await updateApplicationAction(appId, { status: newStatus });
      // Optimistically update local state
      setMetrics(prev => ({
        ...prev,
        allApplications: prev.allApplications.map(app => 
          app.id === appId ? { ...app, status: newStatus } : app
        )
      }));
    } catch (e) {
      console.error(e);
    } finally {
      setIsMarking(false);
    }
  };

  const container: Variants = {
    hidden: { opacity: 0 },
    show: {
      opacity: 1,
      transition: {
        staggerChildren: 0.1
      }
    }
  };

  const item: Variants = {
    hidden: { opacity: 0, y: 20 },
    show: { opacity: 1, y: 0, transition: { type: "spring", stiffness: 300, damping: 24 } }
  };
  const inboundApps = metrics.allApplications?.filter(a => a.type === 'inbound') || [];
  const outboundApps = metrics.allApplications?.filter(a => a.type === 'outbound') || [];
  
  const inStats = {
    sourcing: inboundApps.filter(a => mapRawStatusToBaseStage(a.status) === 'sourcing').length,
    screening: inboundApps.filter(a => mapRawStatusToBaseStage(a.status) === 'screening').length,
    interview: inboundApps.filter(a => mapRawStatusToBaseStage(a.status) === 'interview').length,
    onHold: inboundApps.filter(a => a.status?.toLowerCase().includes('hold') || a.status?.toLowerCase().includes('pause')).length,
    rejected: inboundApps.filter(a => mapRawStatusToBaseStage(a.status) === 'rejected').length
  };

  const cleanString = (s?: string) => s?.trim().toLowerCase() || '';
  const outStats = {
    resumeSent: outboundApps.filter(a => ['📨 resume shared', 'resume shared'].includes(cleanString(a.status))).length,
    noResponse: outboundApps.filter(a => ['no response', '👻 no response'].includes(cleanString(a.callStatus)) || ['👻 no response'].includes(cleanString(a.status))).length,
    noOpenings: outboundApps.filter(a => ['🚫 no openings', 'no openings'].includes(cleanString(a.status))).length,
    notCalled: outboundApps.filter(a => ['not called', 'no called'].includes(cleanString(a.callStatus)) || ['not called', 'no called'].includes(cleanString(a.status))).length,
    onHold: outboundApps.filter(a => ['⏸️ on hold', 'on hold', 'paused'].includes(cleanString(a.status))).length,
    rejected: outboundApps.filter(a => ['❌ rejected', 'rejected', '🚶 drop', 'drop'].includes(cleanString(a.status))).length
  };

  return (
    <motion.div 
      className="space-y-8"
      variants={container}
      initial="hidden"
      animate="show"
    >
      {/* Welcome Hero */}
      <motion.div variants={item} className="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 border-b border-card-border pb-6">
        <div>
          <h2 className="text-2xl font-bold tracking-tight text-foreground font-mono flex items-center gap-2">
            Good Morning Mohammed <span className="animate-bounce">👋</span>
          </h2>
          <p className="text-sm text-muted-foreground mt-1">
            Job Search OS active. You have <span className="text-accent font-bold font-mono">{screeningApps.length}</span> screening actions pending and <span className="text-accent font-bold font-mono">{metrics.interviewsCount}</span> interviews tracked in pipeline.
          </p>
        </div>
        <div className="flex gap-2 items-center">
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-emerald-500/10 text-emerald-600 dark:text-emerald-400 border border-emerald-500/20 font-mono tracking-widest uppercase">
            <span className="relative flex h-2 w-2">
              <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
              <span className="relative inline-flex rounded-full h-2 w-2 bg-emerald-500"></span>
            </span>
            Notion API Linked
          </span>
          <span className="inline-flex items-center px-2.5 py-1 rounded-full text-xs font-bold bg-card text-muted-foreground border border-card-border font-mono tracking-widest">
            V1.0
          </span>
          <RefreshButton />
        </div>
      </motion.div>

      {/* MOBILE OPTIMIZED LAYOUT */}
      <div className="flex flex-col gap-6 md:hidden">
        {/* 1. Main Five KPI Cards (Replicating Inbound Style) */}
        <div className="space-y-3">
          {[
            { title: 'Active Applications', value: metrics.totalOpportunities, icon: Briefcase, color: 'text-accent-purple', label: 'Opportunities in active stages' },
            { title: 'Total Contacts', value: metrics.activeRecruiters, icon: Users, color: 'text-accent-blue', label: 'Unique recruiter connections' },
            { title: 'Interviews Loop', value: metrics.interviewsCount, icon: Calendar, color: 'text-accent-amber', label: 'Scheduled round loops' },
            { title: 'Offers Won', value: metrics.offersCount, icon: Award, color: 'text-accent-emerald', label: 'Successful offers won' },
            { title: 'Response Rate', value: `${metrics.responseRate}%`, icon: Percent, color: 'text-indigo-500 dark:text-indigo-400', label: 'Engagement reply metrics' },
          ].map((kpi, idx) => (
            <div 
              key={idx}
              className="glass-card-interactive p-3.5 rounded-xl border border-card-border flex items-center justify-between gap-3 shadow-sm"
            >
              <div className="space-y-0.5">
                <span className="text-[10px] text-slate-500 font-mono uppercase tracking-widest font-bold block">{kpi.title}</span>
                <span className="text-xs text-muted-foreground font-medium block">{kpi.label}</span>
              </div>
              <div className="flex items-center gap-3">
                <span className="text-2xl font-black tracking-tight font-mono text-foreground">{kpi.value}</span>
                <div className="p-2 rounded-lg bg-foreground/5 border border-card-border/50">
                  <kpi.icon size={14} className={kpi.color} />
                </div>
              </div>
            </div>
          ))}
        </div>

        {/* 2. Inbound Pipeline stats */}
        <div className="glass-panel rounded-xl p-4 border border-card-border">
          <h3 className="text-[11px] font-mono font-bold uppercase tracking-widest text-slate-500 mb-3 border-b border-card-border pb-1.5 flex items-center gap-1.5">
            <span>📥</span> Inbound Pipeline
          </h3>
          <div className="grid grid-cols-2 gap-2">
            <div className="p-2.5 rounded-xl bg-accent-amber/10 border border-accent-amber/20 flex flex-col justify-between">
              <span className="text-[10px] text-accent-amber font-mono font-bold uppercase tracking-wide">Screening</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{inStats.screening}</span>
            </div>
            <div className="p-2.5 rounded-xl bg-accent-blue/10 border border-accent-blue/20 flex flex-col justify-between">
              <span className="text-[10px] text-accent-blue font-mono font-bold uppercase tracking-wide">Interviews</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{inStats.interview}</span>
            </div>
            <div className="p-2.5 rounded-xl bg-zinc-500/10 border border-zinc-500/20 flex flex-col justify-between">
              <span className="text-[10px] text-zinc-400 font-mono font-bold uppercase tracking-wide">On Hold</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{inStats.onHold}</span>
            </div>
            <div className="p-2.5 rounded-xl bg-rose-500/10 border border-rose-500/20 flex flex-col justify-between">
              <span className="text-[10px] text-rose-500 font-mono font-bold uppercase tracking-wide">Rejected</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{inStats.rejected}</span>
            </div>
          </div>
        </div>

        {/* 3. Outbound Pipeline stats */}
        <div className="glass-panel rounded-xl p-4 border border-card-border">
          <h3 className="text-[11px] font-mono font-bold uppercase tracking-widest text-slate-500 mb-3 border-b border-card-border pb-1.5 flex items-center gap-1.5">
            <span>📤</span> Outbound Pipeline
          </h3>
          <div className="grid grid-cols-2 gap-2">
            <div className="p-2.5 rounded-xl bg-accent-purple/10 border border-accent-purple/20 flex flex-col justify-between">
              <span className="text-[10px] text-accent-purple font-mono font-bold uppercase tracking-wide">Not Called</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{outStats.notCalled}</span>
            </div>
            <div className="p-2.5 rounded-xl bg-emerald-500/10 border border-emerald-500/20 flex flex-col justify-between">
              <span className="text-[10px] text-emerald-500 font-mono font-bold uppercase tracking-wide">Resume Sent</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{outStats.resumeSent}</span>
            </div>
            <div className="p-2.5 rounded-xl bg-accent-blue/10 border border-accent-blue/20 flex flex-col justify-between">
              <span className="text-[10px] text-accent-blue font-mono font-bold uppercase tracking-wide">No Response</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{outStats.noResponse}</span>
            </div>
            <div className="p-2.5 rounded-xl bg-orange-500/10 border border-orange-500/20 flex flex-col justify-between">
              <span className="text-[10px] text-orange-500 font-mono font-bold uppercase tracking-wide">No Openings</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{outStats.noOpenings}</span>
            </div>
            <div className="p-2.5 rounded-xl bg-zinc-500/10 border border-zinc-500/20 flex flex-col justify-between">
              <span className="text-[10px] text-zinc-400 font-mono font-bold uppercase tracking-wide">On Hold</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{outStats.onHold}</span>
            </div>
            <div className="p-2.5 rounded-xl bg-rose-500/10 border border-rose-500/20 flex flex-col justify-between">
              <span className="text-[10px] text-rose-500 font-mono font-bold uppercase tracking-wide">Rejected</span>
              <span className="text-xl font-bold text-foreground font-mono mt-1">{outStats.rejected}</span>
            </div>
          </div>
        </div>

        {/* 4. Interview Pipeline */}
        <div className="glass-panel rounded-xl p-4 border border-card-border">
          <div className="flex items-center justify-between mb-4 border-b border-card-border pb-1.5">
            <h3 className="text-[11px] font-mono font-bold uppercase tracking-widest text-slate-500 flex items-center gap-1.5">
              <span>🎯</span> Interview Pipeline
            </h3>
            <Calendar size={12} className="text-accent-amber" />
          </div>
          <div className="space-y-2.5 max-h-[200px] overflow-y-auto pr-1">
            {(() => {
              const interviewApps = metrics.allApplications?.filter(a => mapNotionStatusToFormulaStatus(a.status) === '🎯 Interview Pipeline') || [];
              if (interviewApps.length === 0) return <p className="text-center text-xs text-muted-foreground font-mono py-4">No interviews in pipeline</p>;
              
              return interviewApps.map(app => (
                <div key={app.id} className="p-2.5 rounded-lg bg-card border border-card-border flex flex-col gap-2 hover:border-accent-amber/30 transition-all">
                  <div className="flex justify-between items-center gap-2">
                    <div className="space-y-0.5 overflow-hidden">
                      <div className="text-xs font-bold text-foreground truncate">{app.company}</div>
                      <div className="text-[10px] text-muted-foreground font-medium truncate">{app.role}</div>
                    </div>
                    <span className="text-[9px] font-mono bg-accent-amber/10 text-accent-amber px-2 py-0.5 rounded border border-accent-amber/20 font-bold whitespace-nowrap truncate max-w-[80px]" title={app.status}>
                      {app.status}
                    </span>
                  </div>

                  {/* Communication actions */}
                  {(app.recruiterPhone || app.recruiterEmail) && (
                    <div className="flex items-center gap-2.5 pt-1.5 border-t border-card-border/50">
                      {app.recruiterPhone && (
                        <>
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              triggerPhone(app.recruiterPhone);
                            }}
                            className="comm-btn active:scale-95 hover:scale-105 transition-transform"
                            title="Call"
                          >
                            <FcPhone size={14} />
                          </button>
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              triggerWhatsApp(app.recruiterPhone, app.recruiterName);
                            }}
                            className="comm-btn active:scale-95 hover:scale-105 transition-transform text-[#25D366]"
                            title="WhatsApp"
                          >
                            <SiWhatsapp size={12} />
                          </button>
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              triggerSMS(app.recruiterPhone, app.recruiterName);
                            }}
                            className="comm-btn active:scale-95 hover:scale-105 transition-transform"
                            title="Google Messages SMS"
                          >
                            <FcSms size={14} />
                          </button>
                        </>
                      )}
                      {app.recruiterEmail && (
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation();
                            triggerGmail(app.recruiterEmail, app.recruiterName);
                          }}
                          className="comm-btn active:scale-95 hover:scale-105 transition-transform text-[#EA4335]"
                          title="Email"
                        >
                          <SiGmail size={12} />
                        </button>
                      )}
                      {app.recruiterName && (
                        <span className="text-[9px] text-muted-foreground font-mono ml-auto truncate max-w-[120px]">
                          👤 {app.recruiterName}
                        </span>
                      )}
                    </div>
                  )}
                </div>
              ));
            })()}
          </div>
        </div>

        {/* 5. Upcoming Interviews */}
        <div className="glass-panel rounded-xl p-4 border border-card-border">
          <div className="flex items-center justify-between mb-4 border-b border-card-border pb-1.5">
            <h3 className="text-[11px] font-mono font-bold uppercase tracking-widest text-slate-500 flex items-center gap-1.5">
              <span>⏰</span> Upcoming Interviews
            </h3>
            <Clock size={12} className="text-accent-amber" />
          </div>
          <div className="space-y-2.5">
            {(() => {
              const upcoming = metrics.upcomingInterviews.filter(a => mapRawStatusToBaseStage(a.status) === 'interview');
              if (upcoming.length === 0) return <p className="text-center py-4 text-muted-foreground text-xs font-mono">No interviews scheduled</p>;
              
              return upcoming.map((interview) => (
                <div key={interview.id} className="p-2.5 rounded-lg bg-card border border-card-border flex justify-between items-center">
                  <div className="space-y-0.5">
                    <h4 className="text-xs font-bold text-foreground">{interview.company}</h4>
                    <p className="text-[10px] text-muted-foreground font-medium">{interview.role} {interview.workMode ? `(${interview.workMode})` : ''}</p>
                  </div>
                  <span className="px-2 py-0.5 rounded bg-accent-amber/10 border border-accent-amber/20 text-accent-amber font-mono font-bold text-[9px] uppercase">
                    Scheduled
                  </span>
                </div>
              ));
            })()}
          </div>
        </div>

        {/* 6. Screening Centre */}
        <div className="glass-panel rounded-xl p-4 border border-card-border">
          <div className="flex justify-between items-center mb-3 border-b border-card-border pb-1.5">
            <h3 className="text-[11px] font-mono font-bold uppercase tracking-widest text-slate-500 flex items-center gap-1.5">
              <span>🔍</span> Screening Centre
            </h3>
            <span className="text-[9px] font-mono bg-accent/10 text-accent px-1.5 py-0.5 rounded border border-accent/20 font-bold">
              {screeningApps.length}
            </span>
          </div>
          
          <div className="flex gap-1 mb-3">
            {['all', 'high', 'medium'].map((tab) => (
              <button
                key={tab}
                onClick={() => setActiveTab(tab as 'all' | 'high' | 'medium')}
                className={`px-2 py-0.5 rounded text-[9px] font-mono uppercase font-bold transition-all active:scale-95 select-none ${
                  activeTab === tab 
                    ? 'bg-accent/10 text-accent border border-accent/20' 
                    : 'text-muted-foreground border border-transparent'
                }`}
              >
                {tab}
              </button>
            ))}
          </div>

          <div className="space-y-2.5 max-h-[300px] overflow-y-auto pr-1">
            {filteredScreeningApps.length === 0 ? (
              <div className="text-center py-4 text-muted-foreground text-xs font-mono">
                ✓ No screenings pending
              </div>
            ) : (
              filteredScreeningApps.map((app) => (
                <div key={app.id} className="p-3 rounded-lg bg-card border border-card-border flex flex-col gap-2">
                  <div className="flex justify-between items-start">
                    <div>
                      <div className="text-xs font-bold text-foreground leading-tight flex items-center gap-1">
                        {app.role}
                        {app.priority === 'High' && <span className="w-1.5 h-1.5 rounded-full bg-red-500" />}
                      </div>
                      <p className="text-[10px] text-muted-foreground font-medium mt-0.5">
                        at <span className="text-foreground/80 font-bold">{app.company}</span>
                      </p>
                    </div>
                    <span className="text-[8px] font-mono bg-accent-amber/10 text-accent-amber px-1.5 py-0.25 rounded border border-accent-amber/20 font-bold">
                      {app.type}
                    </span>
                  </div>
                  <div className="flex items-center justify-between pt-2 border-t border-card-border/50 gap-2">
                    <div className="flex items-center gap-2">
                      {app.recruiterPhone && (
                        <>
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              triggerPhone(app.recruiterPhone);
                            }}
                            className="comm-btn active:scale-95"
                            title="Call"
                          >
                            <FcPhone size={15} />
                          </button>
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              triggerWhatsApp(app.recruiterPhone, app.recruiterName);
                            }}
                            className="comm-btn active:scale-95 text-[#25D366]"
                            title="WhatsApp"
                          >
                            <SiWhatsapp size={13} />
                          </button>
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              triggerSMS(app.recruiterPhone, app.recruiterName);
                            }}
                            className="comm-btn active:scale-95"
                            title="Google Messages SMS"
                          >
                            <FcSms size={15} />
                          </button>
                        </>
                      )}
                      {app.recruiterEmail && (
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation();
                            triggerGmail(app.recruiterEmail, app.recruiterName);
                          }}
                          className="comm-btn active:scale-95 text-[#EA4335]"
                          title="Email"
                        >
                          <SiGmail size={13} />
                        </button>
                      )}
                    </div>
                    <CustomSelect
                      className="text-[9px] font-mono font-bold bg-card border border-card-border rounded px-1.5 py-0.5 text-foreground cursor-pointer w-auto"
                      value={app.status}
                      onChange={(val) => handleStatusChange(app.id, val)}
                      disabled={isMarking}
                      options={schemaOptions?.statuses || []}
                      label="Status"
                    />
                  </div>
                </div>
              ))
            )}
          </div>
        </div>

        {/* 7. Test Attempted */}
        <div className="glass-panel rounded-xl p-4 border border-card-border">
          <div className="flex items-center justify-between mb-4 border-b border-card-border pb-1.5">
            <h3 className="text-[11px] font-mono font-bold uppercase tracking-widest text-slate-500 flex items-center gap-1.5">
              <span>📝</span> Test Attempted
            </h3>
            <Award size={12} className="text-accent-blue" />
          </div>
          <div className="space-y-2.5 max-h-[200px] overflow-y-auto pr-1">
            {(() => {
              const testApps = metrics.allApplications?.filter(a => a.status?.toLowerCase().includes('test attempted')) || [];
              if (testApps.length === 0) return <p className="text-center text-xs text-muted-foreground font-mono py-4">No tests pending</p>;
              
              return testApps.map(app => (
                <div key={app.id} className="p-2.5 rounded-lg bg-card border border-card-border flex justify-between items-center gap-2 hover:border-accent-blue/30 transition-all">
                  <div className="space-y-0.5 overflow-hidden">
                    <div className="text-xs font-bold text-foreground truncate">{app.company}</div>
                    <div className="text-[10px] text-muted-foreground font-medium truncate">{app.role}</div>
                  </div>
                  {app.receivedCallOn && (
                    <span className="text-[9px] font-mono bg-green-500/10 text-green-600 dark:text-green-400 px-2 py-0.5 rounded border border-green-500/20 whitespace-nowrap">
                      {app.receivedCallOn}
                    </span>
                  )}
                </div>
              ));
            })()}
          </div>
        </div>

        {/* 8. Latest Timeline */}
        <div className="glass-panel rounded-xl p-4 border border-card-border">
          <div className="flex justify-between items-center mb-4 border-b border-card-border pb-1.5">
            <h3 className="text-[11px] font-mono font-bold uppercase tracking-widest text-slate-500 flex items-center gap-1.5">
              <span>⏱️</span> Latest Timeline
            </h3>
            <span className="text-[9px] text-slate-500 font-mono">Logs</span>
          </div>
          <div className="space-y-2.5">
            {(() => {
              const today = new Date().toISOString().split('T')[0];
              const timelineApps = metrics.allApplications?.filter(app => {
                if (!app.lastContactedDate) return false;
                return app.lastContactedDate <= today;
              }).sort((a, b) => new Date(b.lastContactedDate!).getTime() - new Date(a.lastContactedDate!).getTime()) || [];
              
              if (timelineApps.length === 0) return <p className="text-center text-xs text-muted-foreground font-mono py-4">No activity logs</p>;

              return timelineApps.slice(0, 4).map((activity) => (
                <div key={activity.id} className="flex flex-col gap-1.5 py-2 border-b border-card-border/50 last:border-0 hover:bg-card/30 rounded px-1.5 transition-colors">
                  <div className="flex items-center justify-between">
                    <span className="text-xs font-bold text-foreground leading-tight">{activity.role} <span className="text-[10px] text-muted-foreground font-mono font-medium">at</span> {activity.company}</span>
                    <span className={`px-1.5 py-0.25 rounded text-[8px] font-mono font-bold capitalize border ${
                      activity.status === 'offered' ? 'bg-accent-emerald/10 text-accent-emerald border-accent-emerald/20' :
                      activity.status === 'interview' ? 'bg-accent-blue/10 text-accent-blue border border-accent-blue/20' :
                      activity.status === 'screening' ? 'bg-accent-amber/10 text-accent-amber border border-accent-amber/20' :
                      activity.status === 'sourcing' ? 'bg-accent-purple/10 text-accent-purple border border-accent-purple/20' :
                      activity.status === 'rejected' ? 'bg-accent-red/10 text-accent-red border border-accent-red/20' :
                      'bg-card text-muted-foreground border-card-border'
                    }`}>
                      {activity.status}
                    </span>
                  </div>
                  <div className="flex justify-between items-center text-[9px] text-muted-foreground font-mono">
                    <span>{activity.location} {activity.workMode ? `• ${activity.workMode}` : ''}</span>
                    <span>Updated: {activity.lastUpdated}</span>
                  </div>
                </div>
              ));
            })()}
          </div>
        </div>
      </div>

      {/* DESKTOP LAYOUT (Default grid) */}
      <div className="hidden md:block space-y-8">
        {/* KPI Cards Row */}
        <div className="grid grid-cols-2 lg:grid-cols-5 gap-4">
          {[
            { title: 'Active Applications', value: metrics.totalOpportunities, icon: Briefcase, color: 'text-accent-purple', bg: 'glow-purple' },
            { title: 'Total Contacts', value: metrics.activeRecruiters, icon: Users, color: 'text-accent-blue', bg: 'glow-cyan' },
            { title: 'Interviews Loop', value: metrics.interviewsCount, icon: Calendar, color: 'text-accent-amber', bg: 'glow-emerald' },
            { title: 'Offers Won', value: metrics.offersCount, icon: Award, color: 'text-accent-emerald', bg: 'glow-emerald' },
            { title: 'Response Rate', value: `${metrics.responseRate}%`, icon: Percent, color: 'text-indigo-500 dark:text-indigo-400', bg: 'glow-purple' },
          ].map((kpi, idx) => (
            <motion.div 
              key={idx} 
              whileHover={{ y: -4, scale: 1.02 }}
              transition={{ type: "spring", stiffness: 400, damping: 25 }}
              className="glass-card-interactive rounded-2xl p-5 flex flex-col justify-between min-h-[120px] will-change-transform cursor-default"
            >
              <div className="flex justify-between items-start">
                <span className="text-[13px] text-muted-foreground font-semibold tracking-wider uppercase">{kpi.title}</span>
                <div className="p-2 rounded-xl bg-slate-100/50 dark:bg-white/5 border border-slate-200/50 dark:border-white/5">
                  <kpi.icon size={16} className={`${kpi.color}`} />
                </div>
              </div>
              <div className="mt-4">
                <span className="text-3xl lg:text-4xl font-black tracking-tighter font-mono text-foreground">
                  {kpi.value}
                </span>
              </div>
            </motion.div>
          ))}
        </div>

        {/* Granular Pipeline Health Breakdown */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-6 mb-6">
          <div className="glass-panel rounded-2xl p-5">
            <h3 className="text-[13px] font-semibold uppercase tracking-wider text-muted-foreground font-mono mb-4 border-b border-card-border pb-2">
              Inbound Pipeline
            </h3>
            <div className="grid grid-cols-2 md:grid-cols-4 gap-2">
              <div className="p-2 rounded-xl bg-accent-amber/10 border border-accent-amber/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-accent-amber font-mono mb-1 leading-tight break-words">Screening</div>
                <div className="text-lg font-bold text-foreground font-mono">{inStats.screening}</div>
              </div>
              <div className="p-2 rounded-xl bg-accent-blue/10 border border-accent-blue/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-accent-blue font-mono mb-1 leading-tight break-words">Interviews</div>
                <div className="text-lg font-bold text-foreground font-mono">{inStats.interview}</div>
              </div>
              <div className="p-2 rounded-xl bg-zinc-500/10 border border-zinc-500/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-zinc-400 font-mono mb-1 leading-tight break-words">On Hold</div>
                <div className="text-lg font-bold text-foreground font-mono">{inStats.onHold}</div>
              </div>
              <div className="p-2 rounded-xl bg-rose-500/10 border border-rose-500/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-rose-500 font-mono mb-1 leading-tight break-words">Rejected</div>
                <div className="text-lg font-bold text-foreground font-mono">{inStats.rejected}</div>
              </div>
            </div>
          </div>

          <div className="glass-panel rounded-2xl p-5">
            <h3 className="text-[13px] font-semibold uppercase tracking-wider text-muted-foreground font-mono mb-4 border-b border-card-border pb-2">
              Outbound Pipeline
            </h3>
            <div className="grid grid-cols-3 md:grid-cols-6 gap-2">
              <div className="p-2 rounded-xl bg-accent-purple/10 border border-accent-purple/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-accent-purple font-mono mb-1 leading-tight break-words">Not Called</div>
                <div className="text-lg font-bold text-foreground font-mono">{outStats.notCalled}</div>
              </div>
              <div className="p-2 rounded-xl bg-emerald-500/10 border border-emerald-500/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-emerald-500 font-mono mb-1 leading-tight break-words">Resume Sent</div>
                <div className="text-lg font-bold text-foreground font-mono">{outStats.resumeSent}</div>
              </div>
              <div className="p-2 rounded-xl bg-accent-blue/10 border border-accent-blue/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-accent-blue font-mono mb-1 leading-tight break-words">No Response</div>
                <div className="text-lg font-bold text-foreground font-mono">{outStats.noResponse}</div>
              </div>
              <div className="p-2 rounded-xl bg-orange-500/10 border border-orange-500/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-orange-500 font-mono mb-1 leading-tight break-words">No Openings</div>
                <div className="text-lg font-bold text-foreground font-mono">{outStats.noOpenings}</div>
              </div>
              <div className="p-2 rounded-xl bg-zinc-500/10 border border-zinc-500/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-zinc-400 font-mono mb-1 leading-tight break-words">On Hold</div>
                <div className="text-lg font-bold text-foreground font-mono">{outStats.onHold}</div>
              </div>
              <div className="p-2 rounded-xl bg-rose-500/10 border border-rose-500/20 flex flex-col justify-between">
                <div className="text-[10px] sm:text-xs text-rose-500 font-mono mb-1 leading-tight break-words">Rejected</div>
                <div className="text-lg font-bold text-foreground font-mono">{outStats.rejected}</div>
              </div>
            </div>
          </div>
        </div>

        {/* Section Grid */}
        <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
          {/* Left Column */}
          <div className="lg:col-span-2 space-y-6">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              {/* Test Attempted */}
              <div className="glass-panel rounded-2xl p-6 glow-purple">
                <div className="flex items-center justify-between mb-6">
                  <div>
                    <h3 className="text-xs font-semibold uppercase tracking-wider text-muted-foreground font-mono">
                      Test Attempted
                    </h3>
                    <p className="text-xs text-muted-foreground mt-0.5">Applications pending test results</p>
                  </div>
                  <Award size={16} className="text-accent-blue" />
                </div>
                
                <div className="space-y-3 h-[200px] overflow-y-auto pr-1">
                  {(() => {
                    const testApps = metrics.allApplications?.filter(a => a.status?.toLowerCase().includes('test attempted')) || [];
                    if (testApps.length === 0) return <p className="text-center text-xs text-muted-foreground font-mono mt-8">No tests pending</p>;
                    
                    return testApps.map(app => (
                      <div key={app.id} className="p-2.5 rounded-xl bg-card border border-card-border hover:border-accent-blue/30 transition-colors flex justify-between items-center gap-2">
                        <div className="space-y-0.5 overflow-hidden">
                          <div className="text-xs font-bold text-foreground truncate">{app.company}</div>
                          <div className="text-xs text-muted-foreground font-medium truncate">{app.role}</div>
                        </div>
                        <div className="flex items-center gap-2">
                          {app.receivedCallOn && (
                            <span className="flex items-center gap-1 text-xs font-mono bg-green-500/10 text-green-600 dark:text-green-400 px-2 py-0.5 rounded border border-green-500/20 whitespace-nowrap">
                              <Phone size={8} />
                              {app.receivedCallOn}
                            </span>
                          )}
                        </div>
                      </div>
                    ));
                  })()}
                </div>
              </div>

              {/* Interview Pipeline */}
              <div className="glass-panel rounded-2xl p-6 glow-cyan">
                <div className="flex items-center justify-between mb-6">
                  <div>
                    <h3 className="text-xs font-semibold uppercase tracking-wider text-muted-foreground font-mono">
                      Interview Pipeline
                    </h3>
                    <p className="text-xs text-muted-foreground mt-0.5">Applications currently in interviews</p>
                  </div>
                  <Calendar size={16} className="text-accent-amber" />
                </div>

                <div className="space-y-3 h-[200px] overflow-y-auto pr-1">
                  {(() => {
                    const interviewApps = metrics.allApplications?.filter(a => mapNotionStatusToFormulaStatus(a.status) === '🎯 Interview Pipeline') || [];
                    if (interviewApps.length === 0) return <p className="text-center text-xs text-muted-foreground font-mono mt-8">No interviews in pipeline</p>;
                    
                    return interviewApps.map(app => (
                      <div key={app.id} className="p-2.5 rounded-xl bg-card border border-card-border hover:border-accent-amber/30 transition-all flex flex-col gap-2">
                        <div className="flex justify-between items-center gap-2">
                          <div className="space-y-0.5 overflow-hidden">
                            <div className="text-xs font-bold text-foreground truncate">{app.company}</div>
                            <div className="text-xs text-muted-foreground font-medium truncate">{app.role}</div>
                          </div>
                          <span className="text-xs font-mono bg-accent-amber/10 text-accent-amber px-2 py-0.5 rounded border border-accent-amber/20 whitespace-nowrap truncate max-w-[120px]" title={app.status}>
                            {app.status}
                          </span>
                        </div>

                        {/* Comm Actions */}
                        {(app.recruiterPhone || app.recruiterEmail) && (
                          <div className="flex items-center gap-3 pt-2 border-t border-card-border/50">
                            {app.recruiterPhone && (
                              <>
                                <button
                                  type="button"
                                  onClick={(e) => {
                                    e.stopPropagation();
                                    triggerPhone(app.recruiterPhone);
                                  }}
                                  title="Call"
                                  className="comm-btn hover:scale-110 active:scale-95 transition-transform"
                                >
                                  <FcPhone size={16} />
                                </button>
                                <button
                                  type="button"
                                  onClick={(e) => {
                                    e.stopPropagation();
                                    triggerWhatsApp(app.recruiterPhone, app.recruiterName);
                                  }}
                                  title="WhatsApp"
                                  className="comm-btn hover:scale-110 active:scale-95 transition-transform text-[#25D366]"
                                >
                                  <SiWhatsapp size={14} />
                                </button>
                                <button
                                  type="button"
                                  onClick={(e) => {
                                    e.stopPropagation();
                                    triggerSMS(app.recruiterPhone, app.recruiterName);
                                  }}
                                  title="SMS"
                                  className="comm-btn hover:scale-110 active:scale-95 transition-transform"
                                >
                                  <FcSms size={16} />
                                </button>
                              </>
                            )}
                            {app.recruiterEmail && (
                              <button
                                type="button"
                                onClick={(e) => {
                                  e.stopPropagation();
                                  triggerGmail(app.recruiterEmail, app.recruiterName);
                                }}
                                title="Gmail"
                                className="comm-btn hover:scale-110 active:scale-95 transition-transform text-[#EA4335]"
                              >
                                <SiGmail size={14} />
                              </button>
                            )}
                            {app.recruiterName && (
                              <span className="text-[10px] text-muted-foreground font-mono ml-auto truncate max-w-[150px]">
                                Recruiter: {app.recruiterName}
                              </span>
                            )}
                          </div>
                        )}
                      </div>
                    ));
                  })()}
                </div>
              </div>
            </div>

            {/* Latest Timeline Activity */}
            <div className="glass-panel rounded-2xl p-6">
              <div className="flex justify-between items-center mb-4">
                <h3 className="text-xs font-semibold uppercase tracking-wider text-muted-foreground font-mono flex items-center gap-2">
                  <Clock size={12} className="text-muted-foreground" />
                  Latest Timeline Activity
                </h3>
                <span className="text-xs text-muted-foreground font-mono">Live timeline logs</span>
              </div>
              
              <div className="space-y-3.5">
                {(() => {
                  const today = new Date().toISOString().split('T')[0];
                  const timelineApps = metrics.allApplications?.filter(app => {
                    if (!app.lastContactedDate) return false;
                    return app.lastContactedDate <= today;
                  }).sort((a, b) => new Date(b.lastContactedDate!).getTime() - new Date(a.lastContactedDate!).getTime()) || [];
                  
                  if (timelineApps.length === 0) return <p className="text-center text-xs text-muted-foreground font-mono mt-8">No activity before today</p>;

                  return timelineApps.slice(0, 4).map((activity) => (
                    <div key={activity.id} className="flex flex-col sm:flex-row sm:items-center justify-between py-3 sm:py-2 border-b border-card-border last:border-0 hover:bg-card/30 px-2 rounded-lg transition-colors gap-2 sm:gap-0">
                      <div className="flex flex-col gap-0.5">
                        <div className="flex items-center gap-2">
                          <span className="text-xs font-semibold text-foreground">{activity.role}</span>
                          <span className="text-xs text-muted-foreground font-mono">at</span>
                          <span className="text-xs font-bold text-foreground/90">{activity.company}</span>
                        </div>
                        <div className="flex items-center gap-1.5 text-xs text-muted-foreground font-medium">
                          {activity.location && <span>Location: {activity.location}</span>}
                          {activity.workMode && (
                            <>
                              <span>•</span>
                              <span>{activity.workMode}</span>
                            </>
                          )}
                        </div>
                      </div>
                      <div className="flex items-center gap-3 self-end sm:self-auto">
                        <span className="text-xs font-mono text-muted-foreground">
                          Updated: {activity.lastUpdated}
                        </span>
                        <span className={`px-2 py-0.5 rounded text-xs font-mono font-bold capitalize ${
                          activity.status === 'offered' ? 'bg-accent-emerald/10 text-accent-emerald border border-accent-emerald/20' :
                          activity.status === 'interview' ? 'bg-accent-blue/10 text-accent-blue border border-accent-blue/20' :
                          activity.status === 'screening' ? 'bg-accent-amber/10 text-accent-amber border border-accent-amber/20' :
                          activity.status === 'sourcing' ? 'bg-accent-purple/10 text-accent-purple border border-accent-purple/20' :
                          activity.status === 'rejected' ? 'bg-accent-red/10 text-accent-red border border-accent-red/20' :
                          'bg-card text-muted-foreground border border-card-border'
                        }`}>
                          {activity.status}
                        </span>
                      </div>
                    </div>
                  ));
                })()}
              </div>
            </div>
          </div>

          {/* Right Column */}
          <div className="space-y-6">
            {/* Screening Action Center */}
            <div className="glass-panel rounded-2xl p-6 border border-card-border">
              <div className="flex flex-col gap-1.5 mb-5">
                <div className="flex justify-between items-center">
                  <h3 className="text-xs font-semibold uppercase tracking-wider text-foreground font-mono flex items-center gap-2">
                    <Sparkles size={13} className="text-accent animate-pulse" />
                    Screening Action Center
                  </h3>
                  <span className="text-xs font-mono bg-accent/10 text-accent px-2 py-0.5 rounded-full font-bold border border-accent/20">
                    {screeningApps.length}
                  </span>
                </div>
                <p className="text-xs text-muted-foreground">Manage active screening stage applications</p>
              </div>

              {/* Filter Tabs and Search */}
              <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-3 border-b border-card-border pb-3.5 mb-4">
                {/* Mobile Filter & Search Bar */}
                <div className="sm:hidden flex flex-col gap-2 w-full">
                  <div className="flex items-center gap-2 w-full">
                    <button
                      type="button"
                      onClick={() => setIsFiltersExpanded(!isFiltersExpanded)}
                      className="flex-1 h-9 bg-white/80 dark:bg-[#0a0a0a]/80 backdrop-blur-xl border border-slate-200/50 dark:border-white/10 shadow-sm rounded-xl px-3 flex items-center justify-between text-xs font-mono font-bold text-foreground cursor-pointer select-none active:scale-[0.99] transition-all"
                    >
                      <div className="flex items-center gap-1.5">
                        <Filter size={12} className="text-accent-blue" />
                        <span>Filter</span>
                      </div>
                      <ChevronDown size={12} className={`transform transition-transform duration-200 ${isFiltersExpanded ? 'rotate-180' : ''}`} />
                    </button>
                    
                    <div className="flex-[1.5] relative">
                      <input
                        type="text"
                        placeholder="Search company..."
                        value={screeningSearch}
                        onChange={(e) => setScreeningSearch(e.target.value)}
                        className="w-full h-9 px-3 bg-white/80 dark:bg-[#0a0a0a]/80 backdrop-blur-xl border border-slate-200/50 dark:border-white/10 shadow-sm rounded-xl focus:outline-none focus:ring-2 focus:ring-accent-blue/20 focus:border-accent-blue transition-all duration-200 text-xs font-semibold text-foreground placeholder:text-muted-foreground/50 font-mono"
                      />
                    </div>
                  </div>

                  {isFiltersExpanded && (
                    <div className="mt-2 p-3.5 bg-white/95 dark:bg-[#0f0f11]/97 backdrop-blur-xl border border-slate-200/70 dark:border-white/8 shadow-xl rounded-xl flex flex-wrap gap-2 animate-fade-in-pop">
                      <div className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-full text-[10px] font-mono font-bold uppercase bg-cyan-500/10 text-cyan-600 dark:text-cyan-400 dark:bg-cyan-500/15 border border-cyan-500/25">
                        <span className="text-[9px] uppercase tracking-widest font-bold opacity-60">Filter:</span>
                        <CustomSelect
                          value={activeTab}
                          onChange={(val) => setActiveTab(val as 'all' | 'high' | 'medium')}
                          options={[
                            { value: 'all', label: 'All Priorities' },
                            { value: 'high', label: '🔴 High' },
                            { value: 'medium', label: '🟡 Medium' },
                          ]}
                          label="Priority Filter"
                          className="bg-transparent text-cyan-600 dark:text-cyan-400 focus:outline-none cursor-pointer font-bold font-mono text-[10px] uppercase text-center border-0 p-0 w-auto"
                        />
                      </div>
                    </div>
                  )}
                </div>

                {/* Desktop Filter Bar */}
                <div className="hidden sm:flex items-center justify-between w-full">
                  <div className="flex items-center gap-1.5">
                    <span className="text-[10px] font-mono font-bold text-muted-foreground uppercase tracking-wider">Priority:</span>
                    <select
                      value={activeTab}
                      onChange={(e) => setActiveTab(e.target.value as 'all' | 'high' | 'medium')}
                      className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1 text-foreground focus:outline-none focus:border-accent cursor-pointer appearance-none text-center"
                    >
                      <option value="all">All Priorities</option>
                      <option value="high">🔴 High</option>
                      <option value="medium">🟡 Medium</option>
                    </select>
                  </div>
                  <div className="relative">
                    <input
                      type="text"
                      placeholder="Search company..."
                      value={screeningSearch}
                      onChange={(e) => setScreeningSearch(e.target.value)}
                      className="w-40 px-3 py-1.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-lg focus:outline-none focus:ring-2 focus:ring-accent-blue/20 focus:border-accent-blue transition-all duration-200 text-xs font-semibold text-foreground placeholder:text-muted-foreground/50 font-mono"
                    />
                  </div>
                </div>
              </div>

              {/* List */}
              <div className="space-y-4 max-h-[400px] overflow-y-auto pr-1">
                {filteredScreeningApps.length === 0 ? (
                  <div className="text-center py-8 text-muted-foreground text-xs font-mono">
                    ✓ No screening actions pending
                  </div>
                ) : (
                  filteredScreeningApps.map((app) => (
                    <div 
                      key={app.id} 
                      className="p-4 rounded-xl bg-card border border-card-border hover:border-accent/40 transition-colors flex flex-col gap-3"
                    >
                      <div className="flex justify-between items-start">
                        <div className="space-y-1">
                          <div className="flex items-center gap-1.5">
                            <span className="text-xs font-bold text-foreground leading-tight">
                              {app.role}
                            </span>
                            {app.priority === 'High' && (
                              <span className="w-1.5 h-1.5 rounded-full bg-red-500" title="High Priority" />
                            )}
                          </div>
                          <p className="text-xs text-muted-foreground font-bold">
                            at <span className="text-foreground/80">{app.company}</span>
                            {app.recruiterName && <span className="ml-1">• {app.recruiterName}</span>}
                          </p>
                        </div>
                        
                        <span className="text-xs font-mono bg-accent-amber/10 text-accent-amber px-2 py-0.5 rounded border border-accent-amber/20 font-bold whitespace-nowrap">
                          {app.type}
                        </span>
                      </div>

                      <div className="flex flex-wrap items-center gap-3 pt-2 border-t border-card-border">
                        {/* Action Buttons */}
                        {app.recruiterPhone && (
                          <>
                            <button
                              type="button"
                              onClick={(e) => {
                                e.stopPropagation();
                                triggerPhone(app.recruiterPhone);
                              }}
                              title="Call Recruiter"
                              className="comm-btn transition-all hover:scale-110 active:scale-95 drop-shadow-sm"
                            >
                              <FcPhone size={18} />
                            </button>
                            <button
                              type="button"
                              onClick={(e) => {
                                e.stopPropagation();
                                triggerWhatsApp(app.recruiterPhone, app.recruiterName);
                              }}
                              title="WhatsApp"
                              className="comm-btn transition-all hover:scale-110 active:scale-95 drop-shadow-sm text-[#25D366]"
                            >
                              <SiWhatsapp size={16} />
                            </button>
                            <button
                              type="button"
                              onClick={(e) => {
                                e.stopPropagation();
                                triggerSMS(app.recruiterPhone, app.recruiterName);
                              }}
                              title="SMS / Message"
                              className="comm-btn transition-all hover:scale-110 active:scale-95 drop-shadow-sm"
                            >
                              <FcSms size={18} />
                            </button>
                          </>
                        )}
                        {app.recruiterEmail && (
                          <button
                            type="button"
                            onClick={(e) => {
                              e.stopPropagation();
                              triggerGmail(app.recruiterEmail, app.recruiterName);
                            }}
                            title="Email"
                            className="comm-btn transition-all hover:scale-110 active:scale-95 drop-shadow-sm text-[#EA4335]"
                          >
                            <SiGmail size={16} />
                          </button>
                        )}

                        {/* Status Dropdown */}
                        <div className="ml-auto">
                          <CustomSelect
                            className="text-xs font-mono font-bold bg-card border border-card-border rounded-md px-2 py-1 text-foreground focus:outline-none focus:border-accent transition-colors cursor-pointer hover:bg-card-border/30 w-auto"
                            value={app.status}
                            onChange={(val) => handleStatusChange(app.id, val)}
                            disabled={isMarking}
                            options={schemaOptions?.statuses || []}
                            label="Status"
                          />
                        </div>
                      </div>
                    </div>
                  ))
                )}
              </div>
            </div>

            {/* Upcoming Interview Tracker */}
            <div className="glass-panel rounded-2xl p-6">
              <h3 className="text-xs font-semibold uppercase tracking-wider text-muted-foreground font-mono mb-4 flex items-center gap-2">
                <Calendar size={12} className="text-accent-amber" />
                Upcoming Interviews
              </h3>

              <div className="space-y-3">
                {(() => {
                  const upcoming = metrics.upcomingInterviews.filter(a => mapRawStatusToBaseStage(a.status) === 'interview');
                  if (upcoming.length === 0) return <p className="text-center py-6 text-muted-foreground text-xs font-mono">No interviews scheduled</p>;
                  
                  return upcoming.map((interview) => (
                    <div key={interview.id} className="p-3 rounded-xl bg-card border border-card-border flex justify-between items-center">
                      <div className="space-y-1">
                        <h4 className="text-xs font-bold text-foreground">{interview.company}</h4>
                        <p className="text-xs text-muted-foreground font-medium">{interview.role} {interview.workMode ? `(${interview.workMode})` : ''}</p>
                      </div>
                      <span className="px-2.5 py-1 rounded bg-accent-amber/10 border border-accent-amber/20 text-accent-amber font-mono font-bold text-xs uppercase">
                        Scheduled
                      </span>
                    </div>
                  ));
                })()}
              </div>
            </div>
          </div>
        </div>
      </div>

    </motion.div>
  );
}
