import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/presentation/glass_card.dart';
import '../../../shared/presentation/luffy_loader.dart';
import '../../../shared/domain/job_application.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/link_utils.dart';
import 'application_modal.dart';

// Provider to query outbound applications
final outboundAppsProvider = FutureProvider<List<JobApplication>>((ref) async {
  final repo = ref.watch(applicationsRepositoryProvider);
  final apps = await repo.fetchAndCacheApplications();
  return apps.where((a) => a.type == 'outbound').toList();
});

class OutboundScreen extends ConsumerStatefulWidget {
  const OutboundScreen({super.key});

  @override
  ConsumerState<OutboundScreen> createState() => _OutboundScreenState();
}

class _OutboundScreenState extends ConsumerState<OutboundScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  // Board filter states
  String _searchQuery = '';
  String _priorityFilter = 'All';
  
  // Crawler states
  final _roleController = TextEditingController();
  final _locationController = TextEditingController();
  List<Map<String, dynamic>> _crawledJobs = [];
  bool _isCrawling = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeScraperInputs();
  }

  void _initializeScraperInputs() async {
    final jobsRepo = ref.read(jobsRepositoryProvider);
    final profile = await jobsRepo.getCandidateProfile();
    if (profile.preferredRoles.isNotEmpty) {
      _roleController.text = profile.preferredRoles.first;
    }
    if (profile.preferredLocations.isNotEmpty) {
      _locationController.text = profile.preferredLocations.first;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _roleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _updateStage(String id, String newStage) async {
    final repo = ref.read(applicationsRepositoryProvider);
    await repo.updateStage(id, newStage);
    ref.invalidate(outboundAppsProvider);
  }

  void _openApplicationModal(BuildContext context, [JobApplication? app]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ApplicationModal(
        application: app,
        defaultType: 'outbound',
        onSaved: () => ref.invalidate(outboundAppsProvider),
      ),
    );
  }

  // Scraper Crawl trigger
  Future<void> _runCrawl() async {
    setState(() {
      _isCrawling = true;
      _crawledJobs = [];
    });

    final jobsRepo = ref.read(jobsRepositoryProvider);
    final results = await jobsRepo.crawlRealTimeJobs(
      _roleController.text.trim(),
      _locationController.text.trim(),
    );

    setState(() {
      _crawledJobs = results;
      _isCrawling = false;
    });
  }

  // One-click import tracking
  Future<void> _importTrack(Map<String, dynamic> job) async {
    final appsRepo = ref.read(applicationsRepositoryProvider);
    try {
      await appsRepo.createOpportunity({
        'company': job['company'],
        'role': job['title'],
        'location': job['location'],
        'status': '📄 Applied',
        'priority': 'Medium',
        'type': 'outbound',
        'notes': 'Imported from Jobs Aggregator: ${job['url']}',
      });

      ref.invalidate(outboundAppsProvider);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Imported ${job['company']} directly into Notion board!'),
            backgroundColor: Colors.teal,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Widget _buildOutboundBoard(BuildContext context, List<JobApplication> list, bool isDark) {
    var filtered = list.where((a) {
      final matchesSearch = a.company.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          a.role.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (a.recruiterName ?? '').toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesPriority = _priorityFilter == 'All' || a.priority == _priorityFilter;
      return matchesSearch && matchesPriority;
    }).toList();

    if (filtered.isEmpty) {
      return const Center(child: Text('No outbound opportunities found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      itemCount: filtered.length,
      itemBuilder: (context, idx) {
        final app = filtered[idx];
        final priorityColor = app.priority == 'High'
            ? AppColors.priorityHigh
            : (app.priority == 'Medium'
                ? AppColors.priorityMedium
                : AppColors.priorityLow);

        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: InkWell(
            onTap: () => _openApplicationModal(context, app),
            child: GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          app.company,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: priorityColor),
                      )
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    app.role,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (app.location != null)
                        Row(
                          children: [
                            const Icon(Icons.location_on_outlined, size: 12, color: Colors.white54),
                            const SizedBox(width: 4),
                            Text(app.location!, style: const TextStyle(fontSize: 9, color: Colors.white54)),
                          ],
                        )
                      else
                        const SizedBox.shrink(),
                      
                      // Quick Dropdown Stage update
                      DropdownButton<String>(
                        value: ['⚪ Not Started', '📨 Resume Shared', '🔍 Shortlisted', '👻 No Response', '🚫 No Openings', '⏸️ On Hold', '❌ Rejected', '🎉 Offer Received']
                                .contains(app.status)
                            ? app.status
                            : '⚪ Not Started',
                        dropdownColor: const Color(0xFF1E1E26),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppColors.getStatusColor(app.status, isDark),
                        ),
                        underline: const SizedBox.shrink(),
                        items: ['⚪ Not Started', '📨 Resume Shared', '🔍 Shortlisted', '👻 No Response', '🚫 No Openings', '⏸️ On Hold', '❌ Rejected', '🎉 Offer Received'].map((opt) {
                          return DropdownMenuItem<String>(value: opt, child: Text(opt));
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            _updateStage(app.id, val);
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRealtimeScraper(BuildContext context, bool isDark) {
    return Column(
      children: [
        // Crawler search options
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: GlassCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _roleController,
                        decoration: const InputDecoration(
                          hintText: 'Target Role',
                          hintStyle: TextStyle(color: Colors.white30, fontSize: 12),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          hintText: 'Target Location',
                          hintStyle: TextStyle(color: Colors.white30, fontSize: 12),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.search, size: 14),
                        label: const Text('Aggregate Real-time Jobs', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        onPressed: _isCrawling ? null : _runCrawl,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        
        // Results
        Expanded(
          child: _isCrawling
              ? const Center(child: LuffyLoader(size: 40, loadingText: 'AGGREGATING LIVE PORTALS (NAUKRI, WELLFOUND, HIRIST)...'))
              : _crawledJobs.isEmpty
                  ? const Center(child: Text('Press button to crawl real-time matching jobs.'))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: _crawledJobs.length,
                      itemBuilder: (context, idx) {
                        final job = _crawledJobs[idx];
                        final skills = job['skills'] as List? ?? [];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: GlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        job['company'] ?? '',
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      job['portal'] ?? '',
                                      style: const TextStyle(fontSize: 9, color: Colors.white54, fontFamily: 'monospace'),
                                    )
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  job['title'] ?? '',
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white70),
                                ),
                                const SizedBox(height: 6),
                                
                                // Skills badges
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: skills.map((s) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: Colors.blueAccent.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Text(
                                        s.toString(),
                                        style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                                      ),
                                    );
                                  }).toList(),
                                ),
                                const SizedBox(height: 12),
                                
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Exp: ${job['experience'] ?? "N/A"}',
                                      style: const TextStyle(fontSize: 10, color: Colors.white54),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.open_in_new, size: 14, color: Colors.white70),
                                          onPressed: () => LinkUtils.launchWeb(job['url']),
                                          constraints: const BoxConstraints(),
                                          padding: EdgeInsets.zero,
                                        ),
                                        const SizedBox(width: 12),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white.withOpacity(0.06),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(6),
                                              side: BorderSide(color: Colors.white.withOpacity(0.1)),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                          onPressed: () => _importTrack(job),
                                          child: const Text('Import Track', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final appsAsync = ref.watch(outboundAppsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Outbound Sourcing', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.blueAccent),
            onPressed: () => _openApplicationModal(context),
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.blueAccent,
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: 'OUTBOUND BOARD'),
            Tab(text: 'REAL-TIME CRAWLER'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Outbound Board Tab
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search outbound pipeline...',
                          hintStyle: const TextStyle(color: Colors.white30, fontSize: 12),
                          prefixIcon: const Icon(Icons.search, size: 16, color: Colors.white60),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.03),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                          ),
                        ),
                        style: const TextStyle(fontSize: 12, color: Colors.white),
                        onChanged: (val) {
                          setState(() {
                            _searchQuery = val.trim();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    DropdownButton<String>(
                      value: _priorityFilter,
                      dropdownColor: const Color(0xFF1E1E26),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                      underline: const SizedBox.shrink(),
                      items: ['All', 'High', 'Medium', 'Low'].map((opt) {
                        return DropdownMenuItem<String>(
                          value: opt,
                          child: Text(opt),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _priorityFilter = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => ref.refresh(outboundAppsProvider.future),
                  child: appsAsync.when(
                    loading: () => const Center(
                      child: LuffyLoader(size: 48, loadingText: 'COMPILING OUTBOUND BOARDS...'),
                    ),
                    error: (err, stack) => Center(child: Text('Error: $err')),
                    data: (list) => _buildOutboundBoard(context, list, isDark),
                  ),
                ),
              ),
            ],
          ),
          
          // Scraper crawler Tab
          _buildRealtimeScraper(context, isDark),
        ],
      ),
    );
  }
}
