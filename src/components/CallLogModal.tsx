'use client';

import { useState } from 'react';
import { X, Phone, Calendar, Save, FileText, CheckCircle2 } from 'lucide-react';
import { NotionSchemaOptions } from '../lib/notion/client';
import LuffyLoader from './LuffyLoader';

type CallLogModalProps = {
  isOpen: boolean;
  onClose: () => void;
  recruiterName: string;
  recruiterPhone?: string;
  recruiterCompany?: string;
  recruiterEmail?: string;
  initialCallStatus?: string;
  initialReceivedCallOn?: string;
  initialNotes?: string;
  dbOptions?: NotionSchemaOptions;
  onSave: (data: { callStatus: string; receivedCallOn: string; notes?: string }) => Promise<void>;
};

export default function CallLogModal({
  isOpen,
  onClose,
  recruiterName,
  recruiterPhone = '',
  recruiterCompany = '',
  recruiterEmail = '',
  initialCallStatus = '',
  initialReceivedCallOn = '',
  initialNotes = '',
  dbOptions,
  onSave
}: CallLogModalProps) {
  const [callStatus, setCallStatus] = useState(initialCallStatus);
  const [receivedCallOn, setReceivedCallOn] = useState(initialReceivedCallOn);
  const [notes, setNotes] = useState(initialNotes);
  const [isSubmitting, setIsSubmitting] = useState(false);

  const [prevIsOpen, setPrevIsOpen] = useState(isOpen);
  if (isOpen !== prevIsOpen) {
    setPrevIsOpen(isOpen);
    if (isOpen) {
      setCallStatus(initialCallStatus);
      setReceivedCallOn(initialReceivedCallOn);
      setNotes(initialNotes);
    }
  }

  if (!isOpen) return null;

  // Fallback options if database options are empty or not loaded
  const callStatusOptions = dbOptions?.callStatuses && dbOptions.callStatuses.length > 0
    ? dbOptions.callStatuses
    : ['No Called', 'Dailed', 'In progress', 'Over WhatsApp', 'Done'];

  const cleanPhone = recruiterPhone.replace(/[^\d+]/g, '');

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setIsSubmitting(true);
    try {
      await onSave({
        callStatus,
        receivedCallOn,
        notes
      });
      onClose();
    } catch (err) {
      console.error('Failed to save call log:', err);
      alert('Failed to save call log changes.');
    } finally {
      setIsSubmitting(false);
    }
  };

  const handleSetToday = () => {
    setReceivedCallOn(new Date().toISOString().split('T')[0]);
  };

  return (
    <div className="fixed inset-0 flex items-start justify-center p-4 pt-[100px] pb-10 z-50 pointer-events-none">
      {/* Glassmorphic Backdrop overlay */}
      <div 
        className="absolute inset-0 bg-black/40 backdrop-blur-sm pointer-events-auto"
        onClick={onClose}
      />
      
      {/* Dialog container */}
      <div className="bg-card/95 backdrop-blur-3xl pointer-events-auto w-full max-w-md rounded-3xl overflow-hidden shadow-[0_40px_80px_-20px_rgba(0,0,0,0.5)] dark:shadow-[0_40px_80px_-20px_rgba(0,0,0,0.8)] border border-slate-200/60 dark:border-white/10 flex flex-col max-h-[calc(100vh-140px)] animate-slide-down relative z-10">
        
        {/* Header */}
        <div className="p-5 border-b border-card-border flex items-center justify-between bg-card">
          <div className="flex items-center gap-2">
            <div className="p-1.5 rounded-lg bg-emerald-500/10 text-emerald-500 border border-emerald-500/20">
              <Phone size={15} />
            </div>
            <h3 className="text-sm font-bold text-foreground font-mono uppercase tracking-wide">
              Call Log & Dialer
            </h3>
          </div>
          <button 
            onClick={onClose} 
            className="text-muted-foreground hover:text-foreground transition-colors border-0 bg-transparent cursor-pointer"
          >
            <X size={16} />
          </button>
        </div>

        {/* Form */}
        <form onSubmit={handleSubmit} className="p-5 space-y-5 overflow-y-auto flex-1 text-xs">
          
          {/* Recruiter Details Card */}
          <div className="bg-foreground/[0.02] border border-card-border/60 rounded-2xl p-4 space-y-2.5">
            <div>
              <span className="text-[9px] font-mono text-slate-500 uppercase tracking-wider block font-bold">Recruiter</span>
              <span className="text-sm font-bold text-foreground">{recruiterName}</span>
              {recruiterCompany && (
                <span className="text-xs text-muted-foreground ml-1.5">({recruiterCompany})</span>
              )}
            </div>
            {recruiterPhone && (
              <div className="flex items-center justify-between border-t border-card-border/40 pt-2.5 mt-1">
                <div>
                  <span className="text-[9px] font-mono text-slate-500 uppercase tracking-wider block font-bold">Contact Number</span>
                  <span className="text-xs font-mono text-foreground/80 font-semibold">{recruiterPhone}</span>
                </div>
                {/* Dial Button */}
                <a 
                  href={`tel:${cleanPhone}`}
                  className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-emerald-500/10 border border-emerald-500/20 text-emerald-500 font-mono font-bold text-[10px] hover:bg-emerald-500/20 transition-all select-none"
                  title="Call Phone Dialer"
                >
                  <Phone size={10} />
                  DIAL NUMBER
                </a>
              </div>
            )}
            {recruiterEmail && (
              <div className="border-t border-card-border/40 pt-2">
                <span className="text-[9px] font-mono text-slate-500 uppercase tracking-wider block font-bold">Email Address</span>
                <span className="text-xs font-mono text-muted-foreground truncate block">{recruiterEmail}</span>
              </div>
            )}
          </div>

          {/* Call Status Picker */}
          <div className="space-y-2">
            <label className="font-mono text-xs text-muted-foreground font-bold uppercase tracking-wider block">
              Call Status
            </label>
            <div className="grid grid-cols-2 gap-2">
              {callStatusOptions.map(option => {
                const isSelected = callStatus === option;
                return (
                  <button
                    key={option}
                    type="button"
                    onClick={() => setCallStatus(option)}
                    className={`px-3 py-2 rounded-xl border font-semibold font-mono text-left transition-all flex items-center justify-between ${
                      isSelected
                        ? 'bg-emerald-500/10 text-emerald-500 border-emerald-500/40 shadow-sm'
                        : 'bg-foreground/[0.01] hover:bg-foreground/[0.03] border-card-border/80 text-foreground/80'
                    }`}
                  >
                    <span className="truncate">{option}</span>
                    {isSelected && <CheckCircle2 size={12} className="shrink-0 text-emerald-500" />}
                  </button>
                );
              })}
            </div>
          </div>

          {/* Received Call On Date */}
          <div className="space-y-1.5">
            <label className="font-mono text-xs text-muted-foreground font-bold uppercase tracking-wider block">
              Call Date (Received / Dialed)
            </label>
            <div className="flex gap-2">
              <div className="relative flex-1">
                <Calendar size={13} className="absolute left-3.5 top-1/2 -translate-y-1/2 text-muted-foreground/60" />
                <input
                  type="date"
                  max={new Date().toISOString().split('T')[0]}
                  value={receivedCallOn}
                  onChange={e => setReceivedCallOn(e.target.value)}
                  className="w-full pl-10 pr-4 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-emerald-500/10 focus:border-emerald-500 transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50 font-mono"
                />
              </div>
              <button
                type="button"
                onClick={handleSetToday}
                className="px-4 py-2 border border-card-border hover:bg-card/50 bg-card rounded-xl font-semibold font-mono text-xs text-foreground transition-all cursor-pointer select-none"
              >
                Today
              </button>
            </div>
          </div>

          {/* Call/Recruiter Notes */}
          <div className="space-y-1.5">
            <label className="font-mono text-xs text-muted-foreground font-bold uppercase tracking-wider block flex items-center gap-1.5">
              <FileText size={12} />
              Call Notes / Feedback
            </label>
            <textarea
              value={notes}
              onChange={e => setNotes(e.target.value)}
              placeholder="What was discussed? Next steps? (Updates the opportunity notes)"
              rows={3}
              className="w-full px-3.5 py-2.5 bg-foreground/[0.02] border border-card-border/60 hover:border-card-border rounded-xl focus:outline-none focus:ring-4 focus:ring-emerald-500/10 focus:border-emerald-500 transition-all duration-200 text-[13px] font-semibold text-foreground placeholder:text-muted-foreground/50 resize-y min-h-[72px]"
            />
          </div>

          {/* Footer Submit Buttons */}
          <div className="p-3 border-t border-card-border flex justify-end gap-3 pt-5 bg-card -mx-5 -mb-5 mt-6 rounded-b-2xl">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2 border border-card-border hover:bg-card/50 bg-card rounded-lg font-semibold font-mono text-xs text-foreground transition-all cursor-pointer"
            >
              Cancel
            </button>
            <button
              type="submit"
              disabled={isSubmitting}
              className="px-4 py-2 bg-gradient-to-r from-emerald-600 to-teal-500 hover:opacity-90 disabled:opacity-50 text-white rounded-lg border-0 font-semibold font-mono text-xs transition-all flex items-center gap-1.5 cursor-pointer shadow-sm"
            >
              {isSubmitting ? (
                <>
                  <LuffyLoader size={12} />
                  Saving...
                </>
              ) : (
                <>
                  <Save size={12} />
                  Save Logs
                </>
              )}
            </button>
          </div>

        </form>

      </div>
    </div>
  );
}
