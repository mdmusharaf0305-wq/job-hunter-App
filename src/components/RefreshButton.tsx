'use client';

import { RefreshCw } from 'lucide-react';
import { useState } from 'react';
import { useRouter } from 'next/navigation';
import NotificationPopup from './NotificationPopup';

export type RefreshButtonProps = {
  position?: 'top' | 'center';
};

export default function RefreshButton({ position = 'top' }: RefreshButtonProps) {
  const [isRefreshing, setIsRefreshing] = useState(false);
  const [showNotification, setShowNotification] = useState(false);
  const router = useRouter();

  const handleRefresh = () => {
    setIsRefreshing(true);
    router.refresh();
    setTimeout(() => {
      setIsRefreshing(false);
      setShowNotification(true);
    }, 600);
  };

  return (
    <>
      <button
        onClick={handleRefresh}
        disabled={isRefreshing}
        title="Refresh Data"
        className="flex items-center justify-center p-2 rounded-xl bg-card border border-card-border hover:bg-card-border/50 transition-all shadow-sm text-muted-foreground hover:text-foreground disabled:opacity-50 h-[34px] w-[34px] shrink-0 active:scale-95 backdrop-blur-md"
      >
        <RefreshCw size={16} className={isRefreshing ? 'animate-[spin_0.5s_linear_infinite] text-accent-blue' : ''} />
      </button>

      <NotificationPopup
        isOpen={showNotification}
        onClose={() => setShowNotification(false)}
        type="success"
        title="Refreshed"
        message="Data is refreshed and up-to-date"
        autoCloseMs={300} // Set to 300ms (0.3 seconds) as requested
        position={position}
      />
    </>
  );
}
