'use client';

import dynamic from 'next/dynamic';

const ResumeViewer = dynamic(() => import('./ResumeViewer'), {
  ssr: false,
  loading: () => (
    <div className="w-full h-[calc(100vh-80px)] flex flex-col items-center justify-center">
      <div className="flex flex-col items-center gap-4 animate-pulse">
        <div className="w-12 h-12 rounded-xl bg-accent/20 flex items-center justify-center">
          <span className="relative flex h-4 w-4">
            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-accent opacity-75"></span>
            <span className="relative inline-flex rounded-full h-4 w-4 bg-accent"></span>
          </span>
        </div>
        <p className="font-mono text-sm text-muted-foreground uppercase tracking-widest">Loading PDF Viewer...</p>
      </div>
    </div>
  ),
});

export default function ResumePage() {
  return <ResumeViewer />;
}
