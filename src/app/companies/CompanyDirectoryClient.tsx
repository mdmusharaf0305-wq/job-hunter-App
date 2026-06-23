'use client';

import { useState, useMemo, useCallback, useEffect, useRef } from 'react';
import {
  Search,
  ExternalLink,
  Plus,
  X,
} from 'lucide-react';
import { CompanyCardData, updateCompanyWatchlistDetailsAction } from '../../actions/companyDirectoryActions';
import { addCompanyToConfigAction } from '../../actions/companyActions';
import { NotionSchemaOptions } from '../../lib/notion/client';
import { useRouter } from 'next/navigation';
import CustomSelect from '../../components/CustomSelect';

type Props = {
  initialCompanies: CompanyCardData[];
  dbOptions?: NotionSchemaOptions | null;
};

// Fallback static options if DB not configured
const FALLBACK_TYPE_OPTIONS = ['Product Based', 'Service Based', 'Startup', 'MNC', 'Unknown'];
const FALLBACK_SIZE_OPTIONS = ['1–10', '11–50', '51–200', '201–500', '501–1,000', '1,001–5,000', '5,001–10,000', '10,001+'];

export default function CompanyDirectoryClient({ initialCompanies, dbOptions }: Props) {
  const router = useRouter();
  const [companies, setCompanies] = useState<CompanyCardData[]>(initialCompanies);
  const [search, setSearch] = useState('');
  const [typeFilter, setTypeFilter] = useState('All');
  const [sortBy, setSortBy] = useState<'name' | 'rating'>('name');


  // Dynamic options from DB or fallback
  const typeOptions = (dbOptions?.companyTypes && dbOptions.companyTypes.length > 0)
    ? dbOptions.companyTypes
    : FALLBACK_TYPE_OPTIONS;
  const sizeOptions = (dbOptions?.companySizes && dbOptions.companySizes.length > 0)
    ? dbOptions.companySizes
    : FALLBACK_SIZE_OPTIONS;

  // Inline edit state
  const [savingCard, setSavingCard] = useState<string | null>(null);
  const [saveErrors, setSaveErrors] = useState<Record<string, string | null>>({});

  // Add company modal
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [name, setName] = useState('');
  const [tier, setTier] = useState(3);
  const [techStack, setTechStack] = useState('');
  const [website, setWebsite] = useState('');
  const [headquarters, setHeadquarters] = useState('');
  const [ats, setAts] = useState('');
  const [slug, setSlug] = useState('');
  const [board, setBoard] = useState('');
  const [isRemote, setIsRemote] = useState(false);
  const [isHybrid, setIsHybrid] = useState(true);
  const [isOnsite, setIsOnsite] = useState(false);
  const [hiringFrequency, setHiringFrequency] = useState(75);
  const [salaryPotential, setSalaryPotential] = useState(80);
  const [engineeringCulture, setEngineeringCulture] = useState(80);
  const [growthPotential, setGrowthPotential] = useState(80);

  const filteredCompanies = useMemo(() => {
    const filtered = companies.filter((c) => {
      const matchesSearch =
        c.name.toLowerCase().includes(search.toLowerCase()) ||
        c.locations.some((l) => l.toLowerCase().includes(search.toLowerCase()));
      const matchesType = typeFilter === 'All' || c.type === typeFilter;
      return matchesSearch && matchesType;
    });
    if (sortBy === 'name') return [...filtered].sort((a, b) => a.name.localeCompare(b.name));
    return [...filtered].sort((a, b) => b.overallRating - a.overallRating);
  }, [companies, search, typeFilter, sortBy]);

  const handleUpdateCompanyType = useCallback(async (company: CompanyCardData, newType: string) => {
    setSavingCard(`${company.name}-type`);
    setSaveErrors((prev) => ({ ...prev, [company.name]: null }));
    try {
      const ok = await updateCompanyWatchlistDetailsAction(
        company.name,
        newType,
        company.employeeCount || '',
        company.applicationId
      );
      if (ok) {
        setCompanies((prev) =>
          prev.map((co) =>
            co.name === company.name ? { ...co, type: newType as CompanyCardData['type'] } : co
          )
        );
      } else {
        setSaveErrors((prev) => ({ ...prev, [company.name]: 'Save failed — check Notion connection.' }));
      }
    } catch {
      setSaveErrors((prev) => ({ ...prev, [company.name]: 'Save failed — check Notion connection.' }));
    } finally {
      setSavingCard(null);
    }
  }, []);

  const handleUpdateCompanySize = useCallback(async (company: CompanyCardData, newSize: string) => {
    setSavingCard(`${company.name}-size`);
    setSaveErrors((prev) => ({ ...prev, [company.name]: null }));
    try {
      const ok = await updateCompanyWatchlistDetailsAction(
        company.name,
        company.type || '',
        newSize,
        company.applicationId
      );
      if (ok) {
        setCompanies((prev) =>
          prev.map((co) =>
            co.name === company.name ? { ...co, employeeCount: newSize } : co
          )
        );
      } else {
        setSaveErrors((prev) => ({ ...prev, [company.name]: 'Save failed — check Notion connection.' }));
      }
    } catch {
      setSaveErrors((prev) => ({ ...prev, [company.name]: 'Save failed — check Notion connection.' }));
    } finally {
      setSavingCard(null);
    }
  }, []);

  const handleAddCompany = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!name.trim()) return;
    setIsSubmitting(true);
    const remoteFlexibility: string[] = [];
    if (isRemote) remoteFlexibility.push('Remote');
    if (isHybrid) remoteFlexibility.push('Hybrid');
    if (isOnsite) remoteFlexibility.push('Onsite');
    if (remoteFlexibility.length === 0) remoteFlexibility.push('Hybrid');
    const formattedCompany = {
      name: name.trim(), tier,
      techStack: techStack.split(',').map((s) => s.trim()).filter(Boolean),
      hiringFrequency, salaryPotential, engineeringCulture, remoteFlexibility, growthPotential,
      website: website.trim() || `https://www.google.com/search?q=${encodeURIComponent(name.trim())}+careers`,
      headquarters: headquarters.trim() || 'Bengaluru, India',
      ats: ats || undefined, slug: slug.trim() || undefined, board: board.trim() || undefined,
    };
    try {
      const success = await addCompanyToConfigAction(formattedCompany);
      if (success) {
        setIsModalOpen(false);
        setName(''); setTechStack(''); setWebsite(''); setHeadquarters('');
        setAts(''); setSlug(''); setBoard('');
        setIsRemote(false); setIsHybrid(true); setIsOnsite(false);
        setHiringFrequency(75); setSalaryPotential(80); setEngineeringCulture(80); setGrowthPotential(80);
        router.refresh();
      } else {
        alert('Company already exists or failed to save.');
      }
    } catch (err) {
      console.error(err);
      alert('Error occurred while adding company.');
    } finally {
      setIsSubmitting(false);
    }
  };

  const isCompanyFormDirty = () => {
    return (
      name !== '' ||
      techStack !== '' ||
      website !== '' ||
      headquarters !== '' ||
      ats !== '' ||
      slug !== '' ||
      board !== ''
    );
  };

  const handleCompanyModalClose = () => {
    if (isCompanyFormDirty()) {
      if (window.confirm('You have unsaved changes. Are you sure you want to discard them?')) {
        setIsModalOpen(false);
      }
    } else {
      setIsModalOpen(false);
    }
  };

  const handleCompanyModalCloseRef = useRef(handleCompanyModalClose);
  useEffect(() => {
    handleCompanyModalCloseRef.current = handleCompanyModalClose;
  });

  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape' && isModalOpen) {
        handleCompanyModalCloseRef.current();
      }
    };
    window.addEventListener('keydown', handleKeyDown);
    return () => {
      window.removeEventListener('keydown', handleKeyDown);
    };
  }, [isModalOpen]);

  return (
    <div className="space-y-5 w-full max-w-full overflow-hidden">
      {/* Page Header */}
      <div className="border-b border-card-border pb-5 flex flex-col sm:flex-row justify-between items-start sm:items-center gap-3">
        <div>
          <h2 className="text-2xl font-bold tracking-tight text-foreground font-mono flex items-center gap-2">
            🏢 Company Watchlist &amp; Intelligence
          </h2>
          <p className="text-xs text-muted-foreground font-mono mt-1">
            Realtime directory of direct employers matched against your skills.
          </p>
        </div>
        <button
          onClick={() => setIsModalOpen(true)}
          className="flex items-center gap-2 bg-primary text-primary-foreground px-4 py-2.5 rounded-xl font-bold font-mono text-xs shadow-md hover:bg-primary/90 transition-all cursor-pointer border-0 shrink-0"
        >
          <Plus size={14} />
          Add Company
        </button>
      </div>

      {/* Filters */}
      <div className="flex flex-col gap-3 w-full">
        <div className="relative w-full">
          <Search className="absolute left-3.5 top-1/2 -translate-y-1/2 text-muted-foreground" size={16} />
          <input
            type="text"
            placeholder="Search by company or location..."
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 bg-card border border-card-border rounded-xl text-sm font-mono text-foreground placeholder:text-muted-foreground focus:outline-none focus:border-primary transition-colors"
          />
        </div>
        {/* Unified Filter & Sort Bar (side-by-side directly on all screens) */}
        <div className="flex flex-wrap items-center gap-2.5 bg-card/30 p-2 md:p-1.5 rounded-2xl border border-card-border/60 w-full">
          <div className="flex items-center gap-1.5 py-0.5">
            <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Sort:</span>
            <CustomSelect
              value={sortBy}
              onChange={(val) => setSortBy(val as 'name' | 'rating')}
              options={[
                { value: 'name', label: 'A–Z' },
                { value: 'rating', label: 'Rating' }
              ]}
              label="Sort watchlist"
              className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1.5 text-foreground focus:outline-none focus:border-primary cursor-pointer appearance-none text-center"
            />
          </div>

          <div className="flex items-center gap-1.5 py-0.5">
            <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Type:</span>
            <CustomSelect
              value={typeFilter}
              onChange={(val) => setTypeFilter(val)}
              options={['All', ...typeOptions]}
              label="Company Type Filter"
              className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1.5 text-foreground focus:outline-none focus:border-primary cursor-pointer appearance-none text-center"
            />
          </div>
        </div>
      </div>

      {/* Grid */}
      {filteredCompanies.length === 0 ? (
        <div className="text-center py-20 bg-card/50 border border-card-border border-dashed rounded-3xl">
          <p className="text-sm font-mono text-muted-foreground">No companies match your filters.</p>
        </div>
      ) : (
        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-2.5 w-full">
          {filteredCompanies.map((c) => {
            const isSavingType = savingCard === `${c.name}-type`;
            const isSavingSize = savingCard === `${c.name}-size`;

            return (
              <div
                key={c.name}
                className="bg-card border border-card-border rounded-2xl p-2.5 hover:border-primary/50 transition-all duration-300 hover:shadow-lg hover:shadow-primary/5 flex flex-col justify-between min-w-0 w-full max-w-[155px] mx-auto"
              >
                <div className="min-w-0">
                  {/* Header row */}
                  <div className="flex justify-between items-start gap-1 mb-2 pb-1.5 border-b border-card-border/60">
                    <h3 className="text-[11px] font-bold text-foreground font-sans tracking-tight line-clamp-2 leading-tight min-w-0 flex-1">
                      {c.name}
                    </h3>
                  </div>

                  {/* Inline Edit Controls */}
                  <div className="space-y-1.5 mb-2">
                    {/* Company Type */}
                    <div className="flex flex-col gap-0.5">
                      <label className="text-[7px] font-mono text-muted-foreground uppercase font-bold">
                        Company Type {isSavingType && <span className="text-accent-blue animate-pulse">...</span>}
                      </label>
                      <CustomSelect
                        value={c.type || ''}
                        onChange={(val) => handleUpdateCompanyType(c, val)}
                        disabled={isSavingType}
                        options={typeOptions}
                        placeholder="— Select —"
                        label="Company Type"
                        className="w-full px-2 py-0.5 bg-foreground/[0.04] dark:bg-white/[0.04] border border-card-border rounded-full text-[9px] font-mono text-foreground focus:outline-none focus:border-primary cursor-pointer text-center w-full"
                      />
                    </div>

                    {/* Company Count */}
                    <div className="flex flex-col gap-0.5">
                      <label className="text-[7px] font-mono text-muted-foreground uppercase font-bold">
                        Company Count {isSavingSize && <span className="text-accent-blue animate-pulse">...</span>}
                      </label>
                      <CustomSelect
                        value={c.employeeCount || ''}
                        onChange={(val) => handleUpdateCompanySize(c, val)}
                        disabled={isSavingSize}
                        options={sizeOptions}
                        placeholder="— Select —"
                        label="Company Count"
                        className="w-full px-2 py-0.5 bg-foreground/[0.04] dark:bg-white/[0.04] border border-card-border rounded-full text-[9px] font-mono text-foreground focus:outline-none focus:border-primary cursor-pointer text-center w-full"
                      />
                    </div>

                    {saveErrors[c.name] && (
                      <p className="text-[8px] text-red-500 font-mono mt-0.5 leading-tight">{saveErrors[c.name]}</p>
                    )}
                  </div>
                </div>

                {/* Careers link */}
                <a
                  href={c.careerUrl}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="mt-auto w-full py-1.5 bg-primary text-primary-foreground text-center rounded-xl text-[9px] font-mono font-bold tracking-wider uppercase transition-all flex items-center justify-center gap-1 cursor-pointer hover:shadow-md active:scale-95 border-0 hover:bg-primary/90"
                >
                  Careers <ExternalLink size={8} />
                </a>
              </div>
            );
          })}
        </div>
      )}

      {/* Add Company Modal */}
      {isModalOpen && (
        <div className="fixed inset-0 z-50 flex items-start justify-center p-4 pt-[60px] pb-10 overflow-y-auto">
          <div className="fixed inset-0 bg-black/50 transition-opacity duration-300 cursor-pointer" onClick={handleCompanyModalClose} />
          <div className="relative bg-card w-full max-w-lg rounded-3xl overflow-hidden shadow-[0_40px_80px_-20px_rgba(0,0,0,0.3)] dark:shadow-[0_40px_80px_-20px_rgba(0,0,0,0.7)] border border-card-border flex flex-col max-h-[calc(100vh-100px)] animate-slide-down z-10">
            <div className="p-5 border-b border-card-border flex items-center justify-between bg-card">
              <h3 className="text-sm font-bold text-foreground font-mono uppercase tracking-wide">Add Watchlist Company</h3>
              <button onClick={handleCompanyModalClose} className="text-muted-foreground hover:text-foreground transition-colors border-0 bg-transparent cursor-pointer"><X size={16} /></button>
            </div>
            <form onSubmit={handleAddCompany} className="p-5 space-y-4 overflow-y-auto flex-1 text-xs">
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1">
                  <label className="font-mono text-xs text-muted-foreground font-bold uppercase">Company Name *</label>
                  <input type="text" required placeholder="e.g. Swiggy" value={name} onChange={(e) => setName(e.target.value)} className="w-full px-3 py-2 bg-foreground/[0.02] border border-card-border rounded-xl text-foreground focus:outline-none focus:border-primary" />
                </div>
                <div className="space-y-1">
                  <label className="font-mono text-xs text-muted-foreground font-bold uppercase">Watchlist Tier</label>
                  <select value={tier} onChange={(e) => setTier(Number(e.target.value))} className="w-full px-3 py-2 bg-card border border-card-border rounded-xl text-foreground focus:outline-none focus:border-primary">
                    <option value="1">Tier 1 (MAANG & Elite)</option>
                    <option value="2">Tier 2 (High-Growth Tech)</option>
                    <option value="3">Tier 3 (Startups & Mid-Market)</option>
                    <option value="4">Tier 4 (IT Services & Agencies)</option>
                    <option value="5">Tier 5 (Hidden Gems / Niche)</option>
                  </select>
                </div>
              </div>
              <div className="space-y-1">
                <label className="font-mono text-xs text-muted-foreground font-bold uppercase">Tech Stack (Comma Separated)</label>
                <input type="text" placeholder="e.g. React.js, TypeScript, Node.js" value={techStack} onChange={(e) => setTechStack(e.target.value)} className="w-full px-3 py-2 bg-foreground/[0.02] border border-card-border rounded-xl text-foreground focus:outline-none focus:border-primary" />
              </div>
              <div className="grid grid-cols-2 gap-4">
                <div className="space-y-1">
                  <label className="font-mono text-xs text-muted-foreground font-bold uppercase">Careers Website</label>
                  <input type="url" placeholder="https://careers.company.com" value={website} onChange={(e) => setWebsite(e.target.value)} className="w-full px-3 py-2 bg-foreground/[0.02] border border-card-border rounded-xl text-foreground focus:outline-none focus:border-primary" />
                </div>
                <div className="space-y-1">
                  <label className="font-mono text-xs text-muted-foreground font-bold uppercase">Headquarters</label>
                  <input type="text" placeholder="e.g. Bengaluru, India" value={headquarters} onChange={(e) => setHeadquarters(e.target.value)} className="w-full px-3 py-2 bg-foreground/[0.02] border border-card-border rounded-xl text-foreground focus:outline-none focus:border-primary" />
                </div>
              </div>
              <div className="p-3 bg-foreground/[0.02] border border-card-border rounded-2xl space-y-3">
                <h4 className="font-mono text-xs text-muted-foreground font-bold uppercase">ATS Platform & Scraping</h4>
                <div className="grid grid-cols-3 gap-3">
                  <div className="space-y-1">
                    <label className="font-mono text-[10px] text-muted-foreground uppercase">Platform</label>
                    <select value={ats} onChange={(e) => setAts(e.target.value)} className="w-full px-2 py-1.5 bg-card border border-card-border rounded-lg text-foreground focus:outline-none focus:border-primary">
                      <option value="">None / Manual</option>
                      <option value="greenhouse">Greenhouse</option>
                      <option value="lever">Lever</option>
                      <option value="ashby">Ashby</option>
                      <option value="workday">Workday</option>
                      <option value="smartrecruiters">SmartRecruiters</option>
                      <option value="bamboohr">BambooHR</option>
                      <option value="rippling">Rippling</option>
                      <option value="workable">Workable</option>
                    </select>
                  </div>
                  <div className="space-y-1">
                    <label className="font-mono text-[10px] text-muted-foreground uppercase">Slug</label>
                    <input type="text" placeholder="e.g. razorpay" value={slug} onChange={(e) => setSlug(e.target.value)} className="w-full px-2 py-1 bg-card border border-card-border rounded-lg text-foreground focus:outline-none focus:border-primary" />
                  </div>
                  <div className="space-y-1">
                    <label className="font-mono text-[10px] text-muted-foreground uppercase">Board</label>
                    <input type="text" placeholder="e.g. Careers" value={board} onChange={(e) => setBoard(e.target.value)} className="w-full px-2 py-1 bg-card border border-card-border rounded-lg text-foreground focus:outline-none focus:border-primary" />
                  </div>
                </div>
              </div>
              <div className="space-y-1">
                <label className="font-mono text-xs text-muted-foreground font-bold uppercase block">Remote Flexibility</label>
                <div className="flex gap-4 font-mono">
                  <label className="flex items-center gap-1.5 cursor-pointer"><input type="checkbox" checked={isRemote} onChange={(e) => setIsRemote(e.target.checked)} className="rounded" /> Remote</label>
                  <label className="flex items-center gap-1.5 cursor-pointer"><input type="checkbox" checked={isHybrid} onChange={(e) => setIsHybrid(e.target.checked)} className="rounded" /> Hybrid</label>
                  <label className="flex items-center gap-1.5 cursor-pointer"><input type="checkbox" checked={isOnsite} onChange={(e) => setIsOnsite(e.target.checked)} className="rounded" /> Onsite</label>
                </div>
              </div>
              <div className="grid grid-cols-2 gap-4 pt-2">
                <div className="space-y-1">
                  <label className="font-mono text-xs text-muted-foreground font-bold uppercase block">Hiring Freq: {hiringFrequency}%</label>
                  <input type="range" min="0" max="100" value={hiringFrequency} onChange={(e) => setHiringFrequency(Number(e.target.value))} className="w-full" />
                </div>
                <div className="space-y-1">
                  <label className="font-mono text-xs text-muted-foreground font-bold uppercase block">Salary: {salaryPotential}%</label>
                  <input type="range" min="0" max="100" value={salaryPotential} onChange={(e) => setSalaryPotential(Number(e.target.value))} className="w-full" />
                </div>
                <div className="space-y-1">
                  <label className="font-mono text-xs text-muted-foreground font-bold uppercase block">Eng Culture: {engineeringCulture}%</label>
                  <input type="range" min="0" max="100" value={engineeringCulture} onChange={(e) => setEngineeringCulture(Number(e.target.value))} className="w-full" />
                </div>
                <div className="space-y-1">
                  <label className="font-mono text-xs text-muted-foreground font-bold uppercase block">Growth: {growthPotential}%</label>
                  <input type="range" min="0" max="100" value={growthPotential} onChange={(e) => setGrowthPotential(Number(e.target.value))} className="w-full" />
                </div>
              </div>
              <div className="p-3 border-t border-card-border flex justify-end gap-3 pt-5 bg-card -mx-5 -mb-5 mt-6 rounded-b-2xl">
                <button type="button" onClick={handleCompanyModalClose} className="px-4 py-2 border border-card-border bg-card rounded-lg font-mono text-xs text-foreground cursor-pointer">Cancel</button>
                <button type="submit" disabled={isSubmitting} className="px-4 py-2 bg-primary text-primary-foreground rounded-lg border-0 font-mono text-xs font-bold tracking-wide transition-all cursor-pointer disabled:opacity-50">
                  {isSubmitting ? 'Adding...' : 'Add Company'}
                </button>
              </div>
            </form>
          </div>
        </div>
      )}
    </div>
  );
}
