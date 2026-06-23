'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { motion, AnimatePresence } from 'framer-motion';
import { MessageSquare, Sparkles } from 'lucide-react';
import { useState } from 'react';

export default function ChatbotBubble() {
  const pathname = usePathname();
  const [isHovered, setIsHovered] = useState(false);

  // Hide the floating bubble on the chat page itself
  if (pathname === '/chat') {
    return null;
  }

  return (
    <div className="fixed bottom-6 right-6 z-[100] select-none">
      <AnimatePresence>
        {isHovered && (
          <motion.div
            initial={{ opacity: 0, y: 10, scale: 0.9 }}
            animate={{ opacity: 1, y: 0, scale: 1 }}
            exit={{ opacity: 0, y: 10, scale: 0.9 }}
            className="absolute bottom-16 right-0 mb-2 whitespace-nowrap bg-white/90 dark:bg-zinc-900/90 backdrop-blur-md px-3.5 py-2 rounded-2xl border border-slate-200/60 dark:border-white/10 shadow-xl flex items-center gap-1.5 pointer-events-none"
          >
            <Sparkles size={11} className="text-cyan-500 animate-pulse" />
            <span className="text-[11px] font-bold font-mono tracking-wide text-foreground uppercase">
              AI Job Assistant
            </span>
          </motion.div>
        )}
      </AnimatePresence>

      <Link href="/chat" prefetch={false}>
        <motion.button
          onMouseEnter={() => setIsHovered(true)}
          onMouseLeave={() => setIsHovered(false)}
          onClick={() => setIsHovered(false)}
          initial={{ scale: 0.5, opacity: 0 }}
          animate={{ scale: 1, opacity: 1 }}
          whileHover={{ 
            scale: 1.06,
            boxShadow: '0 0 25px 3px rgba(99, 102, 241, 0.4)'
          }}
          whileTap={{ scale: 0.94 }}
          transition={{ type: 'spring', damping: 15, stiffness: 300 }}
          className="relative w-14 h-14 rounded-full bg-gradient-to-tr from-blue-600 via-indigo-500 to-cyan-400 flex items-center justify-center text-white shadow-2xl border border-white/20 cursor-pointer overflow-hidden group"
          aria-label="Open AI Assistant"
        >
          {/* Subtle reflection overlay effect */}
          <div className="absolute inset-0 bg-gradient-to-tr from-white/0 via-white/10 to-white/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300" />
          
          <MessageSquare size={22} className="relative z-10 drop-shadow-md" />
          
          {/* Pulsing indicator dot */}
          <span className="absolute top-3.5 right-3.5 flex h-2.5 w-2.5">
            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
            <span className="relative inline-flex rounded-full h-2.5 w-2.5 bg-emerald-500 border border-white dark:border-black"></span>
          </span>
        </motion.button>
      </Link>
    </div>
  );
}
