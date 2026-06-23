import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/domain/recruiter.dart';
import '../../../shared/domain/timeline_event.dart';
import '../../../core/utils/link_utils.dart';
import '../../../shared/presentation/glass_card.dart';

class CallLogModal extends ConsumerStatefulWidget {
  final Recruiter recruiter;
  final VoidCallback onSaved;

  const CallLogModal({
    super.key,
    required this.recruiter,
    required this.onSaved,
  });

  @override
  ConsumerState<CallLogModal> createState() => _CallLogModalState();
}

class _CallLogModalState extends ConsumerState<CallLogModal> {
  String _callStatus = 'Completed';
  double _callDuration = 5.0; // minutes
  final _notesController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _makeCall() async {
    await LinkUtils.triggerPhone(widget.recruiter.recruiterPhone);
  }

  Future<void> _saveLog() async {
    setState(() => _isSaving = true);
    final appsRepo = ref.read(applicationsRepositoryProvider);
    final interviewsRepo = ref.read(interviewsRepositoryProvider);

    final statusNote = '📞 Call Log [$_callStatus] - Duration: ${_callDuration.round()} mins. Notes: ${_notesController.text.trim()}';

    try {
      // 1. Create a follow-up timeline event linked to the opportunity
      await interviewsRepo.createEvent(
        TimelineEvent(
          id: '',
          opportunity: widget.recruiter.id, // linked app ID
          title: 'Recruiter Call logged',
          date: DateTime.now().toIso8601String().split('T')[0],
          category: 'Follow-up',
          virtualMode: 'Phone call',
          notes: statusNote,
        ),
      );

      // 2. Update the call status directly on the opportunity details
      await appsRepo.updateOpportunity(widget.recruiter.id, {
        'callStatus': _callStatus == 'Completed' ? 'Dailed' : 'No Called',
        'lastContactedDate': DateTime.now().toIso8601String().split('T')[0],
      });

      widget.onSaved();

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logged call with ${widget.recruiter.recruiterName} successfully!'),
            backgroundColor: Colors.teal,
          ),
        );
      }
    } catch (e) {
      setState(() => _isSaving = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to log call outcome: $e'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final r = widget.recruiter;

    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F0F15) : const Color(0xFFF9FAFB),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Log Call Activity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            const SizedBox(height: 12),
            
            // Recruiter Details Header
            Text(
              r.recruiterName,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 2),
            Text(
              '${r.role} at ${r.company}',
              style: const TextStyle(fontSize: 11, color: Colors.white70),
            ),
            const SizedBox(height: 20),

            // Dialer Quick Action
            ElevatedButton.icon(
              icon: const Icon(Icons.phone, size: 16),
              label: const Text('Dial Number Now', style: TextStyle(fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onPressed: _makeCall,
            ),
            const SizedBox(height: 20),

            // Status Dropdown
            const Text('CALL OUTCOME STATUS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              value: _callStatus,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white.withOpacity(0.04),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
              ),
              dropdownColor: const Color(0xFF1E1E26),
              items: ['Completed', 'Scheduled', 'Missed'].map((opt) {
                return DropdownMenuItem<String>(value: opt, child: Text(opt));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _callStatus = val);
              },
            ),
            const SizedBox(height: 16),

            // Call minutes slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('CALL DURATION (MINUTES)', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                Text(
                  '${_callDuration.round()} mins',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueAccent, fontFamily: 'monospace'),
                ),
              ],
            ),
            Slider(
              value: _callDuration,
              min: 1.0,
              max: 60.0,
              divisions: 59,
              activeColor: Colors.blueAccent,
              inactiveColor: Colors.white12,
              onChanged: (val) {
                setState(() => _callDuration = val);
              },
            ),
            const SizedBox(height: 16),

            // Notes
            const Text('📋 DIALER CALL NOTES', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
            const SizedBox(height: 6),
            TextField(
              controller: _notesController,
              maxLines: 2,
              decoration: InputDecoration(
                hintText: 'e.g. Discussed notice period, salary ranges...',
                hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
                filled: true,
                fillColor: Colors.white.withOpacity(0.04),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveLog,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isSaving
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : const Text('Save Call Logs', style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
