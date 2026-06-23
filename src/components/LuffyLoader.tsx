'use client';

import React, { useEffect, useState } from 'react';

type LuffyLoaderProps = {
  size?: number;
  className?: string;
};

export default function LuffyLoader({ size = 16, className = '' }: LuffyLoaderProps) {
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    let current = 0;
    const interval = setInterval(() => {
      if (current < 30) {
        // Fast start
        current += Math.random() * 8 + 4;
      } else if (current < 70) {
        // Medium speed
        current += Math.random() * 3 + 1;
      } else if (current < 90) {
        // Slowing down
        current += Math.random() * 1 + 0.3;
      } else if (current < 98) {
        // Crawling
        current += Math.random() * 0.2 + 0.05;
      } else {
        // Asymptotically approaching 99%
        current += (99 - current) * 0.1;
      }
      setProgress(Math.min(Number(current.toFixed(1)), 99));
    }, 80);

    return () => clearInterval(interval);
  }, []);

  const isFullPage = size >= 32;

  if (isFullPage) {
    return (
      <div 
        className={`w-full max-w-sm mx-auto flex flex-col items-center justify-center gap-6 p-6 rounded-2xl border border-slate-200/80 dark:border-white/10 shadow-[0_25px_60px_-15px_rgba(0,0,0,0.15),inset_0_1.5px_0_rgba(255,255,255,0.9)] dark:shadow-[0_30px_70px_-15px_rgba(0,0,0,0.7),inset_0_1px_0_rgba(255,255,255,0.05)] relative overflow-hidden group bg-gradient-to-br from-white via-slate-50/95 to-slate-100/95 dark:bg-gradient-to-br dark:from-card dark:to-neutral-900 transition-all duration-300 transform hover:scale-[1.01] hover:perspective(1000px) hover:rotateX(1deg) ${className}`}
        style={{ transform: 'perspective(1000px) rotateX(0.5deg) rotateY(-0.5deg)' }}
      >
        {/* Animated Background Pulse Glow */}
        <div className="absolute -inset-10 bg-gradient-to-r from-blue-600/10 via-indigo-500/10 to-sky-400/10 rounded-full blur-2xl group-hover:scale-110 transition-transform duration-1000 animate-pulse pointer-events-none" />

        {/* Unique Animated Walking Gentleman Icon */}
        <div className="relative z-10 flex items-center justify-center bg-[#EFFFFA] dark:bg-slate-950/80 px-6 py-2.5 rounded-full border border-slate-300/40 dark:border-slate-800/80 shadow-[inset_0_2px_5px_rgba(0,0,0,0.06)] dark:shadow-[inset_0_2px_8px_rgba(0,0,0,0.5)]">
          <div className="relative w-[120px] h-[36px] overflow-hidden flex items-center justify-center">
            <style dangerouslySetInnerHTML={{ __html: `
              @keyframes walkCycle {
                0% { transform: translateX(-40px); opacity: 0; }
                15% { opacity: 1; }
                85% { opacity: 1; }
                100% { transform: translateX(40px); opacity: 0; }
              }
              @keyframes legSwing1 {
                0%, 100% { transform: rotate(-22deg); }
                50% { transform: rotate(22deg); }
              }
              @keyframes legSwing2 {
                0%, 100% { transform: rotate(22deg); }
                50% { transform: rotate(-22deg); }
              }
              @keyframes armSwing {
                0%, 100% { transform: rotate(-12deg); }
                50% { transform: rotate(12deg); }
              }
              @keyframes headBob {
                0%, 50%, 100% { transform: translateY(0); }
                25%, 75% { transform: translateY(-1px); }
              }
              .animate-walk {
                animation: walkCycle 3s linear infinite;
              }
              .animate-leg1 {
                animation: legSwing1 0.75s ease-in-out infinite;
              }
              .animate-leg2 {
                animation: legSwing2 0.75s ease-in-out infinite;
              }
              .animate-arm {
                animation: armSwing 0.75s ease-in-out infinite;
              }
              .animate-bob {
                animation: headBob 0.375s ease-in-out infinite;
              }
            ` }} />
            <svg width="120" height="36" viewBox="0 13 120 36" fill="none" xmlns="http://www.w3.org/2000/svg">
              {/* Recessed capsule background glow */}
              <rect x="0" y="13" width="120" height="36" rx="18" fill="url(#capsuleGlow)" />
              <line x1="10" y1="48" x2="110" y2="48" stroke="url(#groundGrad)" strokeWidth="1.5" strokeDasharray="3 3" strokeLinecap="round" />
              <g className="animate-walk" filter="url(#gentShadow)">
                {/* Head */}
                <circle cx="32" cy="18" r="4" fill="url(#bodyGrad)" className="animate-bob" style={{ transformOrigin: '32px 18px' }} />
                {/* Torso */}
                <path d="M29 23C29 21.8954 29.8954 21 31 21H33C34.1046 21 35 21.8954 35 23V34C35 34.5523 34.5523 35 34 35H30C29.4477 35 29 34.5523 29 34V23Z" fill="url(#bodyGrad)" />
                {/* Left Leg */}
                <line x1="30.5" y1="34" x2="26.5" y2="46" stroke="url(#bodyGrad)" strokeWidth="2.5" strokeLinecap="round" className="animate-leg1" style={{ transformOrigin: '30.5px 34px' }} />
                {/* Right Leg */}
                <line x1="33.5" y1="34" x2="37.5" y2="46" stroke="url(#bodyGrad)" strokeWidth="2.5" strokeLinecap="round" className="animate-leg2" style={{ transformOrigin: '33.5px 34px' }} />
                {/* Arm carrying briefcase */}
                <g className="animate-arm" style={{ transformOrigin: '32px 23px' }}>
                  <path d="M34 23L38 32" stroke="url(#bodyGrad)" strokeWidth="2.5" strokeLinecap="round" />
                  {/* Briefcase - Vibrant Orange Gradient */}
                  <rect x="36" y="30" width="10" height="7" rx="1.5" fill="url(#caseGrad)" stroke="#1e1b4b" strokeWidth="0.5" />
                  <path d="M39 30V28.5C39 28.2239 39.2239 28 39.5 28H42.5C42.7761 28 43 28.2239 43 28.5V30" stroke="url(#caseGrad)" strokeWidth="1" />
                </g>
              </g>
              <defs>
                {/* 3D Drop Shadow filter for the walking gentleman */}
                <filter id="gentShadow" x="-20%" y="-20%" width="140%" height="140%">
                  <feDropShadow dx="0.8" dy="1.5" stdDeviation="0.8" floodColor="#000000" floodOpacity="0.25" />
                </filter>
                <radialGradient id="capsuleGlow" cx="50%" cy="50%" r="50%" fx="50%" fy="50%">
                  <stop offset="0%" stopColor="rgba(79, 70, 229, 0.12)" />
                  <stop offset="100%" stopColor="rgba(79, 70, 229, 0)" />
                </radialGradient>
                {/* 3D gradient for briefcase */}
                <linearGradient id="caseGrad" x1="36" y1="28" x2="46" y2="37" gradientUnits="userSpaceOnUse">
                  <stop offset="0%" stopColor="#fbbf24" />
                  <stop offset="50%" stopColor="#f59e0b" />
                  <stop offset="100%" stopColor="#dc2626" />
                </linearGradient>
                {/* 3D body gradient with highlight */}
                <linearGradient id="bodyGrad" x1="29" y1="14" x2="38" y2="46" gradientUnits="userSpaceOnUse">
                  <stop offset="0%" stopColor="#a5b4fc" />
                  <stop offset="30%" stopColor="#6366f1" />
                  <stop offset="100%" stopColor="#312e81" />
                </linearGradient>
                <linearGradient id="groundGrad" x1="10" y1="48" x2="110" y2="48" gradientUnits="userSpaceOnUse">
                  <stop offset="0%" stopColor="rgba(99, 102, 241, 0)" />
                  <stop offset="50%" stopColor="rgba(99, 102, 241, 0.5)" />
                  <stop offset="100%" stopColor="rgba(99, 102, 241, 0)" />
                </linearGradient>
              </defs>
            </svg>
          </div>
        </div>

        {/* Progress Bar & Status Text */}
        <div className="w-full relative z-10 flex flex-col gap-2.5">
          <div className="flex justify-between items-center w-full text-[10px] font-mono font-bold tracking-widest text-indigo-600 dark:text-sky-400 uppercase">
            <span>Scanning Opportunities...</span>
            <span className="ml-4 font-black">{Math.floor(progress)}%</span>
          </div>
          <div className="w-full h-1.5 bg-slate-950/80 rounded-full overflow-hidden border border-slate-800/80 relative shadow-[inset_0_1px_3px_rgba(0,0,0,0.4)]">
            <div
              className="h-full bg-gradient-to-r from-blue-600 via-indigo-500 to-sky-400 rounded-full transition-all duration-100 ease-out shadow-[0_0_10px_rgba(56,189,248,0.6)]"
              style={{ width: `${progress}%` }}
            />
          </div>
        </div>
      </div>
    );
  }

  // Compact version for buttons and inline lists
  return (
    <span className={`inline-flex items-center gap-1.5 font-mono text-[10px] font-bold text-indigo-600 dark:text-sky-400 ${className}`}>
      <span className="relative flex h-2 w-2">
        <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-indigo-500 dark:bg-sky-400 opacity-75"></span>
        <span className="relative inline-flex rounded-full h-2 w-2 bg-indigo-600 dark:bg-sky-500"></span>
      </span>
      <span>{Math.floor(progress)}%</span>
    </span>
  );
}

