import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/presentation/glass_card.dart';
import '../../../shared/presentation/luffy_loader.dart';
import '../../../shared/domain/job_application.dart';
import '../../../core/constants/app_colors.dart';

// Provider to query active pipeline apps
final pipelineAppsProvider = FutureProvider<List<JobApplication>>((ref) async {
  final repo = ref.watch(applicationsRepositoryProvider);
  final apps = await repo.fetchAndCacheApplications();
  return apps.where((a) {
    final status = a.status.toLowerCase().replaceAll(RegExp(r'[^\w]'), '');
    return ['sourcing', 'screening', 'interview', 'applied', 'hrscreening', 'interviewscheduled'].contains(status);
  }).toList();
});

class PipelineScreen extends ConsumerWidget {
  const PipelineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pipelineAsync = ref.watch(pipelineAppsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Pipeline', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(pipelineAppsProvider.future),
        child: pipelineAsync.when(
          loading: () => const Center(
            child: LuffyLoader(size: 48, loadingText: 'COMPILING RECRUITMENT PIPELINE...'),
          ),
          error: (err, stack) => Center(child: Text('Error loading pipeline: $err')),
          data: (list) {
            if (list.isEmpty) {
              return const Center(
                child: Text(
                  'No active pipeline loops found.\nSync from settings or import outbound applications.',
                  style: TextStyle(color: Colors.white54, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: list.length,
              itemBuilder: (context, idx) {
                final app = list[idx];
                final priorityColor = app.priority == 'High'
                    ? AppColors.priorityHigh
                    : (app.priority == 'Medium'
                        ? AppColors.priorityMedium
                        : AppColors.priorityLow);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: GlassCard(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Priority side tag indicator
                        Container(
                          width: 4,
                          height: 50,
                          decoration: BoxDecoration(
                            color: priorityColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      app.company,
                                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w900),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.getStatusColor(app.status, isDark).withOpacity(0.12),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      app.status,
                                      style: TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.getStatusColor(app.status, isDark),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                app.role,
                                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  if (app.location != null) ...[
                                    const Icon(Icons.location_on_outlined, size: 12, color: Colors.white54),
                                    const SizedBox(width: 4),
                                    Text(
                                      app.location!,
                                      style: const TextStyle(fontSize: 10, color: Colors.white54),
                                    ),
                                    const SizedBox(width: 12),
                                  ],
                                  if (app.workMode != null) ...[
                                    const Icon(Icons.work_outline, size: 12, color: Colors.white54),
                                    const SizedBox(width: 4),
                                    Text(
                                      app.workMode!,
                                      style: const TextStyle(fontSize: 10, color: Colors.white54),
                                    ),
                                  ],
                                ],
                              )
                            ],
                          ),
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
    );
  }
}
