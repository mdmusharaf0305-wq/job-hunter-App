'use client';

import { useState, useEffect, useRef } from 'react';
import { PlusCircle, X, ArrowRight, Edit } from 'lucide-react';
import { JobApplication, ApplicationStage } from '../types';
import { NotionSchemaOptions, mapNotionStatusToFormulaStatus } from '../lib/notion/client';
import LuffyLoader from './LuffyLoader';
import CustomSelect from './CustomSelect';

type ApplicationModalProps = {
  isOpen: boolean;
  onClose: () => void;
  onSave: (data: Partial<JobApplication>) => Promise<void>;
  dbOptions?: NotionSchemaOptions;
  application?: JobApplication | null;
  defaultType?: 'inbound' | 'outbound';
};

export default function ApplicationModal({ 
  isOpen, 
  onClose, 
  onSave, 
  dbOptions, 
  application,
  defaultType = 'inbound'
}: ApplicationModalProps) {
  const [isSubmitting, setIsSubmitting] = useState(false);
  
  // Shared form fields
  const [role, setRole] = useState('');
  const [company, setCompany] = useState('');
  const [client, setClient] = useState('');
  const [type, setType] = useState<'inbound' | 'outbound'>(defaultType);
  const [priority, setPriority] = useState<'High' | 'Medium' | 'Low'>('Medium');
  const [workMode, setWorkMode] = useState('Hybrid');
  const [location, setLocation] = useState('');
  const [recruiterName, setRecruiterName] = useState('');
  const [recruiterPhone, setRecruiterPhone] = useState('');
  const [recruiterEmail, setRecruiterEmail] = useState('');
  const [recruiterLinkedin, setRecruiterLinkedin] = useState('');
  const [lastContactedDate, setLastContactedDate] = useState('');
  const [interviewRounds, setInterviewRounds] = useState('');
  const [interviewMode, setInterviewMode] = useState('');
  const [roundPlan, setRoundPlan] = useState('');
  const [salary, setSalary] = useState('');
  const [status, setStatus] = useState<ApplicationStage>('sourcing');
  const [employmentType, setEmploymentType] = useState('');
  const [companyType, setCompanyType] = useState('');
  const [companySize, setCompanySize] = useState('');
  const [receivedCallOn, setReceivedCallOn] = useState('');
  const [callStatus, setCallStatus] = useState('');
  const [followupChannel, setFollowupChannel] = useState('');
  const [notes, setNotes] = useState('');
  
  // Custom Client Option states
  const [isCustomClient, setIsCustomClient] = useState(false);
  const [customClient, setCustomClient] = useState('');

  // Outbound specific
  const [resumeSent, setResumeSent] = useState(false);
  const [resumeSentOn, setResumeSentOn] = useState('');

  // Synchronize state when editing
  useEffect(() => {
    if (application && isOpen) {
      setRole(application.role || '');
      setCompany(application.company || '');
      
      // Handle custom client detection
      const existingClient = application.client || '';
      const isKnown = dbOptions?.clients?.includes(existingClient);
      if (existingClient && !isKnown && existingClient !== 'Direct') {
        setClient('create_new_client');
        setIsCustomClient(true);
        setCustomClient(existingClient);
      } else {
        setClient(existingClient);
        setIsCustomClient(false);
        setCustomClient('');
      }

      setType(application.type || defaultType);
      setPriority(application.priority || 'Medium');
      setWorkMode(application.workMode || 'Hybrid');
      setLocation(application.location || '');
      setRecruiterName(application.recruiterName || '');
      setRecruiterPhone(application.recruiterPhone || '');
      setRecruiterEmail(application.recruiterEmail || '');
      setRecruiterLinkedin(application.recruiterLinkedin || '');
      setLastContactedDate(application.lastContactedDate || '');
      setInterviewRounds(application.interviewRounds || '');
      setInterviewMode(application.interviewMode || '');
      setRoundPlan(application.roundPlan || '');
      setSalary(application.salary || '');
      setStatus(application.status || 'sourcing');
      setEmploymentType(application.employmentType || '');
      setCompanyType(application.companyType || '');
      setCompanySize(application.companySize || '');
      setReceivedCallOn(application.receivedCallOn || '');
      setCallStatus(application.callStatus || '');
      setResumeSent(application.resumeSent || false);
      setResumeSentOn(application.resumeSentOn || '');
      setFollowupChannel(application.followupChannel || '');
      setNotes(application.notes || '');
    } else if (!application && isOpen) {
      // Reset form on new open
      setRole(''); setCompany(''); setClient(''); setType(defaultType);
      setPriority('Medium'); setWorkMode('Hybrid'); setLocation('');
      setRecruiterName(''); setRecruiterPhone(''); setRecruiterEmail(''); setRecruiterLinkedin(''); setLastContactedDate('');
      setInterviewRounds(''); setInterviewMode(''); setRoundPlan(''); setSalary(''); setStatus('sourcing');
      setEmploymentType(''); setCompanyType(''); setCompanySize(''); setReceivedCallOn('');
      setCallStatus(''); setResumeSent(false); setResumeSentOn('');
      setFollowupChannel(''); setNotes('');
      setIsCustomClient(false); setCustomClient('');
    }
  }, [isOpen, application, defaultType, dbOptions?.clients]);

  const isDirty = () => {
    if (application) {
      return (
        role !== (application.role || '') ||
        company !== (application.company || '') ||
        client !== (application.client || '') ||
        type !== (application.type || defaultType) ||
        priority !== (application.priority || 'Medium') ||
        workMode !== (application.workMode || 'Hybrid') ||
        location !== (application.location || '') ||
        recruiterName !== (application.recruiterName || '') ||
        recruiterPhone !== (application.recruiterPhone || '') ||
        recruiterEmail !== (application.recruiterEmail || '') ||
        recruiterLinkedin !== (application.recruiterLinkedin || '') ||
        lastContactedDate !== (application.lastContactedDate || '') ||
        interviewRounds !== (application.interviewRounds || '') ||
        interviewMode !== (application.interviewMode || '') ||
        roundPlan !== (application.roundPlan || '') ||
        salary !== (application.salary || '') ||
        status !== (application.status || 'sourcing') ||
        employmentType !== (application.employmentType || '') ||
        companyType !== (application.companyType || '') ||
        companySize !== (application.companySize || '') ||
        receivedCallOn !== (application.receivedCallOn || '') ||
        callStatus !== (application.callStatus || '') ||
        followupChannel !== (application.followupChannel || '') ||
        notes !== (application.notes || '') ||
        resumeSent !== (application.resumeSent || false) ||
        resumeSentOn !== (application.resumeSentOn || '')
      );
    } else {
      return (
        role !== '' ||
        company !== '' ||
        client !== '' ||
        type !== defaultType ||
        priority !== 'Medium' ||
        workMode !== 'Hybrid' ||
        location !== '' ||
        recruiterName !== '' ||
        recruiterPhone !== '' ||
        recruiterEmail !== '' ||
        recruiterLinkedin !== '' ||
        lastContactedDate !== '' ||
        interviewRounds !== '' ||
        interviewMode !== '' ||
        roundPlan !== '' ||
        salary !== '' ||
        status !== 'sourcing' ||
        employmentType !== '' ||
        companyType !== '' ||
        companySize !== '' ||
        receivedCallOn !== '' ||
        callStatus !== '' ||
        followupChannel !== '' ||
        notes !== '' ||
        resumeSent !== false ||
        resumeSentOn !== ''
      );
    }
  };

  const handleModalClose = () => {
    if (isDirty()) {
      if (window.confirm('You have unsaved changes. Are you sure you want to discard them?')) {
        onClose();
      }
    } else {
      onClose();
    }
  };

  const handleModalCloseRef = useRef(handleModalClose);
  useEffect(() => {
    handleModalCloseRef.current = handleModalClose;
  });

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        handleModalCloseRef.current();
      }
    };
    if (isOpen) {
      window.addEventListener('keydown', handleKeyDown);
    }
    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, [isOpen]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!role || !company) return;
    
    setIsSubmitting(true);
    try {
      const finalClient = isCustomClient ? customClient : client;
      await onSave({
        role, company, client: finalClient, type, priority, workMode, location, recruiterName,
        recruiterPhone, recruiterEmail, recruiterLinkedin, interviewRounds, interviewMode, roundPlan,
        salary, status, employmentType, companyType, companySize, receivedCallOn, callStatus, resumeSent, resumeSentOn, lastContactedDate, followupChannel, notes
      });
      onClose();
    } catch (error) {
      console.error('Failed to save application', error);
      throw error;
    } finally {
      setIsSubmitting(false);
    }
  };

  if (!isOpen) return null;

  const isEdit = !!application;

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center p-4 pt-[60px] pb-10 overflow-y-auto">
      {/* Backdrop Scrim */}
      <div 
        className="fixed inset-0 bg-black/50 transition-opacity duration-300 cursor-pointer"
        onClick={handleModalClose}
      />
      {/* Modal Dialog Card */}
      <div className="relative bg-card w-full max-w-2xl rounded-3xl overflow-hidden shadow-[0_40px_80px_-20px_rgba(0,0,0,0.3)] dark:shadow-[0_40px_80px_-20px_rgba(0,0,0,0.7)] border border-slate-200/60 dark:border-white/10 flex flex-col max-h-[calc(100vh-100px)] animate-slide-down z-10">
        <div className="p-5 border-b border-card-border flex items-center justify-between bg-card shrink-0">
          <div className="flex items-center gap-2">
            {isEdit ? <Edit size={16} className="text-accent-blue" /> : <PlusCircle size={16} className="text-accent-blue animate-pulse" />}
            <h3 className="text-sm font-bold text-foreground font-mono uppercase tracking-wide">
              {isEdit ? 'Edit Application' : `New ${type} Opportunity`}
            </h3>
          </div>
          <button onClick={handleModalClose} className="text-muted-foreground hover:text-foreground transition-colors border-0 bg-transparent cursor-pointer">
            <X size={16} />
          </button>
        </div>

        <form onSubmit={handleSubmit} className="p-5 space-y-5 overflow-y-auto flex-1 text-xs custom-scrollbar">
          <div className="grid grid-cols-2 gap-4">
            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Job Role *</label>
              <CustomSelect
                required
                value={role}
                onChange={setRole}
                options={dbOptions?.roles || []}
                placeholder="Select Role"
                label="Role"
                className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
              />
            </div>
            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Company *</label>
              <input type="text" required placeholder="e.g. Innova Solutions" value={company} onChange={e => setCompany(e.target.value)} className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50" />
            </div>

            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Type</label>
              <CustomSelect
                value={type}
                onChange={(val) => setType(val as 'inbound' | 'outbound')}
                options={[
                  { value: 'inbound', label: '📥 Inbound' },
                  { value: 'outbound', label: '📤 Outbound' }
                ]}
                label="Type"
                className="w-full px-4 py-2 bg-card border border-card-border/60 rounded-full text-[11px] font-mono font-bold text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center h-[38px]"
              />
            </div>
            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Status</label>
              <CustomSelect
                value={status}
                onChange={(val) => setStatus(val as ApplicationStage)}
                options={dbOptions?.statuses || []}
                placeholder="Select Status"
                label="Status"
                className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
              />
            </div>

            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Employment Type</label>
              <CustomSelect
                value={employmentType}
                onChange={setEmploymentType}
                options={dbOptions?.employmentTypes || []}
                placeholder="Select Employment Type"
                label="Employment Type"
                className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
              />
            </div>
            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Priority</label>
              <CustomSelect
                value={priority}
                onChange={(val) => setPriority(val as 'High' | 'Medium' | 'Low')}
                options={[
                  { value: 'High', label: '🔴 High' },
                  { value: 'Medium', label: '🟡 Medium' },
                  { value: 'Low', label: '🔵 Low' }
                ]}
                label="Priority"
                className="w-full px-4 py-2 bg-card border border-card-border/60 rounded-full text-[11px] font-mono font-bold text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center h-[38px]"
              />
            </div>

            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Client (End Client)</label>
              <CustomSelect
                value={isCustomClient ? 'create_new_client' : client}
                onChange={(val) => {
                  if (val === 'create_new_client') {
                    setIsCustomClient(true);
                  } else {
                    setIsCustomClient(false);
                    setClient(val);
                  }
                }}
                options={[
                  ...(dbOptions?.clients || []).map(c => ({ value: c, label: c })),
                  { value: 'create_new_client', label: '+ Add Custom Client...' }
                ]}
                placeholder="Select Client"
                label="Client"
                className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
              />
              {isCustomClient && (
                <div className="mt-2 flex gap-2 animate-slide-down">
                  <input
                    type="text"
                    required
                    placeholder="Enter custom client name..."
                    value={customClient}
                    onChange={e => setCustomClient(e.target.value)}
                    className="flex-1 px-3 py-2 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
                  />
                  <button
                    type="button"
                    onClick={() => {
                      setIsCustomClient(false);
                      setCustomClient('');
                      setClient('');
                    }}
                    className="px-2.5 py-1.5 border border-card-border rounded-xl hover:bg-card/50 text-muted-foreground hover:text-foreground text-xs font-mono transition-all"
                  >
                    Cancel
                  </button>
                </div>
              )}
            </div>
            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Work Mode</label>
              <CustomSelect
                value={workMode}
                onChange={setWorkMode}
                options={[
                  { value: 'Remote', label: '🏡 Remote' },
                  { value: 'Hybrid', label: '🏢 Hybrid' },
                  { value: 'Onsite', label: '📍 Onsite' }
                ]}
                label="Work Mode"
                className="w-full px-4 py-2 bg-card border border-card-border/60 rounded-full text-[11px] font-mono font-bold text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center h-[38px]"
              />
            </div>

            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Salary</label>
              <CustomSelect
                value={salary}
                onChange={setSalary}
                options={dbOptions?.salaries || []}
                placeholder="Select Salary"
                label="Salary"
                className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
              />
            </div>
            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Location</label>
              <CustomSelect
                value={location}
                onChange={setLocation}
                options={dbOptions?.locations || []}
                placeholder="Select Location"
                label="Location"
                className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
              />
            </div>

            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Company Type</label>
              <CustomSelect
                value={companyType}
                onChange={setCompanyType}
                options={dbOptions?.companyTypes || []}
                placeholder="Select Type"
                label="Company Type"
                className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
              />
            </div>
            <div className="space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Company Size</label>
              <CustomSelect
                value={companySize}
                onChange={setCompanySize}
                options={dbOptions?.companySizes || []}
                placeholder="Select Size"
                label="Company Size"
                className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
              />
            </div>
          </div>

          <div className="pt-1">
            <p className="text-[9px] font-mono font-bold uppercase tracking-[0.15em] text-muted-foreground/50 mb-3 flex items-center gap-2">
              <span className="flex-1 h-px bg-card-border/60" />
              Interview Details
              <span className="flex-1 h-px bg-card-border/60" />
            </p>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1">
                <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Total Rounds</label>
                <CustomSelect
                  value={interviewRounds}
                  onChange={setInterviewRounds}
                  options={dbOptions?.totalRounds || []}
                  placeholder="Select Rounds"
                  label="Total Rounds"
                  className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
                />
              </div>
              <div className="space-y-1">
                <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Interview Mode</label>
                <CustomSelect
                  value={interviewMode}
                  onChange={setInterviewMode}
                  options={dbOptions?.interviewModes || []}
                  placeholder="Select Mode"
                  label="Interview Mode"
                  className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
                />
              </div>
            </div>
            <div className="mt-4 space-y-1">
              <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Round Plan</label>
              <div className="border border-card-border rounded-xl bg-background p-3 max-h-48 overflow-y-auto space-y-2 grid grid-cols-2">
                {dbOptions?.roundPlans?.map(rp => (
                  <label key={rp} className="flex items-center gap-2 text-[13px] font-mono cursor-pointer hover:bg-card p-1 rounded transition-colors">
                    <input 
                      type="checkbox" 
                      checked={roundPlan.split(',').map(r => r.trim()).includes(rp)}
                      onChange={(e) => {
                        const selected = new Set(roundPlan.split(',').map(r => r.trim()).filter(Boolean));
                        if (e.target.checked) selected.add(rp);
                        else selected.delete(rp);
                        setRoundPlan(Array.from(selected).join(', '));
                      }}
                      className="rounded border-card-border text-accent-blue focus:ring-accent-blue w-3.5 h-3.5 cursor-pointer"
                    />
                    <span className="truncate">{rp}</span>
                  </label>
                ))}
              </div>
            </div>
          </div>

          <div className="pt-1">
            <p className="text-[9px] font-mono font-bold uppercase tracking-[0.15em] text-muted-foreground/50 mb-3 flex items-center gap-2">
              <span className="flex-1 h-px bg-card-border/60" />
              Recruiter Details
              <span className="flex-1 h-px bg-card-border/60" />
            </p>
            <div className="grid grid-cols-2 gap-4">
              <div className="space-y-1">
                <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Recruiter Name</label>
                <input type="text" value={recruiterName} onChange={e => setRecruiterName(e.target.value)} className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50" />
              </div>
              <div className="space-y-1">
                <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Recruiter Number</label>
                <input type="text" value={recruiterPhone} onChange={e => setRecruiterPhone(e.target.value)} className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50" />
              </div>

              <div className="space-y-1">
                <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Recruiter Mail</label>
                <input type="email" value={recruiterEmail} onChange={e => setRecruiterEmail(e.target.value)} className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50" />
              </div>
              <div className="space-y-1">
                <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Last Contacted</label>
                <input type="date" max={new Date().toISOString().split('T')[0]} value={lastContactedDate} onChange={e => setLastContactedDate(e.target.value)} className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50" />
              </div>

              <div className="space-y-1">
                <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Follow-up Channel</label>
                <CustomSelect
                  value={followupChannel}
                  onChange={setFollowupChannel}
                  options={dbOptions?.followupChannels || []}
                  placeholder="Select Channel"
                  label="Follow-up Channel"
                  className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50"
                />
              </div>

              {/* Dynamic Tracking Field Group inside same grid beside follow-up channel */}
              {type === 'inbound' && (
                <div className="space-y-1">
                  <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">Received Call On</label>
                  <input type="date" max={new Date().toISOString().split('T')[0]} value={receivedCallOn} onChange={e => setReceivedCallOn(e.target.value)} className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50" />
                </div>
              )}
              {type === 'outbound' && (
                <div className="space-y-2 bg-slate-50/50 dark:bg-zinc-800/10 p-3 rounded-2xl border border-card-border/60 self-start">
                  <div className="flex items-center gap-2">
                    <input type="checkbox" id="modalResumeSent" checked={resumeSent} onChange={e => setResumeSent(e.target.checked)} className="rounded border-card-border text-accent-blue focus:ring-accent-blue w-3.5 h-3.5 cursor-pointer" />
                    <label htmlFor="modalResumeSent" className="font-mono text-[10px] text-muted-foreground font-bold uppercase tracking-wider cursor-pointer select-none">Resume Sent</label>
                  </div>
                  {resumeSent && (
                    <div className="space-y-1 animate-slide-down">
                      <label className="font-mono text-[8px] text-muted-foreground font-bold uppercase tracking-wider block mb-0.5">Resume Sent On</label>
                      <input type="date" max={new Date().toISOString().split('T')[0]} value={resumeSentOn} onChange={e => setResumeSentOn(e.target.value)} className="w-full px-2.5 py-1.5 bg-card border border-card-border/60 hover:border-card-border rounded-lg focus:outline-none text-[11px] font-semibold text-foreground" />
                    </div>
                  )}
                  <div className="space-y-1">
                    <label className="font-mono text-[8px] text-muted-foreground font-bold uppercase tracking-wider block mb-0.5">Call Status</label>
                    <CustomSelect
                      value={callStatus}
                      onChange={setCallStatus}
                      options={dbOptions?.callStatuses || []}
                      placeholder="Select Status"
                      label="Call Status"
                      className="w-full px-2.5 py-1.5 bg-card border border-card-border/60 hover:border-card-border rounded-lg focus:outline-none text-[11px] font-semibold text-foreground text-center"
                    />
                  </div>
                </div>
              )}
            </div>
          </div>

          <div className="space-y-1">
            <label className="font-mono text-[9px] text-muted-foreground font-bold uppercase tracking-wider whitespace-nowrap truncate block mb-1">📚 Notes</label>
            <textarea 
              value={notes} 
              onChange={e => setNotes(e.target.value)} 
              rows={3}
              placeholder="Add any additional notes here..."
              className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-accent-blue/10 focus:border-accent-blue transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50 resize-y" 
            />
          </div>

          <div className="p-3 border-t border-card-border flex justify-end gap-3 pt-5 bg-card -mx-5 -mb-5 mt-6 rounded-b-2xl shrink-0">
            <button type="button" onClick={handleModalClose} className="px-4 py-2 border border-card-border hover:bg-card/50 bg-card rounded-lg font-semibold font-mono text-xs text-foreground transition-all cursor-pointer">
              Cancel
            </button>
            <button type="submit" disabled={isSubmitting} className="px-4 py-2 bg-gradient-to-r from-blue-900 via-blue-600 to-sky-400 hover:opacity-90 disabled:opacity-50 text-white rounded-lg border-0 font-semibold font-mono text-xs transition-all flex items-center gap-1.5 cursor-pointer shadow-sm">
              {isSubmitting ? <><LuffyLoader size={12} /> Saving...</> : <>{isEdit ? 'Save Changes' : `Create ${type} Job`} <ArrowRight size={12} /></>}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
