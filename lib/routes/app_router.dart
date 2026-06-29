import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
class BaseNavigationScaffold extends StatefulWidget {
  final Widget child;

  const BaseNavigationScaffold({super.key, required this.child});

  @override
  State<BaseNavigationScaffold> createState() => _BaseNavigationScaffoldState();
}

class _BaseNavigationScaffoldState extends State<BaseNavigationScaffold> {
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

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _calculateSelectedIndex(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

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

    // For mobile portrait views, we use a standard NavigationBar (Material 3 bottom nav bar)
    // For tablet/landscape, we adapt to a NavigationRail layout! This gives native adaptive UI.
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 720) {
            // Adaptive Navigation Rail for larger screens
            return Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (idx) => _onItemTapped(idx, context),
                  labelType: NavigationRailLabelType.selected,
                  destinations: navDestinations
                      .map((d) => NavigationRailDestination(
                            icon: d.icon,
                            selectedIcon: d.selectedIcon ?? d.icon,
                            label: Text(d.label),
                          ))
                      .toList(),
                ),
                const VerticalDivider(thickness: 1, width: 1),
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
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const DrawerHeader(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue, Colors.indigo],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Musharraf's",
                            style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: Colors.white70),
                          ),
                          Text(
                            "Job Command Center",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.dashboard_outlined),
                      title: const Text('Dashboard'),
                      selected: selectedIndex == 0,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(0, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.business_outlined),
                      title: const Text('Companies Watchlist'),
                      selected: selectedIndex == 1,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(1, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.gps_fixed),
                      title: const Text('Current Pipeline'),
                      selected: selectedIndex == 2,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(2, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.move_to_inbox),
                      title: const Text('Inbound Applications'),
                      selected: selectedIndex == 3,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(3, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.outbox),
                      title: const Text('Outbound Applications'),
                      selected: selectedIndex == 4,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(4, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.history_edu),
                      title: const Text('Applications History'),
                      selected: selectedIndex == 5,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(5, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.people_outline),
                      title: const Text('Recruiters'),
                      selected: selectedIndex == 6,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(6, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.description_outlined),
                      title: const Text('Resume PDF'),
                      selected: selectedIndex == 7,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(7, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.android),
                      title: const Text('AI Job Assistant'),
                      selected: selectedIndex == 8,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(8, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.person_outline),
                      title: const Text('Candidate Profile'),
                      selected: selectedIndex == 9,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(9, context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings_outlined),
                      title: const Text('API Credentials'),
                      selected: selectedIndex == 10,
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(10, context);
                      },
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
