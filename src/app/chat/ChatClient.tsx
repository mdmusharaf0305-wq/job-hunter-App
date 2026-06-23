'use client';

import { useState, useRef, useEffect } from 'react';
import { 
  Send, 
  Bot, 
  User, 
  RefreshCw,
  Phone,
  Mail,
  MessageCircle,
  MessageSquare,
  CheckCircle,
  Calendar,
  TrendingUp,
  Sliders
} from 'lucide-react';
import { DashboardMetrics, JobApplication, ApplicationStage } from '../../types';
import { 
  createApplicationAction, 
  updateApplicationStageAction, 
  getDashboardMetricsAction,
  getApplicationsAction
} from '../../actions/recruiterActions';
import { triggerPhone, triggerWhatsApp, triggerGmail, triggerSMS } from '../../lib/linkUtils';

interface Message {
  id: string;
  sender: 'bot' | 'user';
  text: string;
  timestamp: Date;
  isCustomReport?: boolean;
  reportType?: 'metrics' | 'table' | 'opportunity' | 'success';
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  reportData?: any;
}

interface ChatClientProps {
  initialMetrics: DashboardMetrics;
  initialApplications: JobApplication[];
}

function getNow(): Date {
  return new Date();
}

function generateRandomId(prefix: string): string {
  return `${prefix}-${Date.now()}-${Math.floor(Math.random() * 1000000)}`;
}

// Maps input string to Notion status stages
const mapInputToStage = (input: string): ApplicationStage => {
  const clean = input.toLowerCase().trim();
  if (clean.includes('source') || clean.includes('apply') || clean.includes('applied') || clean.includes('start')) {
    return '📄 Applied';
  }
  if (clean.includes('screen') || clean.includes('hr') || clean.includes('shortlist')) {
    return '📞 HR Screening';
  }
  if (clean.includes('interview') || clean.includes('technical') || clean.includes('manager') || clean.includes('test') || clean.includes('round')) {
    return '🗓️ Interview Scheduled';
  }
  if (clean.includes('paused') || clean.includes('hold') || clean.includes('wait')) {
    return '⏸️ On Hold';
  }
  if (clean.includes('offer') || clean.includes('won') || clean.includes('sec')) {
    return '🎉 Offer Received';
  }
  if (clean.includes('reject') || clean.includes('drop') || clean.includes('fail') || clean.includes('lost')) {
    return '❌ Rejected';
  }
  return '📄 Applied'; // fallback
};

export default function ChatClient({ initialMetrics, initialApplications }: ChatClientProps) {
  const [messages, setMessages] = useState<Message[]>([
    {
      id: 'welcome',
      sender: 'bot',
      text: "Hello! I am your AI Job Hunter OS Assistant. I am directly synced with your Notion DB. You can ask me to query your pipeline or make modifications in real-time.\n\n**Try commands like:**\n- `add job at Stripe as Lead React Engineer`\n- `mark Microsoft as Interviewing`\n- `show active interviews`\n- `pipeline summary`\n- `who needs follow up?`",
      timestamp: new Date()
    }
  ]);
  const [inputValue, setInputValue] = useState('');
  const [isTyping, setIsTyping] = useState(false);
  const [applications, setApplications] = useState<JobApplication[]>(initialApplications);
  const [metrics, setMetrics] = useState<DashboardMetrics>(initialMetrics);
  const chatEndRef = useRef<HTMLDivElement>(null);

  // Auto-scroll on new messages
  useEffect(() => {
    chatEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  }, [messages, isTyping]);

  const quickChips = [
    { label: "📈 Pipeline Summary", query: "pipeline summary" },
    { label: "🎯 Active Interviews", query: "show active interviews" },
    { label: "⏳ Pending Follow-ups", query: "who needs follow up?" },
    { label: "👥 Recruiters Directory", query: "show recruiters" }
  ];

  // Refresh data from Notion DB
  const handleReloadSession = async () => {
    setIsTyping(true);
    try {
      const [updatedMetrics, updatedApps] = await Promise.all([
        getDashboardMetricsAction(),
        getApplicationsAction()
      ]);
      setMetrics(updatedMetrics);
      setApplications(updatedApps);
      setMessages(prev => [
        ...prev,
        {
          id: generateRandomId('bot'),
          sender: 'bot',
          text: "🔄 Session fully revalidated! I've loaded the latest records from your Notion database. What can I do for you now?",
          timestamp: getNow()
        }
      ]);
    } catch (e) {
      console.error(e);
      setMessages(prev => [
        ...prev,
        {
          id: generateRandomId('bot'),
          sender: 'bot',
          text: "❌ Failed to revalidate session. Please check your Notion connection.",
          timestamp: getNow()
        }
      ]);
    } finally {
      setIsTyping(false);
    }
  };

  const handleSendMessage = async (textToSend: string) => {
    if (!textToSend.trim()) return;

    const userMsg: Message = {
      id: generateRandomId('user'),
      sender: 'user',
      text: textToSend,
      timestamp: getNow()
    };

    setMessages(prev => [...prev, userMsg]);
    setInputValue('');
    setIsTyping(true);

    const query = textToSend.toLowerCase().trim();

    try {
      // 1. ADD JOB COMMAND
      // Format: add job at [Company] as [Role]
      const addMatch = textToSend.match(/(?:add|create|new)\s+(?:job|app|application|opportunity)?\s*(?:at|for)?\s*([a-zA-Z0-9\s\.\-\&\#]+?)(?:\s+(?:as|role)\s+([a-zA-Z0-9\s\.\-\&\#]+))?(?:\s+(?:status|stage)\s+([a-zA-Z\s]+))?$/i);
      if (addMatch && (query.startsWith('add') || query.startsWith('create') || query.startsWith('new'))) {
        const company = addMatch[1].trim();
        const role = addMatch[2] ? addMatch[2].trim() : 'Software Engineer';
        const rawStatus = addMatch[3] ? addMatch[3].trim() : 'sourcing';
        const mappedStatus = mapInputToStage(rawStatus);

        const newApp: Partial<JobApplication> = {
          company,
          role,
          type: 'outbound',
          status: mappedStatus,
          priority: 'Medium',
          lastUpdated: new Date().toISOString().split('T')[0]
        };

        const created = await createApplicationAction(newApp);
        setApplications(prev => [created, ...prev]);

        // Refresh metrics in background
        getDashboardMetricsAction().then(setMetrics).catch(console.error);

        setMessages(prev => [
          ...prev,
          {
            id: generateRandomId('bot'),
            sender: 'bot',
            text: `I've created a new outbound application for **${company}** in your Notion DB.`,
            timestamp: getNow(),
            isCustomReport: true,
            reportType: 'success',
            reportData: {
              title: "Opportunity Created",
              company: created.company,
              role: created.role,
              status: created.status,
              priority: created.priority,
              type: created.type,
              id: created.id
            }
          }
        ]);
        setIsTyping(false);
        return;
      }

      // 2. UPDATE STAGE COMMAND
      // Format: update [Company] status/stage to [Stage]
      const updateMatch = textToSend.match(/(?:update|change|set|mark)\s+([a-zA-Z0-9\s\.\-\&\#]+?)\s+(?:status|stage)?\s*(?:to)?\s*([a-zA-Z0-9\s\-\_]+)$/i);
      if (updateMatch && (query.startsWith('update') || query.startsWith('change') || query.startsWith('set') || query.startsWith('mark'))) {
        const companyName = updateMatch[1].trim().toLowerCase();
        const targetStageStr = updateMatch[2].trim();
        const mappedStage = mapInputToStage(targetStageStr);

        const targetApp = applications.find(a => a.company.toLowerCase() === companyName || a.company.toLowerCase().includes(companyName));

        if (!targetApp) {
          setMessages(prev => [
            ...prev,
            {
              id: generateRandomId('bot'),
              sender: 'bot',
              text: `Sorry, I couldn't find any tracked application for "${updateMatch[1].trim()}" in your database to update.`,
              timestamp: getNow()
            }
          ]);
          setIsTyping(false);
          return;
        }

        const updated = await updateApplicationStageAction(targetApp.id, mappedStage);
        setApplications(prev => prev.map(a => a.id === targetApp.id ? { ...a, status: mappedStage } : a));

        // Refresh metrics
        getDashboardMetricsAction().then(setMetrics).catch(console.error);

        setMessages(prev => [
          ...prev,
          {
            id: generateRandomId('bot'),
            sender: 'bot',
            text: `Updated status for **${updated.company}** to **${mappedStage}** in your Notion DB.`,
            timestamp: getNow(),
            isCustomReport: true,
            reportType: 'success',
            reportData: {
              title: "Opportunity Updated",
              company: updated.company,
              role: updated.role,
              status: mappedStage,
              priority: updated.priority || 'Medium',
              type: updated.type,
              id: updated.id
            }
          }
        ]);
        setIsTyping(false);
        return;
      }

      // 3. PIPELINE SUMMARY / STATS
      if (query.includes('pipeline') || query.includes('summary') || query.includes('stats') || query.includes('metrics')) {
        const activeApps = applications.filter(a => 
          a.status && !a.status.toLowerCase().includes('reject') && !a.status.toLowerCase().includes('drop')
        );
        const screening = applications.filter(a => 
          a.status && (a.status.toLowerCase().includes('screen') || a.status.toLowerCase().includes('hr'))
        );
        const interviews = applications.filter(a => 
          a.status && (a.status.toLowerCase().includes('interview') || a.status.toLowerCase().includes('round') || a.status.toLowerCase().includes('test'))
        );
        const offers = applications.filter(a => 
          a.status && (a.status.toLowerCase().includes('offer') || a.status.toLowerCase().includes('received'))
        );

        setMessages(prev => [
          ...prev,
          {
            id: generateRandomId('bot'),
            sender: 'bot',
            text: "Here is your Notion pipeline health summary. Everything is synced real-time:",
            timestamp: getNow(),
            isCustomReport: true,
            reportType: 'metrics',
            reportData: {
              total: activeApps.length,
              screening: screening.length,
              interviews: interviews.length,
              offers: offers.length
            }
          }
        ]);
        setIsTyping(false);
        return;
      }

      // 4. ACTIVE INTERVIEWS / STAGES LOOKUP
      if (query.includes('interview')) {
        const interviewApps = applications.filter(a => 
          a.status && (a.status.toLowerCase().includes('interview') || a.status.toLowerCase().includes('round') || a.status.toLowerCase().includes('test'))
        );

        if (interviewApps.length === 0) {
          setMessages(prev => [
            ...prev,
            {
              id: generateRandomId('bot'),
              sender: 'bot',
              text: "You don't have any active interview loops scheduled at the moment.",
              timestamp: getNow()
            }
          ]);
        } else {
          setMessages(prev => [
            ...prev,
            {
              id: generateRandomId('bot'),
              sender: 'bot',
              text: `You have **${interviewApps.length} active interview loops** in progress:`,
              timestamp: getNow(),
              isCustomReport: true,
              reportType: 'table',
              reportData: interviewApps.map(a => ({
                id: a.id,
                company: a.company,
                role: a.role,
                stage: a.status,
                phone: a.recruiterPhone,
                name: a.recruiterName,
                email: a.recruiterEmail
              }))
            }
          ]);
        }
        setIsTyping(false);
        return;
      }

      // 5. PENDING FOLLOW-UPS
      if (query.includes('follow up') || query.includes('follow-up') || query.includes('pending') || query.includes('action')) {
        const sevenDaysAgo = new Date();
        sevenDaysAgo.setDate(sevenDaysAgo.getDate() - 7);

        const followUps = applications.filter(a => {
          const isActive = a.status && !a.status.toLowerCase().includes('reject') && !a.status.toLowerCase().includes('drop') && !a.status.toLowerCase().includes('offer');
          const hasRecruiter = !!(a.recruiterName || a.recruiterEmail || a.recruiterPhone);
          if (!isActive || !hasRecruiter) return false;
          if (!a.lastContactedDate) return true;
          return new Date(a.lastContactedDate) < sevenDaysAgo;
        });

        if (followUps.length === 0) {
          setMessages(prev => [
            ...prev,
            {
              id: generateRandomId('bot'),
              sender: 'bot',
              text: "✅ Fantastic! All active recruiters have been contacted within the last 7 days. No follow-ups are due.",
              timestamp: getNow()
            }
          ]);
        } else {
          setMessages(prev => [
            ...prev,
            {
              id: generateRandomId('bot'),
              sender: 'bot',
              text: `Here are the **${followUps.length} opportunities** that haven't been contacted in 7+ days. I recommend bumping them:`,
              timestamp: getNow(),
              isCustomReport: true,
              reportType: 'table',
              reportData: followUps.map(a => ({
                id: a.id,
                company: a.company,
                role: a.role,
                stage: `${a.status} (No contact since ${a.lastContactedDate ? new Date(a.lastContactedDate).toLocaleDateString() : 'Never'})`,
                phone: a.recruiterPhone,
                name: a.recruiterName,
                email: a.recruiterEmail
              }))
            }
          ]);
        }
        setIsTyping(false);
        return;
      }

      // 6. RECRUITERS DIRECTORY
      if (query.includes('recruiter') || query.includes('contact') || query.includes('directory')) {
        const contacts = applications
          .filter(a => a.recruiterName)
          .map(a => ({
            id: a.id,
            company: a.company,
            role: a.role,
            name: a.recruiterName || '',
            phone: a.recruiterPhone,
            email: a.recruiterEmail,
            stage: a.status
          }));

        if (contacts.length === 0) {
          setMessages(prev => [
            ...prev,
            {
              id: generateRandomId('bot'),
              sender: 'bot',
              text: "I couldn't find any recruiters logged in your applications database.",
              timestamp: getNow()
            }
          ]);
        } else {
          setMessages(prev => [
            ...prev,
            {
              id: generateRandomId('bot'),
              sender: 'bot',
              text: `Found **${contacts.length} recruiter contacts** in your active files:`,
              timestamp: getNow(),
              isCustomReport: true,
              reportType: 'table',
              reportData: contacts
            }
          ]);
        }
        setIsTyping(false);
        return;
      }

      // Smart Database Querying (statuses, types, recruiters by name)
      let matchedCategory = false;
      let matchedResults: JobApplication[] = [];
      let resultText = "";

      const recruiterQueryWords = ['recruiter', 'who is', 'tell me about', 'contact for', 'phone of', 'email of', 'find', 'show', 'search'];
      const queryWithoutRecruiter = recruiterQueryWords.reduce((q, word) => q.replace(new RegExp(`\\b${word}\\b`, 'g'), ''), query).replace(/\s+/g, ' ').trim();
      
      const isNameSearch = queryWithoutRecruiter.length > 2 && !['pipeline', 'summary', 'stats', 'metrics', 'interview', 'follow up', 'follow-up', 'pending', 'action', 'prep', 'prepare', 'checklist', 'reject', 'hold', 'paused', 'closed', 'no opening', 'screening', 'ongoing', 'active', 'inbound', 'outbound', 'offer'].some(w => query.includes(w));
      
      let matchedRecruiters: JobApplication[] = [];
      if (isNameSearch) {
        matchedRecruiters = applications.filter(a => 
          (a.recruiterName && a.recruiterName.toLowerCase().includes(queryWithoutRecruiter)) ||
          (a.recruiterCompany && a.recruiterCompany.toLowerCase().includes(queryWithoutRecruiter))
        );
      }

      if (matchedRecruiters.length > 0) {
        matchedCategory = true;
        matchedResults = matchedRecruiters;
        resultText = `Found **${matchedRecruiters.length} recruiter contact(s)** matching "${queryWithoutRecruiter}":`;
      } 
      else if (query.includes('reject') || query.includes('lost') || query.includes('fail') || query.includes('dropped')) {
        matchedCategory = true;
        matchedResults = applications.filter(a => 
          a.status && (a.status.toLowerCase().includes('reject') || a.status.toLowerCase().includes('drop'))
        );
        resultText = `Found **${matchedResults.length} rejected/dropped application(s)** in your Notion DB:`;
      } 
      else if (query.includes('hold') || query.includes('paused') || query.includes('wait')) {
        matchedCategory = true;
        matchedResults = applications.filter(a => 
          a.status && (a.status.toLowerCase().includes('hold') || a.status.toLowerCase().includes('pause'))
        );
        resultText = `Found **${matchedResults.length} application(s) currently on hold in your Notion DB:**`;
      } 
      else if (query.includes('no opening') || query.includes('closed') || query.includes('position closed')) {
        matchedCategory = true;
        matchedResults = applications.filter(a => 
          a.status && (a.status.toLowerCase().includes('closed') || a.status.toLowerCase().includes('no openings'))
        );
        resultText = `Found **${matchedResults.length} closed/no-openings application(s) in your Notion DB:**`;
      } 
      else if (query.includes('screening') || query.includes('screen') || query.includes('hr round')) {
        matchedCategory = true;
        matchedResults = applications.filter(a => 
          a.status && (a.status.toLowerCase().includes('screen') || a.status.toLowerCase().includes('hr'))
        );
        resultText = `Found **${matchedResults.length} screening application(s) in your Notion DB:**`;
      }
      else if (query.includes('ongoing') || query.includes('active') || query.includes('current') || query.includes('in progress')) {
        matchedCategory = true;
        matchedResults = applications.filter(a => {
          const s = (a.status || '').toLowerCase();
          return s && !s.includes('reject') && !s.includes('drop') && !s.includes('closed') && !s.includes('no openings');
        });
        resultText = `Found **${matchedResults.length} ongoing/active application(s) in your pipeline:**`;
      }
      else if (query.includes('inbound')) {
        matchedCategory = true;
        matchedResults = applications.filter(a => a.type === 'inbound');
        resultText = `Found **${matchedResults.length} inbound application(s) in your Notion DB:**`;
      }
      else if (query.includes('outbound')) {
        matchedCategory = true;
        matchedResults = applications.filter(a => a.type === 'outbound');
        resultText = `Found **${matchedResults.length} outbound application(s) in your Notion DB:**`;
      }
      else if (query.includes('offer')) {
        matchedCategory = true;
        matchedResults = applications.filter(a => 
          a.status && (a.status.toLowerCase().includes('offer') || a.status.toLowerCase().includes('received'))
        );
        resultText = `Found **${matchedResults.length} secured offer(s) in your Notion DB:**`;
      }

      if (matchedCategory) {
        if (matchedResults.length === 0) {
          setMessages(prev => [
            ...prev,
            {
              id: generateRandomId('bot'),
              sender: 'bot',
              text: `I couldn't find any database records matching this query.`,
              timestamp: getNow()
            }
          ]);
        } else {
          setMessages(prev => [
            ...prev,
            {
              id: generateRandomId('bot'),
              sender: 'bot',
              text: resultText,
              timestamp: getNow(),
              isCustomReport: true,
              reportType: 'table',
              reportData: matchedResults.map(a => ({
                id: a.id,
                company: a.company,
                role: a.role,
                stage: a.status,
                phone: a.recruiterPhone,
                name: a.recruiterName || 'N/A',
                email: a.recruiterEmail
              }))
            }
          ]);
        }
        setIsTyping(false);
        return;
      }

      // 7. SPECIFIC COMPANY SEARCH
      const matchedApp = applications.find(a => query.includes(a.company.toLowerCase()));
      if (matchedApp) {
        setMessages(prev => [
          ...prev,
          {
            id: generateRandomId('bot'),
            sender: 'bot',
            text: `Here is the current tracking file for **${matchedApp.company}**:`,
            timestamp: getNow(),
            isCustomReport: true,
            reportType: 'opportunity',
            reportData: matchedApp
          }
        ]);
        setIsTyping(false);
        return;
      }

      // 8. INTERVIEW PREP
      if (query.includes('prep') || query.includes('prepare') || query.includes('checklist')) {
        setMessages(prev => [
          ...prev,
          {
            id: generateRandomId('bot'),
            sender: 'bot',
            text: "### 🏆 1% Elite Prep Checklist\n\n1. **System Design**: Focus on databases (SQL vs NoSQL), scaling (sharding, indices, caching with Redis), and message queues (Kafka/RabbitMQ).\n2. **DSA Core**: Sliding window, graph traversals (BFS/DFS), Dynamic Programming, and heaps/priority queues.\n3. **STAR Stories**: Prepare three solid scenarios detailing complex engineering trade-offs, system failures, and conflict resolution.\n4. **Framework Mastery**: Deep knowledge of React 19 concurrent features, hydration details, and Next.js App Router render cycles.",
            timestamp: getNow()
          }
        ]);
        setIsTyping(false);
        return;
      }

      // 9. FALLBACK SEARCH across all records
      const matches = applications.filter(a => 
        a.company.toLowerCase().includes(query) ||
        a.role.toLowerCase().includes(query) ||
        (a.recruiterName && a.recruiterName.toLowerCase().includes(query)) ||
        (a.notes && a.notes.toLowerCase().includes(query))
      );

      if (matches.length > 0) {
        setMessages(prev => [
          ...prev,
          {
            id: generateRandomId('bot'),
            sender: 'bot',
            text: `Found **${matches.length} matching applications** for your query:`,
            timestamp: getNow(),
            isCustomReport: true,
            reportType: 'table',
            reportData: matches.map(a => ({
              id: a.id,
              company: a.company,
              role: a.role,
              stage: a.status,
              phone: a.recruiterPhone,
              name: a.recruiterName,
              email: a.recruiterEmail
            }))
          }
        ]);
      } else {
        setMessages(prev => [
          ...prev,
          {
            id: generateRandomId('bot'),
            sender: 'bot',
            text: "I couldn't match your request to any command or database record. You can try:\n- Searching for a company name (e.g. `Google` or `Apple`)\n- Adding/updating items (e.g. `add job for Notion as Engineer` or `set Google to Screening`)\n- Viewing lists (e.g. `pipeline summary`, `show active interviews`, `who needs follow up?`)",
            timestamp: getNow()
          }
        ]);
      }
      setIsTyping(false);
    } catch (e) {
      console.error(e);
      setMessages(prev => [
        ...prev,
        {
          id: generateRandomId('bot'),
          sender: 'bot',
          text: "⚠️ An error occurred while communicating with the Notion DB server action. Please try again.",
          timestamp: getNow()
        }
      ]);
      setIsTyping(false);
    }
  };

  return (
    <div className="flex flex-col h-[calc(100dvh-5rem)] lg:h-[calc(100vh-2.5rem)] max-w-4xl mx-auto relative animate-fade-in overflow-hidden -mb-4 md:-mb-8 lg:-mb-10">
      {/* Minimal Inline Header Row */}
      <div className="flex items-center justify-between py-3 border-b border-card-border/40 font-mono text-[10px] text-muted-foreground shrink-0 px-1 select-none">
        <div className="flex items-center gap-1.5 font-bold uppercase tracking-wider">
          <span className="flex h-1.5 w-1.5 relative">
            <span className="animate-ping absolute inline-flex h-full w-full rounded-full bg-emerald-400 opacity-75"></span>
            <span className="relative inline-flex rounded-full h-1.5 w-1.5 bg-emerald-500"></span>
          </span>
          AI Job Assistant
        </div>
        <div className="flex items-center gap-4">
          <span className="hidden sm:inline">Active: <span className="text-accent-blue font-bold">{metrics.totalOpportunities}</span></span>
          <span className="hidden sm:inline text-card-border/60">•</span>
          <span className="hidden sm:inline">Interviews: <span className="text-accent-amber font-bold">{metrics.interviewsCount}</span></span>
          <span className="hidden sm:inline text-card-border/60">•</span>
          <button 
            onClick={handleReloadSession}
            disabled={isTyping}
            className="flex items-center gap-1 hover:text-foreground transition-colors disabled:opacity-50 cursor-pointer uppercase tracking-wider font-bold"
            title="Sync Notion DB"
          >
            <RefreshCw size={10} className={isTyping ? 'animate-spin text-accent-blue' : ''} />
            <span>Sync Notion DB</span>
          </button>
        </div>
      </div>

      {/* Messages */}
      <div className="flex-1 overflow-y-auto py-6 px-1 space-y-6 custom-scrollbar bg-transparent">
        {messages.map((msg) => (
          <div
            key={msg.id}
            className={`flex gap-4 max-w-[90%] ${
              msg.sender === 'user' ? 'ml-auto flex-row-reverse' : 'mr-auto'
            }`}
          >
            {/* Circular Avatar */}
            <div className={`w-8.5 h-8.5 rounded-full shrink-0 flex items-center justify-center border shadow-sm ${
              msg.sender === 'user' 
                ? 'bg-slate-100 dark:bg-zinc-800 border-slate-200 dark:border-zinc-700 text-foreground' 
                : 'bg-indigo-600 border-indigo-500 text-white'
            }`}>
              {msg.sender === 'user' ? <User size={14} /> : <Bot size={14} />}
            </div>

            {/* Bubble */}
            <div className="space-y-3 w-full">
              {/* Text Bubble */}
              <div className={`p-4 rounded-3xl leading-relaxed text-[13px] font-sans ${
                msg.sender === 'user'
                  ? 'bg-gradient-to-r from-blue-700 to-indigo-600 text-white rounded-tr-none shadow-md shadow-indigo-600/5 font-semibold'
                  : 'bg-card border border-card-border text-foreground rounded-tl-none font-medium'
              }`}>
                <div className="whitespace-pre-line leading-relaxed">
                  {msg.text}
                </div>
              </div>

              {/* Custom Structured Report Blocks */}
              {msg.isCustomReport && msg.reportType === 'metrics' && (
                <div className="grid grid-cols-2 gap-3 max-w-md animate-slide-down">
                  <div className="p-3.5 rounded-2xl bg-card border border-card-border shadow-sm">
                    <div className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Active Tracks</div>
                    <div className="text-xl font-bold font-mono text-accent-blue mt-1 flex items-center gap-1.5">
                      <Sliders size={16} />
                      {msg.reportData.total}
                    </div>
                  </div>
                  <div className="p-3.5 rounded-2xl bg-card border border-card-border shadow-sm">
                    <div className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">HR Screenings</div>
                    <div className="text-xl font-bold font-mono text-accent-purple mt-1 flex items-center gap-1.5">
                      <Calendar size={16} />
                      {msg.reportData.screening}
                    </div>
                  </div>
                  <div className="p-3.5 rounded-2xl bg-card border border-card-border shadow-sm">
                    <div className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Interview Loops</div>
                    <div className="text-xl font-bold font-mono text-accent-amber mt-1 flex items-center gap-1.5">
                      <TrendingUp size={16} />
                      {msg.reportData.interviews}
                    </div>
                  </div>
                  <div className="p-3.5 rounded-2xl bg-card border border-card-border shadow-sm">
                    <div className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Offers Secured</div>
                    <div className="text-xl font-bold font-mono text-accent-emerald mt-1 flex items-center gap-1.5">
                      <CheckCircle size={16} />
                      {msg.reportData.offers}
                    </div>
                  </div>
                </div>
              )}

              {msg.isCustomReport && msg.reportType === 'success' && (
                <div className="p-4 rounded-2xl bg-emerald-500/[0.04] dark:bg-emerald-500/[0.02] border border-emerald-500/30 flex items-start gap-3 max-w-md animate-slide-down">
                  <CheckCircle size={18} className="text-emerald-500 shrink-0 mt-0.5" />
                  <div className="space-y-1.5 flex-1">
                    <h4 className="text-xs font-bold font-mono text-emerald-600 dark:text-emerald-400 uppercase tracking-wider">
                      {msg.reportData.title}
                    </h4>
                    <table className="w-full text-[11px] text-muted-foreground font-mono">
                      <tbody>
                        <tr>
                          <td className="py-0.5 text-slate-400 dark:text-zinc-500 font-bold uppercase pr-2">Company:</td>
                          <td className="py-0.5 text-foreground font-black">{msg.reportData.company}</td>
                        </tr>
                        <tr>
                          <td className="py-0.5 text-slate-400 dark:text-zinc-500 font-bold uppercase pr-2">Role:</td>
                          <td className="py-0.5 text-foreground font-bold">{msg.reportData.role}</td>
                        </tr>
                        <tr>
                          <td className="py-0.5 text-slate-400 dark:text-zinc-500 font-bold uppercase pr-2">Stage:</td>
                          <td className="py-0.5 text-foreground font-bold">{msg.reportData.status}</td>
                        </tr>
                        {msg.reportData.priority && (
                          <tr>
                            <td className="py-0.5 text-slate-400 dark:text-zinc-500 font-bold uppercase pr-2">Priority:</td>
                            <td className="py-0.5 text-foreground font-bold">{msg.reportData.priority}</td>
                          </tr>
                        )}
                      </tbody>
                    </table>
                  </div>
                </div>
              )}

              {msg.isCustomReport && msg.reportType === 'opportunity' && (
                <div className="p-4 rounded-2xl bg-card border border-card-border max-w-lg space-y-3 shadow-sm animate-slide-down">
                  <div className="flex justify-between items-start gap-4">
                    <div>
                      <h4 className="text-xs font-bold text-foreground font-sans">{msg.reportData.role}</h4>
                      <p className="text-[11px] text-muted-foreground font-semibold mt-0.5">{msg.reportData.company}</p>
                    </div>
                    <span className="px-2.5 py-0.5 rounded-full text-[9px] font-mono font-bold bg-accent-blue/10 text-accent-blue border border-accent-blue/20">
                      {msg.reportData.type}
                    </span>
                  </div>

                  <table className="w-full text-[11px] text-muted-foreground border-t border-card-border/50 pt-2 font-mono">
                    <tbody>
                      <tr>
                        <td className="py-1 text-slate-400 dark:text-zinc-500 uppercase font-bold">Stage:</td>
                        <td className="py-1 text-foreground font-bold">{msg.reportData.status}</td>
                      </tr>
                      {msg.reportData.salary && (
                        <tr>
                          <td className="py-1 text-slate-400 dark:text-zinc-500 uppercase font-bold">Salary:</td>
                          <td className="py-1 text-foreground font-bold">{msg.reportData.salary}</td>
                        </tr>
                      )}
                      {msg.reportData.recruiterName && (
                        <tr>
                          <td className="py-1 text-slate-400 dark:text-zinc-500 uppercase font-bold">Recruiter:</td>
                          <td className="py-1 text-foreground font-bold">{msg.reportData.recruiterName}</td>
                        </tr>
                      )}
                      {msg.reportData.lastContactedDate && (
                        <tr>
                          <td className="py-1 text-slate-400 dark:text-zinc-500 uppercase font-bold">Last Contact:</td>
                          <td className="py-1 text-foreground font-bold">{new Date(msg.reportData.lastContactedDate).toLocaleDateString()}</td>
                        </tr>
                      )}
                    </tbody>
                  </table>

                  {msg.reportData.recruiterPhone && (
                    <div className="flex items-center gap-1.5 pt-2 border-t border-card-border/50">
                      <button
                        onClick={() => triggerPhone(msg.reportData.recruiterPhone)}
                        className="comm-btn-pill hover:bg-green-500/10 border border-card-border/50 hover:border-green-500/20 rounded bg-card/50 text-green-500 transition-colors"
                      >
                        <Phone size={10} />
                        <span className="text-[9px] font-bold uppercase tracking-wider">Call</span>
                      </button>
                      <button
                        onClick={() => triggerWhatsApp(msg.reportData.recruiterPhone, msg.reportData.recruiterName)}
                        className="comm-btn-pill hover:bg-emerald-500/10 border border-card-border/50 hover:border-emerald-500/20 rounded bg-card/50 text-emerald-500 transition-colors"
                      >
                        <MessageCircle size={10} />
                        <span className="text-[9px] font-bold uppercase tracking-wider">WhatsApp</span>
                      </button>
                      <button
                        onClick={() => triggerSMS(msg.reportData.recruiterPhone, msg.reportData.recruiterName)}
                        className="comm-btn-pill hover:bg-sky-500/10 border border-card-border/50 hover:border-sky-500/20 rounded bg-card/50 text-sky-500 transition-colors"
                      >
                        <MessageSquare size={10} />
                        <span className="text-[9px] font-bold uppercase tracking-wider">SMS</span>
                      </button>
                    </div>
                  )}
                </div>
              )}

              {msg.isCustomReport && msg.reportType === 'table' && (
                <div className="overflow-x-auto border border-card-border bg-card rounded-2xl shadow-sm max-w-full animate-slide-down">
                  <table className="w-full text-left text-[11px] font-mono border-collapse">
                    <thead>
                      <tr className="border-b border-card-border bg-slate-100/50 dark:bg-zinc-800/50 text-slate-500 dark:text-zinc-400 font-bold uppercase tracking-wider">
                        <th className="px-4 py-2.5">Company</th>
                        <th className="px-4 py-2.5">Role</th>
                        <th className="px-4 py-2.5">Stage</th>
                        <th className="px-4 py-2.5 text-center">Outreach</th>
                      </tr>
                    </thead>
                    <tbody className="divide-y divide-card-border/50 text-foreground">
                      {(msg.reportData as Array<{
                        id: string;
                        company: string;
                        role: string;
                        stage: string;
                        phone?: string;
                        name?: string;
                        email?: string;
                      }>).map((item, idx) => (
                        <tr key={idx} className="hover:bg-foreground/[0.01] transition-colors">
                          <td className="px-4 py-3 font-bold">{item.company}</td>
                          <td className="px-4 py-3 text-slate-650 dark:text-zinc-350">{item.role}</td>
                          <td className="px-4 py-3 font-bold text-accent-blue">{item.stage}</td>
                          <td className="px-4 py-3">
                            {item.phone ? (
                              <div className="flex items-center justify-center gap-1">
                                <button
                                  onClick={() => triggerWhatsApp(item.phone, item.name)}
                                  className="p-1.5 rounded-lg bg-emerald-500/10 hover:bg-emerald-500/20 text-emerald-500 transition-colors flex items-center justify-center cursor-pointer"
                                  title="WhatsApp"
                                >
                                  <MessageCircle size={11} />
                                </button>
                                <button
                                  onClick={() => triggerSMS(item.phone, item.name)}
                                  className="p-1.5 rounded-lg bg-sky-500/10 hover:bg-sky-500/20 text-sky-500 transition-colors flex items-center justify-center cursor-pointer"
                                  title="SMS"
                                >
                                  <MessageSquare size={11} />
                                </button>
                              </div>
                            ) : item.email ? (
                              <div className="flex items-center justify-center">
                                <button
                                  onClick={() => triggerGmail(item.email, item.name)}
                                  className="p-1.5 rounded-lg bg-indigo-500/10 hover:bg-indigo-500/20 text-indigo-500 transition-colors flex items-center justify-center cursor-pointer"
                                  title="Compose Gmail"
                                >
                                  <Mail size={11} />
                                </button>
                              </div>
                            ) : (
                              <div className="text-center text-slate-400 dark:text-zinc-650 italic">None</div>
                            )}
                          </td>
                        </tr>
                      ))}
                    </tbody>
                  </table>
                </div>
              )}
            </div>
          </div>
        ))}

        {/* Typing */}
        {isTyping && (
          <div className="flex gap-4 max-w-[90%] mr-auto">
            <div className="w-8.5 h-8.5 rounded-full bg-indigo-600 text-white flex items-center justify-center border border-indigo-500 shrink-0">
              <Bot size={14} />
            </div>
            <div className="bg-card border border-card-border text-foreground p-4 rounded-3xl rounded-tl-none flex items-center gap-1.5 shadow-sm">
              <span className="w-1.5 h-1.5 rounded-full bg-foreground/60 animate-bounce" style={{ animationDelay: '0ms' }} />
              <span className="w-1.5 h-1.5 rounded-full bg-foreground/60 animate-bounce" style={{ animationDelay: '150ms' }} />
              <span className="w-1.5 h-1.5 rounded-full bg-foreground/60 animate-bounce" style={{ animationDelay: '300ms' }} />
            </div>
          </div>
        )}
        <div ref={chatEndRef} />
      </div>

      {/* Suggested Chips */}
      <div className="py-2.5 flex flex-wrap gap-2 shrink-0 px-1">
        {quickChips.map((chip, idx) => (
          <button
            key={idx}
            onClick={() => handleSendMessage(chip.query)}
            disabled={isTyping}
            className="px-3.5 py-2 rounded-xl border border-card-border bg-card hover:bg-slate-50 dark:hover:bg-zinc-800 hover:border-accent-blue text-[10px] font-bold text-muted-foreground hover:text-foreground transition-all cursor-pointer shadow-sm active:scale-95 flex items-center gap-1 font-mono uppercase tracking-wider"
          >
            {chip.label}
          </button>
        ))}
      </div>

      {/* Input Form */}
      <form
        onSubmit={(e) => {
          e.preventDefault();
          handleSendMessage(inputValue);
        }}
        className="pt-2 pb-2 md:pb-4 bg-transparent flex gap-3 items-center z-10 w-full px-1 shrink-0"
      >
        <div className="relative flex-1 flex items-center w-full">
          <input
            type="text"
            value={inputValue}
            onChange={(e) => setInputValue(e.target.value)}
            disabled={isTyping}
            placeholder="Ask about opportunities, search recruiter files, add or update status..."
            className="w-full pl-4 pr-12 py-3 bg-card border border-card-border hover:border-card-border/80 rounded-2xl focus:outline-none focus:ring-4 focus:ring-accent-blue/5 focus:border-accent-blue transition-all duration-200 text-xs font-semibold text-foreground placeholder:text-muted-foreground/50 h-11 shadow-sm"
          />
          <button
            type="submit"
            disabled={!inputValue.trim() || isTyping}
            className="absolute right-1.5 top-1/2 -translate-y-1/2 h-8 w-8 bg-gradient-to-r from-blue-700 to-indigo-600 hover:opacity-90 text-white rounded-xl shadow-md active:scale-95 disabled:opacity-40 disabled:pointer-events-none transition-all flex items-center justify-center cursor-pointer border-0"
          >
            <Send size={12} />
          </button>
        </div>
      </form>
    </div>
  );
}
