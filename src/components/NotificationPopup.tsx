'use client';

import React, { useEffect, useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import { CheckCircle2, XCircle } from 'lucide-react';

export type NotificationType = 'success' | 'error';

export type NotificationProps = {
  isOpen: boolean;
  onClose: () => void;
  type: NotificationType;
  title: string;
  message?: string;
  updatedFields?: Record<string, unknown>;
  autoCloseMs?: number;
  position?: 'top' | 'center';
};

export default function NotificationPopup({
  isOpen,
  onClose,
  type,
  title,
  message,
  updatedFields,
  autoCloseMs = 1000,
  position = 'center'
}: NotificationProps) {
  const [isMobile, setIsMobile] = useState(false);

  // Safely check for mobile viewport on mount and resize
  useEffect(() => {
    const checkMobile = () => {
      const isMobileWidth = window.innerWidth < 768;
      const isMobileUA = /Mobi|Android|iPhone|iPad/i.test(navigator.userAgent);
      setIsMobile(isMobileWidth || isMobileUA);
    };
    checkMobile();
    window.addEventListener('resize', checkMobile);
    return () => window.removeEventListener('resize', checkMobile);
  }, []);

  // Auto-close toast on desktop only (mobiles require manual dismissal of the alert modal)
  useEffect(() => {
    if (isOpen && !isMobile && autoCloseMs > 0) {
      const timer = setTimeout(() => onClose(), autoCloseMs);
      return () => clearTimeout(timer);
    }
  }, [isOpen, isMobile, autoCloseMs, onClose]);

  if (!isOpen) return null;

  const isSuccess = type === 'success';

  return (
    <AnimatePresence>
      {isOpen && (
        <div className={`fixed inset-0 z-[200] flex justify-center p-4 pointer-events-none ${
          position === 'top' ? 'items-start pt-[100px]' : 'items-center'
        }`}>
          {/* Compact Alert Card */}
          <motion.div
            initial={{ scale: 0.9, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0.9, opacity: 0 }}
            transition={{ type: 'spring', damping: 22, stiffness: 300 }}
            className={[
              'relative w-full max-w-[280px] p-4 text-center flex flex-col items-center gap-3',
              'rounded-2xl border border-slate-200/60 dark:border-white/10 bg-white/95 dark:bg-zinc-900/95 shadow-[0_20px_50px_rgba(0,0,0,0.15)] dark:shadow-[0_20px_50px_rgba(0,0,0,0.4)] pointer-events-auto',
              isSuccess ? 'text-slate-800 dark:text-emerald-50' : 'text-slate-800 dark:text-rose-50',
            ].join(' ')}
          >
            <div className={`w-9 h-9 rounded-full flex items-center justify-center shrink-0 ${
              isSuccess 
                ? 'bg-emerald-500/10 text-emerald-500' 
                : 'bg-rose-500/10 text-rose-500'
            }`}>
              {isSuccess ? <CheckCircle2 size={18} /> : <XCircle size={18} />}
            </div>

            <div className="space-y-1 w-full">
              <h3 className="text-xs font-black font-mono uppercase tracking-wider text-slate-950 dark:text-foreground">
                {title}
              </h3>
              {message && (
                <p className="text-[11px] opacity-75 dark:opacity-70 leading-normal font-medium text-slate-600 dark:text-zinc-350 break-words">
                  {message}
                </p>
              )}
            </div>

            {updatedFields && Object.keys(updatedFields).length > 0 && (
              <div className="w-full max-h-24 overflow-y-auto border border-slate-200/80 dark:border-white/10 rounded-xl p-2 bg-slate-100/50 dark:bg-white/[0.02] text-left text-[9px] font-mono space-y-0.5 custom-scrollbar">
                <div className="font-bold text-slate-400 dark:text-zinc-500 uppercase text-[8px] mb-0.5 tracking-wider">Changed:</div>
                {Object.entries(updatedFields).map(([key, val]) => (
                  <div key={key} className="flex justify-between items-center py-0.5 border-b border-slate-200/50 dark:border-white/5 last:border-0">
                    <span className="text-slate-500 dark:text-slate-400 font-semibold">{key}:</span>
                    <span className="text-slate-950 dark:text-white font-bold max-w-[60%] truncate">{String(val || 'N/A')}</span>
                  </div>
                ))}
              </div>
            )}

            <button
              onClick={onClose}
              className="w-full py-1.5 bg-gradient-to-r from-blue-900 via-blue-600 to-sky-400 hover:opacity-90 active:scale-[0.98] text-white font-mono font-bold text-[10px] rounded-lg shadow-md border-0 transition-all cursor-pointer"
            >
              OK
            </button>
          </motion.div>
        </div>
      )}
    </AnimatePresence>
  );
}
