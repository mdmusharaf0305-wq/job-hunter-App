'use client';

import { useState, useEffect } from 'react';
import { Document, Page, pdfjs } from 'react-pdf';
import { ChevronLeft, ChevronRight } from 'lucide-react';
import 'react-pdf/dist/Page/AnnotationLayer.css';
import 'react-pdf/dist/Page/TextLayer.css';

// Set up pdf.js worker
pdfjs.GlobalWorkerOptions.workerSrc = `//unpkg.com/pdfjs-dist@${pdfjs.version}/build/pdf.worker.min.mjs`;

export default function ResumePage() {
  const [numPages, setNumPages] = useState<number>();
  const [pageNumber, setPageNumber] = useState<number>(1);
  const [scale, setScale] = useState(1);
  const [containerWidth, setContainerWidth] = useState<number>(0);

  useEffect(() => {
    const updateWidth = () => {
      // Fit to screen width minus padding, max 800px
      setContainerWidth(Math.min(window.innerWidth - 64, 800));
    };
    updateWidth();
    window.addEventListener('resize', updateWidth);
    return () => window.removeEventListener('resize', updateWidth);
  }, []);

  const fileUrl = "/Mohammed%20Musharraf%20Resume.pdf";

  function onDocumentLoadSuccess({ numPages }: { numPages: number }): void {
    setNumPages(numPages);
  }

  return (
    <div className="w-full h-full flex flex-col gap-4 animate-fade-in min-w-0">
      <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center bg-card p-4 rounded-2xl border border-card-border shadow-sm backdrop-blur-md gap-4">
        <div>
          <h2 className="text-xl font-black tracking-tight text-foreground font-mono">My Resume</h2>
          <p className="text-[10px] sm:text-xs text-muted-foreground mt-0.5 tracking-widest uppercase">
            Viewing via Mozilla PDF.js
          </p>
        </div>
        
        <div className="flex flex-wrap items-center gap-3 sm:gap-4 w-full sm:w-auto">
          {/* Zoom controls */}
          <div className="flex flex-1 sm:flex-none justify-center bg-slate-100 dark:bg-white/5 rounded-lg p-1 border border-slate-200 dark:border-white/10">
            <button 
              onClick={() => setScale(s => Math.max(0.5, s - 0.2))}
              className="px-3 py-1 hover:bg-white dark:hover:bg-white/10 rounded-md text-sm font-bold active:scale-95 transition-all"
            >
              -
            </button>
            <span className="px-3 py-1 text-xs flex items-center font-mono font-bold w-12 justify-center">{Math.round(scale * 100)}%</span>
            <button 
              onClick={() => setScale(s => Math.min(2.5, s + 0.2))}
              className="px-3 py-1 hover:bg-white dark:hover:bg-white/10 rounded-md text-sm font-bold active:scale-95 transition-all"
            >
              +
            </button>
          </div>

          <a 
            href={fileUrl} 
            download
            className="flex-1 sm:flex-none text-center px-4 py-2 bg-slate-900 dark:bg-white text-white dark:text-slate-900 rounded-lg text-xs font-bold shadow-md hover:opacity-90 transition-opacity active:scale-95 border border-slate-800 dark:border-white whitespace-nowrap"
          >
            Download PDF
          </a>
        </div>
      </div>

      <div className="flex-1 w-full flex flex-col items-center overflow-hidden rounded-2xl border border-card-border bg-slate-100/50 dark:bg-black/20 shadow-inner relative">
        <div className="w-full h-full overflow-auto p-4 sm:p-8 flex justify-center custom-scrollbar">
          <Document
            file={fileUrl}
            onLoadSuccess={onDocumentLoadSuccess}
            className="flex flex-col gap-4 drop-shadow-2xl max-w-full"
            loading={
              <div className="flex items-center justify-center py-20">
                <div className="animate-spin rounded-full h-8 w-8 border-b-2 border-accent"></div>
              </div>
            }
            error={
              <div className="text-center py-20 text-red-500 font-mono text-sm border border-red-500/20 bg-red-500/10 rounded-xl p-8 mx-4">
                Error loading PDF. Please ensure &quot;Mohammed Musharraf Resume.pdf&quot; exists in the public directory.
              </div>
            }
          >
            <div className="bg-white rounded-lg overflow-hidden ring-1 ring-black/5 animate-fade-in flex justify-center max-w-full">
              <Page 
                pageNumber={pageNumber} 
                scale={scale} 
                width={containerWidth || undefined}
                renderTextLayer={true}
                renderAnnotationLayer={true}
                className="max-w-full"
              />
            </div>
          </Document>
        </div>

        {/* Floating Carousel Controls at the bottom */}
        {numPages && (
          <div className="absolute bottom-4 sm:bottom-8 left-1/2 -translate-x-1/2 flex items-center gap-3 bg-white/90 dark:bg-black/80 backdrop-blur-xl px-3 py-2 rounded-full shadow-2xl border border-slate-200 dark:border-white/10 z-10">
            <button 
              onClick={() => setPageNumber(p => Math.max(1, p - 1))}
              disabled={pageNumber <= 1}
              className="p-1.5 sm:p-2 hover:bg-slate-100 dark:hover:bg-white/10 rounded-full text-slate-800 dark:text-white active:scale-95 transition-all disabled:opacity-30"
            >
              <ChevronLeft size={18} />
            </button>
            
            <div className="flex items-center gap-1.5 sm:gap-2">
              {Array.from(new Array(numPages), (el, index) => (
                <button
                  key={index}
                  onClick={() => setPageNumber(index + 1)}
                  className={`w-2 h-2 sm:w-2.5 sm:h-2.5 rounded-full transition-all ${
                    pageNumber === index + 1 
                      ? 'bg-accent scale-125' 
                      : 'bg-slate-300 dark:bg-white/20 hover:bg-slate-400 dark:hover:bg-white/40'
                  }`}
                  aria-label={`Go to page ${index + 1}`}
                />
              ))}
            </div>

            <button 
              onClick={() => setPageNumber(p => Math.min(numPages, p + 1))}
              disabled={pageNumber >= numPages}
              className="p-1.5 sm:p-2 hover:bg-slate-100 dark:hover:bg-white/10 rounded-full text-slate-800 dark:text-white active:scale-95 transition-all disabled:opacity-30"
            >
              <ChevronRight size={18} />
            </button>
          </div>
        )}
      </div>
    </div>
  );
}
