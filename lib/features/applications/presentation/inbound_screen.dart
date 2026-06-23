import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/presentation/glass_card.dart';
import '../../../shared/presentation/luffy_loader.dart';
import '../../../shared/domain/job_application.dart';
import '../../../core/constants/app_colors.dart';
import 'application_modal.dart';

// Provider to query inbound applications
final inboundAppsProvider = FutureProvider<List<JobApplication>>((ref) async {
  final repo = ref.watch(applicationsRepositoryProvider);
  final apps = await repo.fetchAndCacheApplications();
  return apps.where((a) => a.type == 'inbound').toList();
});

class InboundScreen extends ConsumerStatefulWidget {
  const InboundScreen({super.key});

  @override
  ConsumerState<InboundScreen> createState() => _InboundScreenState();
}

class _InboundScreenState extends ConsumerState<InboundScreen> {
  String _searchQuery = '';
  String _priorityFilter = 'All';

  Future<void> _updateStage(String id, String newStage) async {
    final repo = ref.read(applicationsRepositoryProvider);
    await repo.updateStage(id, newStage);
    ref.invalidate(inboundAppsProvider);
  }

  void _openApplicationModal(BuildContext context, [JobApplication? app]) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ApplicationModal(
        application: app,
        defaultType: 'inbound',
        onSaved: () => ref.invalidate(inboundAppsProvider),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appsAsync = ref.watch(inboundAppsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbound Tracker', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline, color: Colors.blueAccent),
            onPressed: () => _openApplicationModal(context),
          )
        ],
      ),
      body: Column(
        children: [
          // Filter Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search inbound leads...',
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
              onRefresh: () => ref.refresh(inboundAppsProvider.future),
              child: appsAsync.when(
                loading: () => const Center(
                  child: LuffyLoader(size: 48, loadingText: 'COMPILING COLD LEADS & OUTREACHES...'),
                ),
                error: (err, stack) => Center(child: Text('Error: $err')),
                data: (list) {
                  var filtered = list.where((a) {
                    final matchesSearch = a.company.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        a.role.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        (a.recruiterName ?? '').toLowerCase().contains(_searchQuery.toLowerCase());
                    final matchesPriority = _priorityFilter == 'All' || a.priority == _priorityFilter;
                    return matchesSearch && matchesPriority;
                  }).toList();

                  if (filtered.isEmpty) {
                    return const Center(child: Text('No inbound opportunities tracked.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: filtered.length,
                    itemBuilder: (context, idx) {
                      final app = filtered[idx];
                      final isPriorityHigh = app.priority == 'High';

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
                                    if (isPriorityHigh)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.priorityHigh.withOpacity(0.12),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: const Text(
                                          '🔴 High',
                                          style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppColors.priorityHigh),
                                        ),
                                      )
                                  ],
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  app.role,
                                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white70),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Recruiter: ${app.recruiterName ?? "Unknown"}',
                                      style: const TextStyle(fontSize: 10, color: Colors.white54),
                                    ),
                                    
                                    // Quick Status Stage changer
                                    DropdownButton<String>(
                                      value: ['📄 Applied', '📞 HR Screening', '🗓️ Interview Scheduled', '🎉 Offer Received', '❌ Rejected', '⏸️ On Hold']
                                              .contains(app.status)
                                          ? app.status
                                          : '📄 Applied',
                                      dropdownColor: const Color(0xFF1E1E26),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.getStatusColor(app.status, isDark),
                                      ),
                                      underline: const SizedBox.shrink(),
                                      items: ['📄 Applied', '📞 HR Screening', '🗓️ Interview Scheduled', '🎉 Offer Received', '❌ Rejected', '⏸️ On Hold'].map((opt) {
                                        return DropdownMenuItem<String>(
                                          value: opt,
                                          child: Text(opt),
                                        );
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
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
