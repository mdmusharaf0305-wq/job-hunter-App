'use client';

import { useState, useEffect } from 'react';
import { createPortal } from 'react-dom';
import { Check } from 'lucide-react';

interface Option {
  value: string;
  label: string;
}

interface CustomSelectProps {
  value: string;
  onChange: (value: string) => void;
  options: (string | Option)[];
  placeholder?: string;
  className?: string;
  disabled?: boolean;
  required?: boolean;
  label?: string;
}

export default function CustomSelect({
  value,
  onChange,
  options,
  placeholder,
  className = '',
  disabled = false,
  required = false,
  label = 'Option',
}: CustomSelectProps) {
  const [isOpen, setIsOpen] = useState(false);
  const [mounted, setMounted] = useState(false);

  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setMounted(true);
    return () => setMounted(false);
  }, []);

  // Normalize options to { value, label }
  const formattedOptions = options.map((opt) => {
    if (typeof opt === 'string') {
      return { value: opt, label: opt };
    }
    return opt;
  });

  // Include placeholder if provided as the first option
  const finalOptions = placeholder
    ? [{ value: '', label: placeholder }, ...formattedOptions]
    : formattedOptions;

  // Find the label of the currently selected option
  const selectedOption = finalOptions.find((opt) => opt.value === value);
  const selectedLabel = selectedOption ? selectedOption.label : value;

  // Block body scroll when the drawer is open on mobile
  useEffect(() => {
    if (isOpen) {
      document.body.style.overflow = 'hidden';
    } else {
      document.body.style.overflow = '';
    }
    return () => {
      document.body.style.overflow = '';
    };
  }, [isOpen]);

  return (
    <>
      {/* Desktop Standard Select — hidden on mobile */}
      <select
        value={value}
        onChange={(e) => onChange(e.target.value)}
        disabled={disabled}
        required={required}
        className={`hidden sm:inline-block ${className}`}
      >
        {placeholder && <option value="">{placeholder}</option>}
        {formattedOptions.map((opt) => (
          <option key={opt.value} value={opt.value}>
            {opt.label}
          </option>
        ))}
      </select>

      {/* Mobile: Custom trigger button + bottom-sheet */}
      <div className={`sm:hidden relative inline-block ${className.includes('w-full') ? 'w-full' : 'w-auto'}`}>
        <button
          type="button"
          disabled={disabled}
          onClick={(e) => {
            e.stopPropagation();
            setIsOpen(true);
          }}
          className={`flex items-center justify-between text-left select-none outline-none ${className} ${
            className.includes('w-full') ? 'w-full' : 'w-auto'
          } ${
            disabled ? 'opacity-50 cursor-not-allowed' : 'cursor-pointer'
          }`}
        >
          <span className="truncate leading-none">{selectedLabel || placeholder || 'Select…'}</span>
        </button>

        {/* Backdrop & Floating Card */}
        {isOpen && mounted && typeof document !== 'undefined' && createPortal(
          <div className="fixed inset-0 z-[200] flex items-center justify-center p-4 pointer-events-none">
            {/* Scrim - completely transparent to remove blurred/dark backdrop */}
            <div
              className="fixed inset-0 bg-transparent transition-opacity duration-200 pointer-events-auto"
              onClick={(e) => {
                e.stopPropagation();
                setIsOpen(false);
              }}
            />

            {/* Floating Options Card */}
            <div className="relative w-full max-w-[280px] max-h-[60vh] bg-gradient-to-b from-white via-slate-50 to-slate-100 dark:from-[#111113] dark:via-[#0d0d0f] dark:to-[#090909] border border-slate-200/80 dark:border-white/10 rounded-2xl shadow-2xl overflow-hidden flex flex-col z-50 animate-slide-down pointer-events-auto">
              {/* Header */}
              {label && (
                <div className="px-5 pb-3 pt-4 shrink-0 border-b border-slate-200/60 dark:border-white/6">
                  <p className="text-[9px] font-mono font-bold text-muted-foreground/70 uppercase tracking-[0.15em] text-center">
                    {label}
                  </p>
                </div>
              )}

              {/* Options List */}
              <div className="overflow-y-auto flex-1 px-4 py-3 space-y-1.5 animate-fade-in">
                {finalOptions.map((opt) => {
                  const isSelected = opt.value === value;
                  return (
                    <button
                      key={opt.value}
                      type="button"
                      onClick={(e) => {
                        e.stopPropagation();
                        onChange(opt.value);
                        setIsOpen(false);
                      }}
                      className={`w-full px-4 h-[42px] flex items-center justify-between rounded-xl text-[12px] font-semibold text-foreground transition-all duration-150 active:scale-[0.985] border ${
                        isSelected
                          ? 'bg-gradient-to-r from-cyan-500/12 to-cyan-400/5 border-cyan-500/40 text-cyan-600 dark:text-cyan-400 font-bold shadow-sm shadow-cyan-500/5'
                          : 'bg-white/50 border-slate-200/50 dark:bg-white/[0.025] dark:border-white/6 hover:bg-white/90 hover:border-slate-300/60 dark:hover:bg-white/[0.05]'
                      }`}
                    >
                      <span className="truncate">{opt.label}</span>
                      {isSelected && (
                        <span className="shrink-0 ml-2 w-4.5 h-4.5 flex items-center justify-center rounded-full bg-cyan-500 dark:bg-cyan-400">
                          <Check size={9} strokeWidth={3} className="text-white" />
                        </span>
                      )}
                    </button>
                  );
                })}
              </div>

              {/* Cancel */}
              <div className="px-4 pb-4 pt-2 shrink-0 border-t border-slate-200/40 dark:border-white/5">
                <button
                  type="button"
                  onClick={(e) => {
                    e.stopPropagation();
                    setIsOpen(false);
                  }}
                  className="w-full h-11 bg-slate-100/80 hover:bg-slate-200/80 dark:bg-zinc-800/60 dark:hover:bg-zinc-700/60 text-foreground font-semibold rounded-xl text-[11px] font-mono tracking-widest uppercase transition-all duration-150"
                >
                  CANCEL
                </button>
              </div>
            </div>
          </div>,
          document.body
        )}
      </div>
    </>
  );
}
