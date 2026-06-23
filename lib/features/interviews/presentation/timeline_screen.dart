import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/presentation/glass_card.dart';
import '../../../shared/presentation/luffy_loader.dart';
import '../../../shared/domain/timeline_event.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/utils/date_utils.dart';

// Provider to query timeline events
final timelineEventsProvider = FutureProvider<List<TimelineEvent>>((ref) async {
  final repo = ref.watch(interviewsRepositoryProvider);
  return await repo.fetchAndCacheEvents();
});

class TimelineScreen extends ConsumerStatefulWidget {
  const TimelineScreen({super.key});

  @override
  ConsumerState<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends ConsumerState<TimelineScreen> {
  final _eventTitleController = TextEditingController();
  final _eventNotesController = TextEditingController();
  String _category = 'Interview';
  String _virtualMode = 'Google Meet';
  bool _isSaving = false;

  @override
  void dispose() {
    _eventTitleController.dispose();
    _eventNotesController.dispose();
    super.dispose();
  }

  Future<void> _logEvent(String opportunityId) async {
    final title = _eventTitleController.text.trim();
    if (title.isEmpty) return;

    setState(() => _isSaving = true);
    final repo = ref.read(interviewsRepositoryProvider);

    final event = TimelineEvent(
      id: '',
      opportunity: opportunityId,
      title: title,
      date: DateTime.now().toIso8601String().split('T')[0],
      category: _category,
      virtualMode: _virtualMode,
      notes: _eventNotesController.text.trim(),
    );

    try {
      await repo.createEvent(event);
      _eventTitleController.clear();
      _eventNotesController.clear();
      setState(() => _isSaving = false);
      ref.invalidate(timelineEventsProvider);
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Timeline Activity logged successfully!'),
            backgroundColor: Colors.teal,
          ),
        );
      }
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to log event: $e'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  void _openLogEventSheet(BuildContext context) async {
    final appsRepo = ref.read(applicationsRepositoryProvider);
    final apps = await appsRepo.getCachedApplications();
    final activeApps = apps.where((a) {
      final s = a.status.toLowerCase();
      return !s.contains('reject') && !s.contains('drop');
    }).toList();

    if (activeApps.isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Create an active opportunity first to log timeline events.')),
        );
      }
      return;
    }

    String selectedOppId = activeApps.first.id;

    if (context.mounted) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => StatefulBuilder(
          builder: (context, setSheetState) {
            final mediaQuery = MediaQuery.of(context);
            return Container(
              padding: EdgeInsets.only(
                top: 24,
                left: 24,
                right: 24,
                bottom: mediaQuery.viewInsets.bottom + 24,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF0F0F15),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Log Timeline Event', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 16),
                    
                    // Opportunity relation dropdown
                    const Text('ASSOCIATED OPPORTUNITY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      value: selectedOppId,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.04),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                      ),
                      dropdownColor: const Color(0xFF1E1E26),
                      items: activeApps.map((opt) {
                        return DropdownMenuItem<String>(
                          value: opt.id,
                          child: Text('${opt.company} - ${opt.role}', style: const TextStyle(fontSize: 12)),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) setSheetState(() => selectedOppId = val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('EVENT TITLE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _eventTitleController,
                          decoration: InputDecoration(
                            hintText: 'e.g. Technical Round 1, Manager Chat',
                            hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.04),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Select Category & Virtual Mode
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('CATEGORY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                value: _category,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.04),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                                ),
                                dropdownColor: const Color(0xFF1E1E26),
                                items: ['Interview', 'Assignment', 'Follow-up'].map((opt) {
                                  return DropdownMenuItem<String>(value: opt, child: Text(opt));
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) setSheetState(() => _category = val);
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('VIRTUAL MODE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                              const SizedBox(height: 6),
                              DropdownButtonFormField<String>(
                                value: _virtualMode,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.04),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                                ),
                                dropdownColor: const Color(0xFF1E1E26),
                                items: ['Google Meet', 'Zoom', 'Teams', 'Phone call'].map((opt) {
                                  return DropdownMenuItem<String>(value: opt, child: Text(opt));
                                }).toList(),
                                onChanged: (val) {
                                  if (val != null) setSheetState(() => _virtualMode = val);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Notes
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('📋 NOTES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                        const SizedBox(height: 6),
                        TextField(
                          controller: _eventNotesController,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: 'Enter feedback details...',
                            hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.04),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isSaving ? null : () => _logEvent(selectedOppId),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Save Event Log', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  IconData _getCategoryIcon(String cat) {
    switch (cat.toLowerCase()) {
      case 'interview':
        return Icons.calendar_today_outlined;
      case 'assignment':
        return Icons.code;
      case 'follow-up':
        return Icons.rate_review;
      default:
        return Icons.info_outline;
    }
  }

  Color _getCategoryColor(String cat) {
    switch (cat.toLowerCase()) {
      case 'interview':
        return AppColors.darkAccentAmber;
      case 'assignment':
        return AppColors.darkAccentPurple;
      case 'follow-up':
        return AppColors.darkAccentBlue;
      default:
        return Colors.white54;
    }
  }

  @override
  Widget build(BuildContext context) {
    final timelineAsync = ref.watch(timelineEventsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications History', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_outlined, color: Colors.blueAccent),
            onPressed: () => _openLogEventSheet(context),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(timelineEventsProvider.future),
        child: timelineAsync.when(
          loading: () => const Center(
            child: LuffyLoader(size: 48, loadingText: 'COMPILING TIMELINE LOGS...'),
          ),
          error: (err, stack) => Center(child: Text('Error loading history: $err')),
          data: (list) {
            if (list.isEmpty) {
              return const Center(child: Text('No timeline events logged. Log a call or add an event.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: list.length,
              itemBuilder: (context, idx) {
                final event = list[idx];
                final icon = _getCategoryIcon(event.category);
                final color = _getCategoryColor(event.category);

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Circular icon connector
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color.withOpacity(0.12),
                          border: Border.all(color: color.withOpacity(0.3), width: 1.5),
                        ),
                        child: Icon(icon, size: 14, color: color),
                      ),
                      const SizedBox(width: 16),
                      
                      // Event details card
                      Expanded(
                        child: GlassCard(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    event.title,
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.white),
                                  ),
                                  Text(
                                    AppDateUtils.formatDateShort(event.date),
                                    style: const TextStyle(fontSize: 9, color: Colors.white54, fontFamily: 'monospace'),
                                  )
                                ],
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: color.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      event.category,
                                      style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: color),
                                    ),
                                  ),
                                  if (event.virtualMode.isNotEmpty) ...[
                                    const SizedBox(width: 8),
                                    Text(
                                      '• ${event.virtualMode}',
                                      style: const TextStyle(fontSize: 9, color: Colors.white60),
                                    ),
                                  ]
                                ],
                              ),
                              if (event.notes.isNotEmpty) ...[
                                const SizedBox(height: 10),
                                Text(
                                  event.notes,
                                  style: const TextStyle(fontSize: 11, color: Colors.white70, height: 1.35),
                                ),
                              ],
                            ],
                          ),
                        ),
                      )
                    ],
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
