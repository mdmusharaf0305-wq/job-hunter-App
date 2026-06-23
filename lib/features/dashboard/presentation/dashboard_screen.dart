import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/presentation/glass_card.dart';
import '../../../shared/presentation/luffy_loader.dart';
import '../../../shared/domain/job_application.dart';
import '../../../shared/domain/recruiter.dart';
import '../../../shared/domain/dashboard_metrics.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/link_utils.dart';
import '../../../core/network/notion_api_client.dart'; // import to resolve base stage mapping

// Provider to compute dashboard metrics
final dashboardMetricsProvider = FutureProvider<DashboardMetrics>((ref) async {
  final appsRepo = ref.watch(applicationsRepositoryProvider);
  final recruitersRepo = ref.watch(recruitersRepositoryProvider);

  // Trigger cache sync first
  final apps = await appsRepo.fetchAndCacheApplications();
  final recruiters = await recruitersRepo.fetchRecruiters();

  // 1. Total Opportunities = Active applications in pipeline (sourcing, screening, interview)
  final activeApps = apps.where((a) {
    final status = a.status.toLowerCase().replaceAll(RegExp(r'[^\w]'), '');
    return ['sourcing', 'screening', 'interview', 'applied', 'hrscreening', 'interviewscheduled'].contains(status);
  }).toList();
  final totalOpportunities = activeApps.length;

  // 2. Active Recruiters = Unique recruiters extracted
  final activeRecruiters = recruiters.length;

  // 3. Interviews Count = Applications in interview stage
  final interviewsCount = apps.where((a) {
    final s = a.status.toLowerCase().replaceAll(RegExp(r'[^\w]'), '');
    return s.contains('interview') || s.contains('round') || s.contains('test');
  }).length;

  // 4. Offers Count = Applications with offered stage
  final offersCount = apps.where((a) {
    final s = a.status.toLowerCase().replaceAll(RegExp(r'[^\w]'), '');
    return s.contains('offer') || s.contains('received');
  }).length;

  // 5. Response Rate: percentage of applications that replied (screening or beyond vs total)
  final totalApplications = apps.length;
  final respondedApplications = apps.where((a) {
    final s = a.status.toLowerCase().replaceAll(RegExp(r'[^\w]'), '');
    return !['sourcing', 'applied', 'notstarted', ''].contains(s);
  }).length;
  final responseRate = totalApplications > 0
      ? ((respondedApplications / totalApplications) * 100).roundToDouble()
      : 0.0;

  // Group applications dynamically per week (relative to today)
  final now = DateTime.now();
  final w3Count = apps.where((a) {
    final diff = now.difference(DateTime.parse(a.lastUpdated)).inDays;
    return diff >= 0 && diff < 7;
  }).length;
  final w2Count = apps.where((a) {
    final diff = now.difference(DateTime.parse(a.lastUpdated)).inDays;
    return diff >= 7 && diff < 14;
  }).length;
  final w1Count = apps.where((a) {
    final diff = now.difference(DateTime.parse(a.lastUpdated)).inDays;
    return diff >= 14 && diff < 21;
  }).length;

  final applicationsPerWeek = [
    WeekCount(week: '2 Weeks Ago', count: w1Count),
    WeekCount(week: 'Last Week', count: w2Count),
    WeekCount(week: 'This Week', count: w3Count),
  ];

  // Recruiter responses per vendor
  final responseCountsMap = <String, int>{};
  for (final r in recruiters) {
    responseCountsMap[r.company] = (responseCountsMap[r.company] ?? 0) + 1;
  }
  final recruiterResponses = responseCountsMap.entries
      .map((e) => RecruiterResponseCount(name: e.key, count: e.value))
      .toList()
    ..sort((a, b) => b.count.compareTo(a.count));

  // Interview Trend grouped by weekday
  final dayCounts = {'Mon': 0, 'Tue': 0, 'Wed': 0, 'Thu': 0, 'Fri': 0};
  final List<String> weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  for (final a in apps) {
    final isInterview = a.status.toLowerCase().contains('interview') ||
        a.status.toLowerCase().contains('round') ||
        a.status.toLowerCase().contains('test');
    if (isInterview) {
      try {
        final date = DateTime.parse(a.lastUpdated);
        final dayIndex = date.weekday - 1; // 0 for Mon, 6 for Sun
        if (dayIndex >= 0 && dayIndex < 5) {
          final dayName = weekdays[dayIndex];
          dayCounts[dayName] = (dayCounts[dayName] ?? 0) + 1;
        }
      } catch (_) {}
    }
  }
  final interviewTrend = dayCounts.entries
      .map((e) => DateCount(date: e.key, count: e.value))
      .toList();

  // Follow-ups due: active recruiters with nextFollowUp <= today
  final todayStr = now.toIso8601String().split('T')[0];
  final followUpsDue = recruiters.where((r) {
    if (r.nextFollowUp == null) return false;
    final cleanStatus = r.contactStatus.toLowerCase();
    final isActive = !cleanStatus.contains('offer') && !cleanStatus.contains('reject');
    return r.nextFollowUp!.compareTo(todayStr) <= 0 && isActive;
  }).toList();

  // Latest activity: sorted by lastUpdated desc
  final sortedApps = List<JobApplication>.from(apps)
    ..sort((a, b) => b.lastUpdated.compareTo(a.lastUpdated));
  final latestActivity = sortedApps.take(5).toList();

  // Upcoming interviews: applications in interview status
  final upcomingInterviews = apps.where((a) {
    final s = a.status.toLowerCase();
    return s.contains('interview') || s.contains('round') || s.contains('test');
  }).take(4).toList();

  return DashboardMetrics(
    totalOpportunities: totalOpportunities,
    activeRecruiters: activeRecruiters,
    interviewsCount: interviewsCount,
    offersCount: offersCount,
    responseRate: responseRate,
    totalApplications: totalApplications,
    respondedApplications: respondedApplications,
    applicationsPerWeek: applicationsPerWeek,
    recruiterResponses: recruiterResponses.take(5).toList(),
    interviewTrend: interviewTrend,
    followUpsDue: followUpsDue,
    latestActivity: latestActivity,
    upcomingInterviews: upcomingInterviews,
    allApplications: apps,
  );
});

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  Widget _buildKpiGrid(BuildContext context, DashboardMetrics metrics, bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
        return GridView.count(
          crossAxisCount: crossAxisCount.toInt(),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            _buildKpiCard('Active Loops', '${metrics.totalOpportunities}', Icons.track_changes, AppColors.darkAccentBlue, isDark),
            _buildKpiCard('Active Recruiters', '${metrics.activeRecruiters}', Icons.people_outline, AppColors.darkAccentPurple, isDark),
            _buildKpiCard('Interviews', '${metrics.interviewsCount}', Icons.calendar_today_outlined, AppColors.darkAccentAmber, isDark),
            _buildKpiCard('Offers Won', '${metrics.offersCount}', Icons.emoji_events_outlined, AppColors.darkAccentEmerald, isDark),
          ],
        );
      },
    );
  }

  Widget _buildKpiCard(String label, String value, IconData icon, Color color, bool isDark) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1.1),
              ),
              Icon(icon, size: 18, color: color),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: isDark ? Colors.white : AppColors.lightTextPrimary,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildChartsRow(BuildContext context, DashboardMetrics metrics) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 700) {
        return Row(
          children: [
            Expanded(child: _buildResponseRatePie(metrics)),
            const SizedBox(width: 16),
            Expanded(child: _buildWeeklyTrendsBar(metrics)),
          ],
        );
      }
      return Column(
        children: [
          _buildResponseRatePie(metrics),
          const SizedBox(height: 16),
          _buildWeeklyTrendsBar(metrics),
        ],
      );
    });
  }

  Widget _buildResponseRatePie(DashboardMetrics metrics) {
    final rate = metrics.responseRate;
    final unresponded = 100.0 - rate;

    return GlassCard(
      child: SizedBox(
        height: 160,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 4,
                  centerSpaceRadius: 30,
                  sections: [
                    PieChartSectionData(
                      color: AppColors.darkAccentBlue,
                      value: rate,
                      title: '${rate.round()}%',
                      radius: 20,
                      titleStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    PieChartSectionData(
                      color: Colors.white.withOpacity(0.06),
                      value: unresponded,
                      title: '',
                      radius: 20,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('RESPONSE RATE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1.1)),
                  const SizedBox(height: 6),
                  Text('${rate.round()}% replied', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w900, color: Colors.blueAccent)),
                  const SizedBox(height: 4),
                  Text('Out of ${metrics.totalApplications} total tracked opportunities.', style: const TextStyle(fontSize: 9, color: Colors.white54)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWeeklyTrendsBar(DashboardMetrics metrics) {
    return GlassCard(
      child: SizedBox(
        height: 160,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('WEEKLY ACTIVITY TREND', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1.1)),
              const SizedBox(height: 16),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 15,
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value.toInt() >= 0 && value.toInt() < metrics.applicationsPerWeek.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Text(
                                  metrics.applicationsPerWeek[value.toInt()].week,
                                  style: const TextStyle(fontSize: 9, color: Colors.white54, fontFamily: 'monospace'),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                      leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    barGroups: List.generate(metrics.applicationsPerWeek.length, (idx) {
                      return BarChartGroupData(
                        x: idx,
                        barRods: [
                          BarChartRodData(
                            toY: metrics.applicationsPerWeek[idx].count.toDouble(),
                            color: AppColors.darkAccentPurple,
                            width: 12,
                            borderRadius: BorderRadius.circular(4),
                          )
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFollowUpsAlert(BuildContext context, List<Recruiter> followUps) {
    if (followUps.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueAccent.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blueAccent.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flash_on, size: 16, color: Colors.blueAccent),
                const SizedBox(width: 6),
                Text(
                  'AI FOLLOW-UP ALERTS (${followUps.length} PENDING)',
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.1),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: followUps.length.clamp(0, 3), // show up to 3 alerts
              separatorBuilder: (context, idx) => const SizedBox(height: 8),
              itemBuilder: (context, idx) {
                final r = followUps[idx];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Bump ${r.recruiterName} (${r.company}) regarding ${r.role}.',
                        style: const TextStyle(fontSize: 11, color: Colors.white70),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chat_bubble_outline, size: 14, color: Colors.blueAccent),
                      onPressed: () => LinkUtils.triggerWhatsApp(r.recruiterPhone, r.recruiterName),
                    )
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsync = ref.watch(dashboardMetricsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(dashboardMetricsProvider.future),
        child: metricsAsync.when(
          loading: () => const Center(
            child: LuffyLoader(size: 48, loadingText: 'COMPILING DASHBOARD KPIs...'),
          ),
          error: (err, stack) => Center(
            child: Text('Error loading dashboard: $err'),
          ),
          data: (metrics) {
            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // KPI cards
                  _buildKpiGrid(context, metrics, isDark),
                  const SizedBox(height: 16),
                  
                  // Charts
                  _buildChartsRow(context, metrics),
                  const SizedBox(height: 16),

                  // Alerts
                  _buildFollowUpsAlert(context, metrics.followUpsDue),

                  // Recent activity & Interviews
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 700) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildUpcomingInterviews(metrics.upcomingInterviews)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildRecentActivity(metrics.latestActivity)),
                          ],
                        );
                      }
                      return Column(
                        children: [
                          _buildUpcomingInterviews(metrics.upcomingInterviews),
                          const SizedBox(height: 16),
                          _buildRecentActivity(metrics.latestActivity),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRecentActivity(List<JobApplication> items) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('RECENT ACTIVITY FEED', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1.1)),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, idx) => const Divider(height: 1, color: Colors.white10),
            itemBuilder: (context, idx) {
              final app = items[idx];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(app.company, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        Text(app.role, style: const TextStyle(fontSize: 9, color: Colors.white54)),
                      ],
                    ),
                    Text(
                      app.status,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildUpcomingInterviews(List<JobApplication> items) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('UPCOMING INTERVIEW LOOPS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 1.1)),
          const SizedBox(height: 12),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                'No upcoming interviews scheduled.',
                style: TextStyle(fontSize: 11, color: Colors.white54),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (context, idx) => const Divider(height: 1, color: Colors.white10),
              itemBuilder: (context, idx) {
                final app = items[idx];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(app.company, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          Text(app.role, style: const TextStyle(fontSize: 9, color: Colors.white54)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.darkAccentAmber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          app.status,
                          style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.darkAccentAmber),
                        ),
                      )
                    ],
                  ),
                );
              },
            )
        ],
      ),
    );
  }
}
