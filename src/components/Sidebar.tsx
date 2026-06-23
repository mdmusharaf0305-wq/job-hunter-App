'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { motion } from 'framer-motion';
import { 
  ChevronRight,
  Sparkles,
  Sun,
  Moon,
  Menu,
  X
} from 'lucide-react';
import { useEffect, useState } from 'react';
import { getDashboardMetricsAction } from '../actions/recruiterActions';
import { DashboardMetrics } from '../types';

const Logo = () => (
  <div className="w-8 h-8 rounded-lg bg-gradient-to-tr from-blue-600 via-indigo-500 to-sky-400 flex items-center justify-center glow-cyan shrink-0 shadow-sm">
    <svg className="w-4.5 h-4.5 text-white" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
      <path d="M12 2L2 7l10 5 10-5-10-5zM2 17l10 5 10-5M2 12l10 5 10-5" />
    </svg>
  </div>
);

export default function Sidebar() {
  const pathname = usePathname();
  const [metrics, setMetrics] = useState<DashboardMetrics | null>(null);
  const [theme, setTheme] = useState<'light' | 'dark'>('light');
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  // Close mobile menu on route change
  useEffect(() => {
    setIsMobileMenuOpen(false);
  }, [pathname]);

  // Load theme preference on mount
  useEffect(() => {
    const savedTheme = localStorage.getItem('theme') as 'light' | 'dark' | null;
    const initialTheme = savedTheme || 'light';
    // eslint-disable-next-line react-hooks/set-state-in-effect
    setTheme(initialTheme);
    
    if (initialTheme === 'dark') {
      document.documentElement.classList.add('dark');
      document.documentElement.classList.remove('light');
    } else {
      document.documentElement.classList.add('light');
      document.documentElement.classList.remove('dark');
    }
  }, []);

  // Fetch metrics when route changes
  useEffect(() => {
    getDashboardMetricsAction()
      .then(setMetrics)
      .catch(console.error);
  }, [pathname]);

  const toggleTheme = () => {
    const nextTheme = theme === 'light' ? 'dark' : 'light';
    setTheme(nextTheme);
    localStorage.setItem('theme', nextTheme);
    
    if (nextTheme === 'dark') {
      document.documentElement.classList.add('dark');
      document.documentElement.classList.remove('light');
    } else {
      document.documentElement.classList.add('light');
      document.documentElement.classList.remove('dark');
    }
    
    // Close mobile menu to match navigation behavior
    setTimeout(() => setIsMobileMenuOpen(false), 200);
  };

  type NavItem = { name: string; href: string; emoji: string; badge?: number | string };
  const navItems: NavItem[] = [
    { name: 'Dashboard', href: '/dashboard', emoji: '📊' },
    { name: 'Companies Watchlist', href: '/companies', emoji: '🏢' },
    { name: 'Current Pipeline', href: '/pipeline', emoji: '🎯' },
    { name: 'Inbound Applications', href: '/inbound', emoji: '📥' },
    { name: 'Outbound Applications', href: '/outbound', emoji: '📤' },
    { name: 'Applications History', href: '/timeline', emoji: '📜' },
    { name: 'Recruiters', href: '/recruiters', emoji: '👥' },
    { name: 'Resume', href: '/resume', emoji: '📄' },
    { name: 'AI Job Assistant', href: '/chat', emoji: '🤖' },
  ];

  return (
    <>
      {/* Mobile Top Menu Bar */}
      <header 
        className="lg:hidden fixed top-[calc(0.75rem+env(safe-area-inset-top,0px))] left-1/2 -translate-x-1/2 w-[calc(100%-2rem)] max-w-md h-12 bg-white/80 dark:bg-[#0a0a0a]/80 backdrop-blur-xl border border-slate-200/50 dark:border-white/10 z-50 px-4 flex items-center justify-between select-none shadow-lg rounded-2xl"
      >
        <div className="flex items-center gap-2.5">
          <Logo />
          <div className="flex flex-col justify-center">
            <span className="text-[9px] text-slate-500 dark:text-zinc-400 font-mono font-bold tracking-[0.2em] uppercase leading-none mb-0.5">Musharraf&apos;s</span>
            <h1 className="text-[12px] font-black text-slate-900 dark:text-white tracking-tight uppercase leading-none font-sans">
              Job Hunt
            </h1>
          </div>
        </div>
        
        <button 
          onClick={() => setIsMobileMenuOpen(!isMobileMenuOpen)}
          className="p-1.5 rounded-xl bg-slate-150/50 dark:bg-white/5 border border-slate-200/55 dark:border-white/10 text-slate-700 dark:text-zinc-300 transition-all cursor-pointer active:scale-90 flex items-center justify-center shadow-sm"
          aria-label="Toggle menu"
        >
          <Menu size={16} strokeWidth={2.5} />
        </button>
      </header>

      {/* Mobile iOS-Style Bottom Drawer Overlay */}
      {isMobileMenuOpen && (
        <div 
          className="lg:hidden fixed inset-0 bg-slate-900/30 dark:bg-black/50 backdrop-blur-sm z-50 flex items-center justify-center p-6"
          onClick={() => setIsMobileMenuOpen(false)}
        >
          <motion.div 
            initial={{ scale: 0.95, opacity: 0 }}
            animate={{ scale: 1, opacity: 1 }}
            exit={{ scale: 0.95, opacity: 0 }}
            transition={{ type: 'spring', damping: 25, stiffness: 350 }}
            className="w-full max-w-xs max-h-[85vh] overflow-y-auto bg-white/95 dark:bg-[#0a0a0a]/95 backdrop-blur-xl rounded-[28px] shadow-2xl border border-slate-200 dark:border-white/10 flex flex-col p-5 gap-4"
            onClick={(e) => e.stopPropagation()}
          >
            {/* Header & Close Button */}
            <div className="flex justify-between items-center">
              <h2 className="text-xs font-bold text-foreground font-mono uppercase tracking-wider">Menu</h2>
              <button 
                onClick={() => setIsMobileMenuOpen(false)}
                className="p-1.5 rounded-xl bg-slate-100 dark:bg-white/5 text-muted-foreground active:scale-95 border border-slate-200/50 dark:border-white/10 flex items-center justify-center cursor-pointer shadow-sm"
              >
                <X size={14} />
              </button>
            </div>

            {/* Navigation Items */}
            <nav className="space-y-1.5">
              {navItems.map((item) => {
                const isActive = pathname === item.href;
                return (
                  <Link
                    key={item.name}
                    href={item.href}
                    prefetch={false}
                    onClick={() => setIsMobileMenuOpen(false)}
                    className={`flex items-center justify-between px-3.5 py-3 rounded-xl text-xs font-bold transition-all duration-200 border ${
                      isActive
                        ? 'bg-black/5 dark:bg-white/10 text-foreground border-slate-200/60 dark:border-white/10 shadow-sm'
                        : 'bg-transparent text-muted-foreground border-transparent hover:bg-slate-100 dark:hover:bg-white/5'
                    }`}
                  >
                    <div className="flex items-center gap-3">
                      <span className="text-[16px] leading-none">{item.emoji}</span>
                      <span>{item.name}</span>
                    </div>
                    {item.badge !== undefined && (
                      <span className={`px-2 py-0.5 rounded-full text-[10px] font-mono font-bold ${
                        isActive 
                          ? 'bg-blue-100 dark:bg-blue-500/20 text-blue-700 dark:text-blue-300' 
                          : 'bg-slate-200 dark:bg-white/10 text-slate-600 dark:text-slate-300'
                      }`}>
                        {item.badge}
                      </span>
                    )}
                  </Link>
                );
              })}
            </nav>

            {/* AI widget for Mobile */}
            {metrics && metrics.followUpsDue.length > 0 && (
              <div className="p-3.5 rounded-xl bg-blue-50 dark:bg-blue-900/20 border border-blue-100/50 dark:border-blue-800/20">
                <div className="flex items-center gap-1.5 mb-1">
                  <Sparkles size={12} className="text-blue-600 dark:text-blue-400 animate-pulse" />
                  <h4 className="text-xs font-bold text-slate-900 dark:text-white tracking-wide">AI Follow-up Alert</h4>
                </div>
                <p className="text-xs text-slate-600 dark:text-slate-350 leading-relaxed">
                  You have <span className="text-slate-900 dark:text-white font-semibold font-mono">{metrics.followUpsDue.length}</span> follow-up{metrics.followUpsDue.length > 1 ? 's' : ''} pending.
                </p>
                <Link
                  href="/dashboard"
                  prefetch={false}
                  onClick={() => setIsMobileMenuOpen(false)}
                  className="mt-2 flex items-center text-xs text-blue-700 dark:text-blue-400 font-bold hover:underline gap-1 bg-white/50 dark:bg-black/20 w-max px-2.5 py-1 rounded-lg"
                >
                  Review actions 
                  <ChevronRight size={12} />
                </Link>
              </div>
            )}

            {/* Theme Toggle */}
            <div className="pt-1">
              <div className="flex items-center justify-between p-3.5 rounded-xl bg-slate-50 dark:bg-white/2 border border-slate-200/50 dark:border-white/5 shadow-sm">
                <span className="text-[11px] text-slate-500 dark:text-slate-400 font-mono font-bold tracking-widest uppercase">Appearance</span>
                <button
                  onClick={toggleTheme}
                  className="relative flex items-center w-[76px] h-8 rounded-full bg-slate-200/80 dark:bg-white/10 p-1 cursor-pointer outline-none focus-visible:ring-2 focus-visible:ring-accent transition-colors overflow-hidden select-none active:scale-95 border border-slate-200 dark:border-white/5"
                  aria-label="Toggle Theme"
                >
                  <motion.div
                    className="absolute h-6 w-9 rounded-full bg-white dark:bg-[#2a2a2a] shadow-sm flex items-center justify-center z-10"
                    animate={{ x: theme === 'light' ? 0 : 30 }}
                    transition={{ type: "spring", stiffness: 500, damping: 30 }}
                  >
                    {theme === 'light' ? (
                      <Sun size={12} className="text-amber-500" />
                    ) : (
                      <Moon size={12} className="text-indigo-400" />
                    )}
                  </motion.div>
                </button>
              </div>
            </div>
          </motion.div>
        </div>
      )}

      {/* Desktop Sidebar */}
      <aside 
        className="hidden lg:flex w-64 border-r border-card-border flex-col h-screen fixed left-0 top-0 z-35 bg-background select-none transition-colors duration-300"
      >
        {/* Brand Header */}
        <div className="h-16 flex items-center px-6 border-b border-slate-200/80 dark:border-zinc-800/80 gap-3">
          <Logo />
          <div>
            <div className="text-xs text-slate-500 dark:text-zinc-400 font-mono font-bold tracking-widest uppercase mb-0.5">Musharraf&apos;s</div>
            <h1 className="text-xs font-bold text-slate-900 dark:text-white tracking-tight uppercase leading-tight font-sans">
              Job Hunt
            </h1>
          </div>
        </div>

        {/* Navigation Items */}
        <nav className="flex-1 px-4 py-6 space-y-1.5">
          {navItems.map((item) => {
                const isActive = pathname === item.href;
            return (
              <Link
                key={item.name}
                href={item.href}
                prefetch={false}
                className={`relative flex items-center justify-between px-3 py-2.5 rounded-xl text-xs font-bold transition-all group duration-200 ${
                  isActive
                    ? 'text-foreground shadow-sm'
                    : 'text-muted-foreground hover:text-foreground hover:bg-black/5 dark:hover:bg-white/5 hover:pl-4'
                }`}
              >
                {isActive && (
                  <motion.div
                    layoutId="activeSidebarTab"
                    className="absolute inset-0 bg-black/5 dark:bg-white/5 border-l-4 border-accent rounded-xl"
                    transition={{ type: "spring", stiffness: 350, damping: 30 }}
                  />
                )}
                <div className="relative z-10 flex items-center gap-3">
                  <span className="text-[16px] leading-none opacity-80 group-hover:opacity-100">{item.emoji}</span>
                  <span>{item.name}</span>
                </div>
                
                {item.badge !== undefined && (
                  <span className={`relative z-10 px-2 py-0.5 rounded-full text-xs font-mono font-bold transition-colors ${
                    isActive 
                      ? 'bg-accent/10 text-accent' 
                      : 'bg-card-border text-muted-foreground group-hover:bg-accent/10 group-hover:text-accent'
                  }`}>
                    {item.badge}
                  </span>
                )}
              </Link>
            );
          })}
        </nav>

        {/* AI Follow-up Widget */}
        {metrics && metrics.followUpsDue.length > 0 && (
          <div className="px-4 py-4 mx-4 mb-4 rounded-2xl bg-card border border-card-border shadow-sm">
            <div className="flex items-center gap-2 mb-1.5">
              <Sparkles size={14} className="text-blue-600 dark:text-accent-blue animate-pulse" />
              <h4 className="text-[13px] font-bold text-slate-950 dark:text-white tracking-wide">AI Follow-up Alert</h4>
            </div>
            <p className="text-xs text-slate-600 dark:text-slate-350 leading-relaxed">
              You have <span className="text-slate-950 dark:text-white font-semibold font-mono">{metrics.followUpsDue.length}</span> follow-up{metrics.followUpsDue.length > 1 ? 's' : ''} pending.
            </p>
            <Link
              href="/dashboard"
              prefetch={false}
              className="mt-2.5 flex items-center text-xs text-blue-600 dark:text-accent-blue font-semibold hover:underline gap-1 group"
            >
              Review actions 
              <ChevronRight size={10} className="transition-transform group-hover:translate-x-0.5" />
            </Link>
          </div>
        )}

        {/* Theme Toggle Button */}
        <div className="px-4 py-3 mx-4 mb-2 rounded-2xl bg-slate-50 dark:bg-white/2 border border-slate-100 dark:border-white/5 flex items-center justify-between shadow-sm backdrop-blur-md">
          <span className="text-xs text-slate-550 dark:text-slate-400 font-mono tracking-widest uppercase">Theme Mode</span>
          <button
            onClick={toggleTheme}
            className="relative flex items-center w-24 h-8 rounded-full bg-slate-200/80 dark:bg-white/10 p-1 cursor-pointer outline-none focus-visible:ring-2 focus-visible:ring-accent transition-colors overflow-hidden select-none active:scale-95"
            aria-label="Toggle Theme"
          >
            <div className="flex w-full justify-between px-2 text-xs font-mono font-bold tracking-widest text-slate-400 dark:text-zinc-500 z-0 select-none pointer-events-none">
              <span>LGT</span>
              <span>DRK</span>
            </div>
            <motion.div
              className="absolute h-6 w-11 rounded-full bg-white dark:bg-[#2a2a2a] shadow-sm flex items-center justify-center z-10"
              animate={{ x: theme === 'light' ? 0 : 44 }}
              transition={{ type: "spring", stiffness: 500, damping: 30 }}
            >
              {theme === 'light' ? (
                <Sun size={12} className="text-amber-500 drop-shadow-sm" />
              ) : (
                <Moon size={12} className="text-indigo-400 drop-shadow-sm" />
              )}
            </motion.div>
          </button>
        </div>

        {/* Keyboard Shortcuts Helper */}
        <div className="p-4 border-t border-slate-150 dark:border-zinc-800/80 bg-slate-50/30 dark:bg-white/[0.01]">
          <div className="flex items-center justify-between text-xs text-slate-550 dark:text-slate-400 font-mono">
            <span>Outreach Helper</span>
            <span className="px-1.5 py-0.5 rounded bg-slate-100 dark:bg-white/5 text-xs border border-slate-200/50 dark:border-white/5">⌥ F</span>
          </div>
        </div>
      </aside>
    </>
  );
}
