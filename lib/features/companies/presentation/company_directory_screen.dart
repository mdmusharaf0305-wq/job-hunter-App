import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/presentation/glass_card.dart';
import '../../../shared/presentation/luffy_loader.dart';
import '../../jobs/domain/watchlist_company.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/link_utils.dart';

// Provider to fetch watchlist companies
final watchlistProvider = FutureProvider<List<WatchlistCompany>>((ref) async {
  final appsRepo = ref.watch(applicationsRepositoryProvider);
  final jobsRepo = ref.watch(jobsRepositoryProvider);

  final apps = await appsRepo.fetchAndCacheApplications();
  return await jobsRepo.getEnrichedWatchlist(apps);
});

class CompanyDirectoryScreen extends ConsumerStatefulWidget {
  const CompanyDirectoryScreen({super.key});

  @override
  ConsumerState<CompanyDirectoryScreen> createState() => _CompanyDirectoryScreenState();
}

class _CompanyDirectoryScreenState extends ConsumerState<CompanyDirectoryScreen> {
  String _searchQuery = '';
  WatchlistCompany? _selectedCompany;
  bool _isScraping = false;

  Future<void> _triggerScraper(WatchlistCompany company) async {
    setState(() => _isScraping = true);
    final jobsRepo = ref.read(jobsRepositoryProvider);

    try {
      final scraped = await jobsRepo.scrapeCompanyDetails(company);
      setState(() {
        _selectedCompany = scraped;
        _isScraping = false;
      });
      // Refresh the main watchlist
      ref.invalidate(watchlistProvider);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Real-time scraped info compiled for ${company.name}!'),
            backgroundColor: Colors.teal,
          ),
        );
      }
    } catch (e) {
      setState(() => _isScraping = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to crawl DuckDuckGo details: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Color _getBadgeColor(String? badge) {
    if (badge == null) return Colors.grey;
    final b = badge.toLowerCase();
    if (b.contains('direct')) return AppColors.darkAccentEmerald;
    if (b.contains('product')) return AppColors.darkAccentPurple;
    if (b.contains('service')) return AppColors.darkAccentBlue;
    if (b.contains('agency')) return AppColors.darkAccentRed;
    return Colors.grey;
  }

  Widget _buildBreakdownRow(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.white70)),
          Text('$value pts', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final watchlistAsync = ref.watch(watchlistProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Company Watchlist', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Watchlist Sidebar List
          Expanded(
            flex: 3,
            child: Column(
              children: [
                // Search field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Filter company watchlist...',
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
                
                // Watchlist list
                Expanded(
                  child: watchlistAsync.when(
                    loading: () => const Center(
                      child: LuffyLoader(size: 40, loadingText: 'CALCULATING DYNAMIC RELEVANCE CORES...'),
                    ),
                    error: (err, stack) => Center(child: Text('Error: $err')),
                    data: (list) {
                      final filtered = list.where((c) {
                        return c.name.toLowerCase().contains(_searchQuery.toLowerCase());
                      }).toList();

                      if (filtered.isEmpty) {
                        return const Center(child: Text('No watchlist companies matching query.'));
                      }

                      return ListView.builder(
                        itemCount: filtered.length,
                        itemBuilder: (context, idx) {
                          final c = filtered[idx];
                          final isSelected = _selectedCompany?.name.toLowerCase() == c.name.toLowerCase();

                          return ListTile(
                            selected: isSelected,
                            selectedTileColor: Colors.white.withOpacity(0.04),
                            onTap: () {
                              setState(() {
                                _selectedCompany = c;
                              });
                            },
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    c.name,
                                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '${c.relevanceScore}%',
                                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w900, color: Colors.blueAccent),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: _getBadgeColor(c.authenticityBadge).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      c.authenticityBadge ?? 'Needs Verification',
                                      style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: _getBadgeColor(c.authenticityBadge)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Tier ${c.tier}',
                                    style: const TextStyle(fontSize: 9, color: Colors.white54, fontFamily: 'monospace'),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          
          const VerticalDivider(width: 1, thickness: 1, color: Colors.white10),

          // Detail Card
          Expanded(
            flex: 4,
            child: _selectedCompany == null
                ? const Center(
                    child: Text(
                      'Select a company from the watchlist to view alignment reports.',
                      style: TextStyle(color: Colors.white54, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  )
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Company Title Header
                        Text(
                          _selectedCompany!.name,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 12, color: Colors.white54),
                            const SizedBox(width: 4),
                            Text(
                              _selectedCompany!.headquarters,
                              style: const TextStyle(fontSize: 10, color: Colors.white60),
                            ),
                            const SizedBox(width: 12),
                            IconButton(
                              icon: const Icon(Icons.language, size: 14, color: Colors.blueAccent),
                              onPressed: () => LinkUtils.launchWeb(_selectedCompany!.website),
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            )
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Scrape Button Details Card
                        if (_isScraping)
                          const Center(
                            child: LuffyLoader(size: 40, loadingText: 'CRAWLING GLASSDOOR / DUCKDUGGO IN REAL-TIME...'),
                          )
                        else
                          ElevatedButton.icon(
                            icon: const Icon(Icons.flash_on, size: 12),
                            label: const Text('Crawl Real-time details', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            onPressed: () => _triggerScraper(_selectedCompany!),
                          ),
                        const SizedBox(height: 20),

                        // Relevance metrics breakdown
                        if (_selectedCompany!.scoreBreakdown != null) ...[
                          const Text(
                            'ALIGNMENT SCORE BREAKDOWN',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1.1),
                          ),
                          const SizedBox(height: 10),
                          GlassCard(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              children: [
                                _buildBreakdownRow('Tech Stack Match (35% max)', _selectedCompany!.scoreBreakdown!.skillAlignment, AppColors.darkAccentBlue),
                                _buildBreakdownRow('Hiring Index (20% max)', _selectedCompany!.scoreBreakdown!.hiringFrequency, AppColors.darkAccentPurple),
                                _buildBreakdownRow('Compensation Potential (15% max)', _selectedCompany!.scoreBreakdown!.salaryPotential, AppColors.darkAccentAmber),
                                _buildBreakdownRow('Engineering Culture (15% max)', _selectedCompany!.scoreBreakdown!.engineeringCulture, AppColors.darkAccentEmerald),
                                _buildBreakdownRow('Remote Flexibility (10% max)', _selectedCompany!.scoreBreakdown!.remoteFlexibility, const Color(0xFF22D3EE)),
                                _buildBreakdownRow('Market Growth Potential (5% max)', _selectedCompany!.scoreBreakdown!.growthPotential, AppColors.darkAccentEmerald),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],

                        // Scraped Metrics
                        const Text(
                          'CRAWLED SOCIAL PROFILES METRICS',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1.1),
                        ),
                        const SizedBox(height: 10),
                        GlassCard(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              _buildScrapeMetricRow('Employee Headcount', _selectedCompany!.employeeCount),
                              const Divider(height: 12, color: Colors.white10),
                              _buildScrapeMetricRow('Glassdoor Rating', '${_selectedCompany!.overallRating}/10'),
                              const Divider(height: 12, color: Colors.white10),
                              _buildScrapeMetricRow('Work-Life Index', '${_selectedCompany!.workLifeBalance}/10'),
                              const Divider(height: 12, color: Colors.white10),
                              _buildScrapeMetricRow('Attrition Rate', _selectedCompany!.attritionRate),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Tech Stack badges
                        const Text(
                          'TECH STACK TARGETS',
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1.1),
                        ),
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 6,
                          runSpacing: 6,
                          children: _selectedCompany!.techStack.map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.blueAccent.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.blueAccent.withOpacity(0.15)),
                              ),
                              child: Text(
                                tech,
                                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildScrapeMetricRow(String label, String val) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.white70)),
        Text(val, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w900, fontFamily: 'monospace')),
      ],
    );
  }
}
