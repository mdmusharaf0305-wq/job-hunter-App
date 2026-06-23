'use client';

import { useState, useMemo } from 'react';
import {
  useReactTable,
  getCoreRowModel,
  getFilteredRowModel,
  getPaginationRowModel,
  ColumnDef,
  flexRender
} from '@tanstack/react-table';
import { 
  Phone, 
  Mail, 
  Search, 
  MessageSquare,
  MessageCircle,
  Link2,
  Users,
  ChevronLeft,
  ChevronRight,
  ArrowUpDown
} from 'lucide-react';
import { Recruiter, JobApplication } from '../../types';
import RefreshButton from '../../components/RefreshButton';
import CustomSelect from '../../components/CustomSelect';
import { NotionSchemaOptions } from '../../lib/notion/client';
import { triggerPhone, triggerWhatsApp, triggerGmail, triggerSMS } from '../../lib/linkUtils';

type Props = {
  initialRecruiters: Recruiter[];
  applications: JobApplication[];
  dbOptions: NotionSchemaOptions;
};

// Simple heuristic for Indian/Common names
const guessGender = (fullName: string): 'male' | 'female' | 'unknown' => {
  if (!fullName) return 'unknown';
  const firstName = fullName.trim().split(' ')[0].toLowerCase();
  if (!firstName) return 'unknown';
  
  // High confidence female endings
  if (firstName.endsWith('a') || firstName.endsWith('i') || firstName.endsWith('ee') || firstName.endsWith('y')) {
    // Exceptions for male names ending in 'a' or 'i'
    const maleExceptions = ['aditya', 'krishna', 'shiva', 'arya', 'rishi', 'ravi', 'hari', 'ali', 'mani'];
    if (maleExceptions.includes(firstName)) return 'male';
    return 'female';
  }
  return 'male';
};

// Prefer second number after '/' if present, strip formatting
const parsePhone = (raw?: string): string | undefined => {
  if (!raw) return undefined;
  const parts = raw.split('/');
  const chosen = parts.length > 1 ? parts[parts.length - 1].trim() : parts[0].trim();
  return chosen || undefined;
};

type RecruiterInfo = {
  id: string;
  name: string;
  phone?: string;
  email?: string;
  linkedin?: string;
  dbSource: 'inbound' | 'outbound';
};

type GroupedCompany = {
  company: string;
  recruiters: RecruiterInfo[];
  lastModified: number;
};

export default function RecruitersClient({ applications }: Props) {
  const [prevApplications, setPrevApplications] = useState(applications);
  const [apps, setApps] = useState<JobApplication[]>(applications);

  if (applications !== prevApplications) {
    setPrevApplications(applications);
    setApps(applications);
  }

  const [sortBy, setSortBy] = useState<'name-asc' | 'name-desc' | 'modified-desc' | 'modified-asc'>('modified-desc');
  const [globalFilter, setGlobalFilter] = useState('');
  const [sourceFilter, setSourceFilter] = useState<'all' | 'inbound' | 'outbound'>('all');
  const [genderFilter, setGenderFilter] = useState<'all' | 'male' | 'female'>('all');

  // Group all recruiters by company from apps/applications (opportunity table)
  const groupedCompanies = useMemo(() => {
    const map = new Map<string, { recruiters: RecruiterInfo[]; lastModified: number }>();
    
    apps.forEach(app => {
      if (!app.recruiterName) return;
      const compName = (app.recruiterCompany || app.company || 'Unknown').trim();
      if (!compName || compName.toLowerCase() === 'unknown') return;
      
      const formatCompanyName = (name: string): string => {
        const titleCase = (str: string) => {
          return str
            .toLowerCase()
            .split(' ')
            .map(word => word.charAt(0).toUpperCase() + word.slice(1))
            .join(' ');
        };
        const upper = name.toUpperCase();
        const acronyms = ['TCS', 'IBM', 'JPMC', 'CRED', 'MNC', 'IT', 'LTI', 'EY', 'DXC', 'HCL', 'UST', 'JSW', 'NLB', 'CGI', 'PITCS', 'RGBSI', 'EY-3', 'ICICI', 'HP', 'GE', 'SBI', 'ITC'];
        if (acronyms.includes(upper)) {
          return upper;
        }
        return titleCase(name);
      };
      
      const formattedCompName = formatCompanyName(compName);
      
      const recInfo: RecruiterInfo = {
        id: app.id,
        name: app.recruiterName,
        phone: app.recruiterPhone || undefined,
        email: app.recruiterEmail || undefined,
        linkedin: app.recruiterLinkedin || undefined,
        dbSource: app.type
      };
      
      const appModifiedTime = app.lastUpdated ? new Date(app.lastUpdated).getTime() : 0;
      
      if (!map.has(formattedCompName)) {
        map.set(formattedCompName, { recruiters: [], lastModified: appModifiedTime });
      }
      
      const group = map.get(formattedCompName)!;
      if (appModifiedTime > group.lastModified) {
        group.lastModified = appModifiedTime;
      }
      
      const isDuplicate = group.recruiters.some(r => r.name.toLowerCase() === recInfo.name.toLowerCase());
      if (!isDuplicate) {
        group.recruiters.push(recInfo);
      }
    });
    
    return Array.from(map.entries()).map(([company, data]) => ({
      company,
      recruiters: data.recruiters,
      lastModified: data.lastModified
    }));
  }, [apps]);

  // Counts for filter badges
  const inboundCount = useMemo(() => {
    let count = 0;
    groupedCompanies.forEach(c => {
      if (c.recruiters.some(r => r.dbSource === 'inbound')) count++;
    });
    return count;
  }, [groupedCompanies]);

  const outboundCount = useMemo(() => {
    let count = 0;
    groupedCompanies.forEach(c => {
      if (c.recruiters.some(r => r.dbSource === 'outbound')) count++;
    });
    return count;
  }, [groupedCompanies]);

  // Apply filters
  const filteredGroupedData = useMemo(() => {
    let data = groupedCompanies;

    if (sourceFilter !== 'all') {
      data = data.map(item => ({
        ...item,
        recruiters: item.recruiters.filter(r => r.dbSource === sourceFilter)
      })).filter(item => item.recruiters.length > 0);
    }

    if (genderFilter !== 'all') {
      data = data.map(item => ({
        ...item,
        recruiters: item.recruiters.filter(r => guessGender(r.name) === genderFilter)
      })).filter(item => item.recruiters.length > 0);
    }

    if (globalFilter) {
      const query = globalFilter.toLowerCase();
      data = data.filter(item => {
        const matchesCompany = item.company.toLowerCase().includes(query);
        const matchesRecruiter = item.recruiters.some(r => 
          r.name.toLowerCase().includes(query) ||
          (r.phone || '').toLowerCase().includes(query) ||
          (r.email || '').toLowerCase().includes(query)
        );
        return matchesCompany || matchesRecruiter;
      });
    }

    return data;
  }, [groupedCompanies, sourceFilter, genderFilter, globalFilter]);

  // Apply Sorting
  const sortedGroupedData = useMemo(() => {
    const sorted = [...filteredGroupedData];
    if (sortBy === 'name-asc') {
      sorted.sort((a, b) => a.company.localeCompare(b.company));
    } else if (sortBy === 'name-desc') {
      sorted.sort((a, b) => b.company.localeCompare(a.company));
    } else if (sortBy === 'modified-desc') {
      sorted.sort((a, b) => b.lastModified - a.lastModified);
    } else if (sortBy === 'modified-asc') {
      sorted.sort((a, b) => a.lastModified - b.lastModified);
    } else {
      sorted.sort((a, b) => a.company.localeCompare(b.company));
    }
    return sorted;
  }, [filteredGroupedData, sortBy]);

  // Define table columns
  const columns = useMemo<ColumnDef<GroupedCompany>[]>(() => [
    {
      accessorKey: 'company',
      header: () => {
        const isAsc = sortBy === 'name-asc';
        return (
          <button
            onClick={() => setSortBy(isAsc ? 'name-desc' : 'name-asc')}
            className="flex items-center gap-1.5 text-[13px] font-mono tracking-wider uppercase font-semibold text-muted-foreground hover:text-foreground border-0 bg-transparent cursor-pointer transition-colors"
          >
            Company
            <ArrowUpDown size={12} />
          </button>
        );
      },
      cell: info => {
        const company = info.getValue() as string;
        return (
          <span className="font-bold text-[12px] text-foreground tracking-tight flex items-center gap-1.5 w-[160px] max-w-[160px] break-words leading-tight">
            🏢 {company}
          </span>
        );
      }
    },
    {
      id: 'recruiters',
      header: () => (
        <span className="text-[13px] font-mono tracking-wider uppercase font-semibold text-muted-foreground">
          Recruiters & Contacts
        </span>
      ),
      cell: info => {
        const row = info.row.original;
        return (
          <div className="flex flex-wrap gap-2 py-1">
            {row.recruiters.map((r, i) => {
              const gender = guessGender(r.name);
              const formattedName = r.name ? r.name.toLowerCase().split(' ').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ') : '';
              const badgeColor = gender === 'female' 
                ? 'bg-pink-100 text-pink-700 dark:bg-pink-950 dark:text-pink-400 border border-pink-200 dark:border-pink-800' 
                : 'bg-indigo-100 text-indigo-700 dark:bg-indigo-950 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-800';
              
              const phone = parsePhone(r.phone);
              
              return (
                <div key={i} className="inline-flex flex-col items-start gap-1 p-1.5 rounded-xl bg-card border border-card-border/60 shadow-sm hover:border-card-border transition-colors w-fit">
                  {/* Row 1: Name + source badge — left-aligned */}
                  <div className="flex items-center gap-1.5">
                    <span className={`font-semibold text-[11px] tracking-tight px-2 py-0.5 rounded-md inline-block shadow-sm ${badgeColor}`}>
                      {formattedName}
                    </span>
                    <span className="px-1.5 py-0.5 rounded text-[8px] font-mono font-bold uppercase bg-muted text-muted-foreground">
                      {r.dbSource}
                    </span>
                  </div>

                  {/* Row 2: Contact icons — left-aligned below name */}
                  <div className="flex items-center gap-1">
                    {phone && (
                      <>
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation();
                            triggerPhone(phone);
                          }}
                          className="comm-btn flex items-center justify-center w-6 h-6 hover:bg-green-500/10 border border-card-border/50 hover:border-green-500/20 rounded bg-card/50 text-green-500 transition-colors"
                          title="Call"
                        >
                          <Phone size={10} />
                        </button>
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation();
                            triggerWhatsApp(phone, r.name);
                          }}
                          className="comm-btn flex items-center justify-center w-6 h-6 hover:bg-emerald-500/10 border border-card-border/50 hover:border-emerald-500/20 rounded bg-card/50 text-emerald-500 transition-colors"
                          title="WhatsApp"
                        >
                          <MessageCircle size={10} />
                        </button>
                        <button
                          type="button"
                          onClick={(e) => {
                            e.stopPropagation();
                            triggerSMS(phone, r.name);
                          }}
                          className="comm-btn flex items-center justify-center w-6 h-6 hover:bg-sky-500/10 border border-card-border/50 hover:border-sky-500/20 rounded bg-card/50 text-sky-500 transition-colors"
                          title="SMS"
                        >
                          <MessageSquare size={10} />
                        </button>
                      </>
                    )}
                    {r.email && (
                      <button
                        type="button"
                        onClick={(e) => {
                          e.stopPropagation();
                          triggerGmail(r.email, r.name);
                        }}
                        className="comm-btn flex items-center justify-center w-6 h-6 hover:bg-accent-blue/10 border border-card-border/50 hover:border-accent-blue/20 rounded bg-card/50 text-accent-blue transition-colors"
                        title={r.email}
                      >
                        <Mail size={10} />
                      </button>
                    )}
                    {r.linkedin && (
                      <a
                        href={r.linkedin}
                        target="_blank" rel="noreferrer"
                        className="flex items-center justify-center w-6 h-6 hover:bg-accent-blue/10 border border-card-border/50 hover:border-accent-blue/20 rounded bg-card/50 text-accent-blue transition-colors"
                        title="LinkedIn"
                      >
                        <Link2 size={10} />
                      </a>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        );
      }
    }
  ], [sortBy]);



  const table = useReactTable({
    data: sortedGroupedData,
    columns,
    getCoreRowModel: getCoreRowModel(),
    getFilteredRowModel: getFilteredRowModel(),
    getPaginationRowModel: getPaginationRowModel(),
    initialState: {
      pagination: {
        pageSize: 15
      }
    }
  });

  return (
    <div className="space-y-6">
      {/* Page Title Block */}
      <div className="border-b border-card-border pb-5 flex items-center justify-between">
        <div className="flex items-center gap-3">
          <div className="p-2 rounded-xl bg-accent-blue/10 border border-accent-blue/20">
            <Users size={20} className="text-accent-blue" />
          </div>
          <div>
            <h2 className="text-2xl font-bold tracking-tight text-foreground font-mono">
              Recruiters Directory
            </h2>
            <p className="text-sm text-muted-foreground mt-0.5">
              All recruiter contacts grouped by company
              <span className="ml-2 text-[13px] font-mono text-foreground/50 bg-card px-2 py-0.5 rounded-md border border-card-border">
                {groupedCompanies.length} companies ({groupedCompanies.reduce((acc, c) => acc + c.recruiters.length, 0)} contacts)
              </span>
            </p>
          </div>
        </div>
      </div>

      {/* Filters row: Source, Gender, Sort capsules + Search */}
      <div className="flex flex-col sm:flex-row items-stretch sm:items-center gap-3 w-full justify-between mt-4">
        <div className="flex flex-wrap items-center gap-2.5 bg-card/30 p-2 md:p-1.5 rounded-2xl border border-card-border/60">
          {/* Source dropdown */}
          <div className="flex items-center gap-1.5 py-0.5">
            <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Source:</span>
            <CustomSelect
              value={sourceFilter}
              onChange={(val) => setSourceFilter(val as 'all' | 'inbound' | 'outbound')}
              options={[
                { value: 'all', label: `All (${groupedCompanies.length})` },
                { value: 'inbound', label: `Inbound (${inboundCount})` },
                { value: 'outbound', label: `Outbound (${outboundCount})` }
              ]}
              label="Source Filter"
              className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1.5 text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center"
            />
          </div>

          {/* Gender dropdown */}
          <div className="flex items-center gap-1.5 py-0.5">
            <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Gender:</span>
            <CustomSelect
              value={genderFilter}
              onChange={(val) => setGenderFilter(val as 'all' | 'male' | 'female')}
              options={[
                { value: 'all', label: 'All' },
                { value: 'male', label: 'Men' },
                { value: 'female', label: 'Women' }
              ]}
              label="Gender Filter"
              className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1.5 text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center"
            />
          </div>

          {/* Sort dropdown */}
          <div className="flex items-center gap-1.5 py-0.5">
            <span className="text-[10px] font-mono text-muted-foreground uppercase tracking-wider font-bold">Sort:</span>
            <CustomSelect
              value={sortBy}
              onChange={(val) => setSortBy(val as 'name-asc' | 'name-desc' | 'modified-desc' | 'modified-asc')}
              options={[
                { value: 'name-asc', label: 'Company A-Z' },
                { value: 'name-desc', label: 'Company Z-A' },
                { value: 'modified-desc', label: 'Last Modified (Newest)' },
                { value: 'modified-asc', label: 'Last Modified (Oldest)' }
              ]}
              label="Sort recruiters"
              className="bg-card border border-card-border/60 rounded-full text-[10px] font-mono font-bold px-3 py-1.5 text-foreground focus:outline-none focus:border-accent-blue cursor-pointer appearance-none text-center"
            />
          </div>
          <RefreshButton />
        </div>

        {/* Search bar */}
        <div className="relative flex-1 w-full sm:max-w-xs">
          <Search size={15} className="absolute left-3.5 top-1/2 -translate-y-1/2 text-muted-foreground/60" />
          <input
            type="text"
            placeholder="Search by name, company..."
            value={globalFilter}
            onChange={e => setGlobalFilter(e.target.value)}
            className="w-full pl-10 pr-4 py-2.5 rounded-xl bg-card border border-card-border text-xs text-foreground placeholder-muted-foreground/50 focus:outline-none focus:border-accent-blue/40 focus:ring-1 focus:ring-accent-blue/20 font-medium transition-all"
          />
        </div>
      </div>

      {/* Desktop Cards Grid (Inspired by Inbound) */}
      <div className="hidden lg:grid grid-cols-1 md:grid-cols-2 xl:grid-cols-4 2xl:grid-cols-5 gap-4">
        {sortedGroupedData.length === 0 ? (
          <div className="col-span-full border border-dashed border-card-border rounded-2xl py-16 text-center text-xs font-mono text-muted-foreground bg-card/20">
            No matching companies or recruiter contacts found.
          </div>
        ) : (
          sortedGroupedData.map((item) => (
            <div 
              key={item.company}
              className="bg-card border border-card-border rounded-2xl p-4.5 hover:border-accent-blue/30 transition-all duration-300 hover:shadow-xl hover:shadow-accent-blue/5 flex flex-col justify-between w-full max-w-[300px]"
            >
              <div>
                <div className="flex justify-between items-center mb-3 pb-2 border-b border-card-border/40">
                  <h3 className="font-bold text-[12px] text-foreground tracking-tight flex items-center gap-1.5 font-mono uppercase">
                    🏢 {item.company}
                  </h3>
                  <span className="px-2 py-0.5 rounded-full text-[9px] font-mono font-bold bg-muted text-muted-foreground border border-card-border/40">
                    {item.recruiters.length} {item.recruiters.length === 1 ? 'contact' : 'contacts'}
                  </span>
                </div>
                
                <div className="space-y-3">
                  {item.recruiters.map((r, i) => {
                    const gender = guessGender(r.name);
                    const formattedName = r.name ? r.name.toLowerCase().split(' ').map(w => w.charAt(0).toUpperCase() + w.slice(1)).join(' ') : '';
                    const badgeColor = gender === 'female' 
                      ? 'bg-pink-100 text-pink-700 dark:bg-pink-950 dark:text-pink-400 border border-pink-200 dark:border-pink-800' 
                      : 'bg-indigo-100 text-indigo-700 dark:bg-indigo-950 dark:text-indigo-400 border border-indigo-200 dark:border-indigo-800';
                    
                    const phone = parsePhone(r.phone);
                    
                    return (
                      <div 
                        key={i} 
                        className="flex flex-col gap-1.5 p-3 rounded-xl bg-background border border-card-border/50 hover:border-card-border/80 transition-colors"
                      >
                        <div className="flex items-center justify-between">
                          <span className={`font-semibold text-[11px] tracking-tight px-2 py-0.5 rounded-md inline-block shadow-sm ${badgeColor}`}>
                            {formattedName}
                          </span>
                          <span className="px-1.5 py-0.5 rounded text-[8px] font-mono font-bold uppercase bg-muted text-muted-foreground border border-card-border/30">
                            {r.dbSource}
                          </span>
                        </div>

                        <div className="flex flex-wrap items-center gap-1.5 mt-1">
                          {phone && (
                            <>
                              <button
                                type="button"
                                onClick={(e) => {
                                  e.stopPropagation();
                                  triggerPhone(phone);
                                }}
                                className="comm-btn flex items-center justify-center w-7 h-7 hover:bg-green-500/10 border border-card-border/50 hover:border-green-500/20 rounded-lg bg-card/50 text-green-500 transition-colors"
                                title="Call"
                              >
                                <Phone size={11} />
                              </button>
                              <button
                                type="button"
                                onClick={(e) => {
                                  e.stopPropagation();
                                  triggerWhatsApp(phone, r.name);
                                }}
                                className="comm-btn flex items-center justify-center w-7 h-7 hover:bg-emerald-500/10 border border-card-border/50 hover:border-emerald-500/20 rounded-lg bg-card/50 text-emerald-500 transition-colors"
                                title="WhatsApp"
                              >
                                <MessageCircle size={11} />
                              </button>
                              <button
                                type="button"
                                onClick={(e) => {
                                  e.stopPropagation();
                                  triggerSMS(phone, r.name);
                                }}
                                className="comm-btn flex items-center justify-center w-7 h-7 hover:bg-sky-500/10 border border-card-border/50 hover:border-sky-500/20 rounded-lg bg-card/50 text-sky-500 transition-colors"
                                title="SMS"
                              >
                                <MessageSquare size={11} />
                              </button>
                            </>
                          )}
                          {r.email && (
                            <button
                              type="button"
                              onClick={(e) => {
                                e.stopPropagation();
                                triggerGmail(r.email, r.name);
                              }}
                              className="comm-btn flex items-center justify-center w-7 h-7 hover:bg-accent-blue/10 border border-card-border/50 hover:border-accent-blue/20 rounded-lg bg-card/50 text-accent-blue transition-colors"
                              title={r.email}
                            >
                              <Mail size={11} />
                            </button>
                          )}
                          {r.linkedin && (
                            <a
                              href={r.linkedin}
                              target="_blank" rel="noreferrer"
                              className="flex items-center justify-center w-7 h-7 hover:bg-accent-blue/10 border border-card-border/50 hover:border-accent-blue/20 rounded-lg bg-card/50 text-accent-blue transition-colors"
                              title="LinkedIn"
                            >
                              <Link2 size={11} />
                            </a>
                          )}
                        </div>
                      </div>
                    );
                  })}
                </div>
              </div>
            </div>
          ))
        )}
      </div>

      {/* Table (Mobile Only) */}
      <div className="block lg:hidden glass-panel rounded-2xl overflow-hidden shadow-lg border border-card-border">
        <div className="overflow-x-auto">
          <table className="w-full min-w-[600px] border-collapse">
            <thead>
              {table.getHeaderGroups().map(headerGroup => (
                <tr key={headerGroup.id} className="border-b border-card-border bg-card/80">
                  {headerGroup.headers.map((header, hIdx) => (
                    <th key={header.id} className={`px-4 py-3.5 text-left font-medium ${hIdx === 0 ? 'w-[180px]' : ''}`}>
                      {header.isPlaceholder
                        ? null
                        : flexRender(
                            header.column.columnDef.header,
                            header.getContext()
                          )}
                    </th>
                  ))}
                </tr>
              ))}
            </thead>
            <tbody>
              {table.getRowModel().rows.length === 0 ? (
                <tr>
                  <td colSpan={columns.length} className="px-5 py-16 text-center text-xs font-mono text-muted-foreground/60">
                    No matching companies or recruiter contacts found.
                  </td>
                </tr>
              ) : (
                table.getRowModel().rows.map((row, idx) => {
                  const rowBg = idx % 2 === 0 ? '' : 'bg-card/25';
                  
                  return (
                    <tr 
                      key={row.id} 
                      className={`border-b border-card-border/20 last:border-0 hover:bg-card/10 transition-colors ${rowBg}`}
                    >
                      {row.getVisibleCells().map((cell, cIdx) => (
                        <td key={cell.id} className={`px-4 py-3 align-top ${cIdx === 0 ? 'w-[180px]' : ''}`}>
                          {flexRender(
                            cell.column.columnDef.cell,
                            cell.getContext()
                          )}
                        </td>
                      ))}
                    </tr>
                  );
                })
              )}
            </tbody>
          </table>
        </div>

        {/* Pagination */}
        {table.getPageCount() > 1 && (
          <div className="px-5 py-3.5 border-t border-card-border flex items-center justify-between bg-card/60 text-xs font-mono text-muted-foreground">
            <div>
              Showing {table.getState().pagination.pageIndex * table.getState().pagination.pageSize + 1}–{Math.min(
                (table.getState().pagination.pageIndex + 1) * table.getState().pagination.pageSize,
                sortedGroupedData.length
              )}{' '}
              of {sortedGroupedData.length}
            </div>
            <div className="flex gap-1.5">
              <button
                onClick={() => table.previousPage()}
                disabled={!table.getCanPreviousPage()}
                className="p-1.5 rounded-lg border border-card-border bg-background hover:bg-card text-foreground disabled:opacity-25 disabled:pointer-events-none transition-colors cursor-pointer"
              >
                <ChevronLeft size={14} />
              </button>
              <button
                onClick={() => table.nextPage()}
                disabled={!table.getCanNextPage()}
                className="p-1.5 rounded-lg border border-card-border bg-background hover:bg-card text-foreground disabled:opacity-25 disabled:pointer-events-none transition-colors cursor-pointer"
              >
                <ChevronRight size={14} />
              </button>
            </div>
          </div>
        )}
      </div>


    </div>
  );
}
