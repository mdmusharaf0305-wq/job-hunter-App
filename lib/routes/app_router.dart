import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../shared/services/providers.dart';
import '../shared/domain/dashboard_metrics.dart';

// Import Screens (to be implemented)
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/companies/presentation/company_directory_screen.dart';
import '../features/interviews/presentation/pipeline_screen.dart';
import '../features/applications/presentation/inbound_screen.dart';
import '../features/applications/presentation/outbound_screen.dart';
import '../features/interviews/presentation/timeline_screen.dart';
import '../features/recruiters/presentation/recruiters_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/resume/ResumeViewer.dart'; // We will use exact casing matching local files
import '../features/chat/ChatClient.dart';     // We will use exact casing matching local files

final rootNavigatorKey = GlobalKey<NavigatorState>();
final shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/dashboard',
  navigatorKey: rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: shellNavigatorKey,
      builder: (context, state, child) {
        return BaseNavigationScaffold(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/companies',
          builder: (context, state) => const CompanyDirectoryScreen(),
        ),
        GoRoute(
          path: '/pipeline',
          builder: (context, state) => const PipelineScreen(),
        ),
        GoRoute(
          path: '/inbound',
          builder: (context, state) => const InboundScreen(),
        ),
        GoRoute(
          path: '/outbound',
          builder: (context, state) => const OutboundScreen(),
        ),
        GoRoute(
          path: '/timeline',
          builder: (context, state) => const TimelineScreen(),
        ),
        GoRoute(
          path: '/recruiters',
          builder: (context, state) => const RecruitersScreen(),
        ),
        GoRoute(
          path: '/resume',
          builder: (context, state) => const ResumeViewerScreen(),
        ),
        GoRoute(
          path: '/chat',
          builder: (context, state) => const ChatClientScreen(),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsScreen(),
        ),
      ],
    ),
  ],
);

// Base Shell Scaffold providing common navigation across all hub pages
class BaseNavigationScaffold extends ConsumerStatefulWidget {
  final Widget child;

  const BaseNavigationScaffold({super.key, required this.child});

  @override
  ConsumerState<BaseNavigationScaffold> createState() => _BaseNavigationScaffoldState();
}

class _BaseNavigationScaffoldState extends ConsumerState<BaseNavigationScaffold> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/companies')) return 1;
    if (location.startsWith('/pipeline')) return 2;
    if (location.startsWith('/inbound')) return 3;
    if (location.startsWith('/outbound')) return 4;
    if (location.startsWith('/timeline')) return 5;
    if (location.startsWith('/recruiters')) return 6;
    if (location.startsWith('/resume')) return 7;
    if (location.startsWith('/chat')) return 8;
    if (location.startsWith('/profile')) return 9;
    if (location.startsWith('/settings')) return 10;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/companies');
        break;
      case 2:
        context.go('/pipeline');
        break;
      case 3:
        context.go('/inbound');
        break;
      case 4:
        context.go('/outbound');
        break;
      case 5:
        context.go('/timeline');
        break;
      case 6:
        context.go('/recruiters');
        break;
      case 7:
        context.go('/resume');
        break;
      case 8:
        context.go('/chat');
        break;
      case 9:
        context.go('/profile');
        break;
      case 10:
        context.go('/settings');
        break;
    }
  }

  Widget _buildSidebarItem({
    required BuildContext context,
    required int index,
    required String label,
    required String emoji,
    required int selectedIndex,
  }) {
    final isActive = index == selectedIndex;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        final scaffold = Scaffold.maybeOf(context);
        if (scaffold != null && scaffold.isDrawerOpen) {
          Navigator.of(context).pop();
        }
        _onItemTapped(index, context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive
              ? (isDark ? Colors.white.withOpacity(0.08) : Colors.black.withOpacity(0.05))
              : Colors.transparent,
          border: isActive
              ? Border(
                  left: BorderSide(
                    color: isDark ? Colors.blueAccent : Colors.blue,
                    width: 4,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive
                      ? (isDark ? Colors.white : Colors.black87)
                      : (isDark ? Colors.white70 : Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIFollowUpWidget(BuildContext context, int count, bool isDark) {
    final bgColor = isDark
        ? Colors.blueAccent.withOpacity(0.15)
        : Colors.blue.shade50;
    final borderColor = isDark
        ? Colors.blueAccent.withOpacity(0.25)
        : Colors.blue.shade100;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                size: 14,
                color: isDark ? Colors.blueAccent : Colors.blue.shade700,
              ),
              const SizedBox(width: 6),
              Text(
                "AI Follow-up Alert",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.blue.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            "You have $count follow-up${count > 1 ? 's' : ''} pending.",
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white70 : Colors.blue.shade800,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              final scaffold = Scaffold.maybeOf(context);
              if (scaffold != null && scaffold.isDrawerOpen) {
                Navigator.of(context).pop();
              }
              _onItemTapped(0, context); // Go to dashboard
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Review actions",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.blueAccent : Colors.blue.shade700,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(
                  Icons.chevron_right,
                  size: 12,
                  color: isDark ? Colors.blueAccent : Colors.blue.shade700,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _calculateSelectedIndex(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    // Watch metrics to get follow-up alert counts
    final metricsAsync = ref.watch(dashboardMetricsProvider);
    final int followUpsCount = metricsAsync.value?.followUpsDue.length ?? 0;

    final navDestinations = const [
      NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
      NavigationDestination(icon: Icon(Icons.business_outlined), label: 'Companies'),
      NavigationDestination(icon: Icon(Icons.gps_fixed), label: 'Pipeline'),
      NavigationDestination(icon: Icon(Icons.move_to_inbox), label: 'Inbound'),
      NavigationDestination(icon: Icon(Icons.outbox), label: 'Outbound'),
      NavigationDestination(icon: Icon(Icons.history_edu), label: 'History'),
      NavigationDestination(icon: Icon(Icons.people_outline), label: 'Recruiters'),
      NavigationDestination(icon: Icon(Icons.description_outlined), label: 'Resume'),
      NavigationDestination(icon: Icon(Icons.android), label: 'AI Chat'),
      NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profile'),
      NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
    ];

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 720) {
            // Premium Adaptive Web-style Sidebar for tablets and desktops
            return Row(
              children: [
                Container(
                  width: 256,
                  color: isDark ? const Color(0xFF0F0F15) : Colors.white,
                  child: Column(
                    children: [
                      // Brand Header
                      Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: isDark ? Colors.white10 : Colors.black12,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(
                                  colors: [Colors.blueAccent, Colors.indigoAccent, Colors.cyan],
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                ),
                              ),
                              child: const Icon(
                                Icons.layers,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "MUSHARRAF'S",
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontFamily: 'monospace',
                                    fontWeight: FontWeight.bold,
                                    color: isDark ? Colors.white70 : Colors.black54,
                                    letterSpacing: 1.5,
                                  ),
                                ),
                                Text(
                                  "Job Hunt",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: isDark ? Colors.white : Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      
                      // Navigation List
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                          children: [
                            _buildSidebarItem(
                              context: context,
                              index: 0,
                              label: 'Dashboard',
                              emoji: '📊',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 1,
                              label: 'Companies Watchlist',
                              emoji: '🏢',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 2,
                              label: 'Current Pipeline',
                              emoji: '🎯',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 3,
                              label: 'Inbound Applications',
                              emoji: '📥',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 4,
                              label: 'Outbound Applications',
                              emoji: '📤',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 5,
                              label: 'Applications History',
                              emoji: '📜',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 6,
                              label: 'Recruiters',
                              emoji: '👥',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 7,
                              label: 'Resume PDF',
                              emoji: '📄',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 8,
                              label: 'AI Job Assistant',
                              emoji: '🤖',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 9,
                              label: 'Candidate Profile',
                              emoji: '👤',
                              selectedIndex: selectedIndex,
                            ),
                            _buildSidebarItem(
                              context: context,
                              index: 10,
                              label: 'API Credentials',
                              emoji: '⚙️',
                              selectedIndex: selectedIndex,
                            ),
                          ],
                        ),
                      ),

                      // AI Follow-up Alert Widget
                      if (followUpsCount > 0)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _buildAIFollowUpWidget(context, followUpsCount, isDark),
                        ),

                      // Footer Helper
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              color: isDark ? Colors.white10 : Colors.black12,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Outreach Helper",
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: isDark ? Colors.white54 : Colors.black54,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: isDark ? Colors.white10 : Colors.black12,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: isDark ? Colors.white10 : Colors.black12,
                                ),
                              ),
                              child: Text(
                                "⌥ F",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: 'monospace',
                                  color: isDark ? Colors.white70 : Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Vertical divider
                VerticalDivider(
                  thickness: 1, 
                  width: 1, 
                  color: isDark ? Colors.white10 : Colors.black12,
                ),
                
                // Content
                Expanded(child: widget.child),
              ],
            );
          }
          
          return widget.child;
        },
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 720) {
            // Standard M3 Bottom Navigation Bar for phones
            return NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (idx) => _onItemTapped(idx, context),
              destinations: navDestinations.take(5).toList(), // Limit bottom navigation on phones
            );
          }
          return const SizedBox.shrink();
        },
      ),
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 720) {
            return Drawer(
              child: SafeArea(
                child: Column(
                  children: [
                    // Brand Header
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: isDark 
                              ? [const Color(0xFF1E1E2C), const Color(0xFF0F0F15)]
                              : [Colors.blue, Colors.indigo],
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: const LinearGradient(
                                colors: [Colors.blueAccent, Colors.indigoAccent, Colors.cyan],
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                              ),
                            ),
                            child: const Icon(
                              Icons.layers,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "MUSHARRAF'S",
                                style: TextStyle(
                                  fontSize: 9,
                                  fontFamily: 'monospace',
                                  color: isDark ? Colors.white70 : Colors.white70,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              const Text(
                                "Job Hunt",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Navigation List
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(12),
                        children: [
                          _buildSidebarItem(
                            context: context,
                            index: 0,
                            label: 'Dashboard',
                            emoji: '📊',
                            selectedIndex: selectedIndex,
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 1,
                            label: 'Companies Watchlist',
                            emoji: '🏢',
                            selectedIndex: selectedIndex,
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 2,
                            label: 'Current Pipeline',
                            emoji: '🎯',
                            selectedIndex: selectedIndex,
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 3,
                            label: 'Inbound Applications',
                            emoji: '📥',
                            selectedIndex: selectedIndex,
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 4,
                            label: 'Outbound Applications',
                            emoji: '📤',
                            selectedIndex: selectedIndex,
                            
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 5,
                            label: 'Applications History',
                            emoji: '📜',
                            selectedIndex: selectedIndex,
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 6,
                            label: 'Recruiters',
                            emoji: '👥',
                            selectedIndex: selectedIndex,
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 7,
                            label: 'Resume PDF',
                            emoji: '📄',
                            selectedIndex: selectedIndex,
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 8,
                            label: 'AI Job Assistant',
                            emoji: '🤖',
                            selectedIndex: selectedIndex,
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 9,
                            label: 'Candidate Profile',
                            emoji: '👤',
                            selectedIndex: selectedIndex,
                          ),
                          _buildSidebarItem(
                            context: context,
                            index: 10,
                            label: 'API Credentials',
                            emoji: '⚙️',
                            selectedIndex: selectedIndex,
                          ),
                        ],
                      ),
                    ),
                    
                    // AI Follow-up Alert Widget in Drawer
                    if (followUpsCount > 0)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        child: _buildAIFollowUpWidget(context, followUpsCount, isDark),
                      ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
