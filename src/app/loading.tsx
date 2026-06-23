'use client';

import LuffyLoader from '../components/LuffyLoader';

export default function Loading() {
  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center bg-background/80 backdrop-blur-md">
      <div className="flex flex-col items-center gap-6">
        {/* Animated Luffy Walking Loader */}
        <LuffyLoader size={72} />
      </div>
    </div>
  );
}
