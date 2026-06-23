import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/domain/job_application.dart';
import '../../../shared/presentation/glass_card.dart';

class ChatMessage {
  final String id;
  final String sender; // 'bot' | 'user'
  final String text;
  final DateTime timestamp;
  final String? reportType; // 'metrics' | 'table' | 'opportunity' | 'success'
  final dynamic reportData;

  ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.timestamp,
    this.reportType,
    this.reportData,
  });
}

class ChatClientScreen extends ConsumerStatefulWidget {
  const ChatClientScreen({super.key});

  @override
  ConsumerState<ChatClientScreen> createState() => _ChatClientScreenState();
}

class _ChatClientScreenState extends ConsumerState<ChatClientScreen> {
  final List<ChatMessage> _messages = [];
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    // Default welcome message
    _messages.add(
      ChatMessage(
        id: 'welcome',
        sender: 'bot',
        text: "Hello! I am your AI Job Hunter OS Assistant. I am directly synced with your Notion DB. You can ask me to query your pipeline or make modifications in real-time.\n\n**Try commands like:**\n- `add job at Stripe as Lead React Engineer`\n- `mark Microsoft as Interviewing`\n- `show active interviews`\n- `pipeline summary`\n- `who needs follow up?`",
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String _mapInputToStage(String input) {
    final clean = input.toLowerCase().trim();
    if (clean.contains('source') || clean.contains('apply') || clean.contains('applied') || clean.contains('start')) {
      return '📄 Applied';
    }
    if (clean.contains('screen') || clean.contains('hr') || clean.contains('shortlist')) {
      return '📞 HR Screening';
    }
    if (clean.contains('interview') || clean.contains('technical') || clean.contains('manager') || clean.contains('test') || clean.contains('round')) {
      return '🗓️ Interview Scheduled';
    }
    if (clean.contains('paused') || clean.contains('hold') || clean.contains('wait')) {
      return '⏸️ On Hold';
    }
    if (clean.contains('offer') || clean.contains('won') || clean.contains('sec')) {
      return '🎉 Offer Received';
    }
    if (clean.contains('reject') || clean.contains('drop') || clean.contains('fail') || clean.contains('lost')) {
      return '❌ Rejected';
    }
    return '📄 Applied'; // fallback
  }

  Future<void> _handleSendMessage(String textToSend) async {
    if (textToSend.trim().isEmpty) return;

    final userMsg = ChatMessage(
      id: 'user-${DateTime.now().millisecondsSinceEpoch}',
      sender: 'user',
      text: textToSend,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMsg);
      _textController.clear();
      _isTyping = true;
    });
    _scrollToBottom();

    final query = textToSend.toLowerCase().trim();
    final appsRepo = ref.read(applicationsRepositoryProvider);
    final apps = await appsRepo.getCachedApplications();

    await Future.delayed(const Duration(milliseconds: 800)); // Simulate typing latency

    // 1. COMMAND: ADD JOB
    // Pattern: add job at [Company] as [Role] status [Stage]
    final addRegex = RegExp(
        r'(?:add|create|new)\s+(?:job|app|application|opportunity)?\s*(?:at|for)?\s*([a-zA-Z0-9\s\.\-\&\#]+?)(?:\s+(?:as|role)\s+([a-zA-Z0-9\s\.\-\&\#]+))?(?:\s+(?:status|stage)\s+([a-zA-Z\s]+))?$',
        caseSensitive: false);
    
    if (addRegex.hasMatch(textToSend) &&
        (query.startsWith('add') || query.startsWith('create') || query.startsWith('new'))) {
      final match = addRegex.firstMatch(textToSend)!;
      final company = match.group(1)!.trim();
      final role = match.group(2) != null ? match.group(2)!.trim() : 'Software Engineer';
      final rawStatus = match.group(3) != null ? match.group(3)!.trim() : 'sourcing';
      final mappedStatus = _mapInputToStage(rawStatus);

      try {
        final created = await appsRepo.createOpportunity({
          'company': company,
          'role': role,
          'status': mappedStatus,
          'priority': 'Medium',
          'type': 'outbound',
        });

        _addBotMessage(
          text: "I've created a new outbound application for **$company** in your Notion DB.",
          reportType: 'success',
          reportData: created,
        );
      } catch (e) {
        _addBotMessage(text: "❌ Failed to create application: $e");
      }
      return;
    }

    // 2. COMMAND: UPDATE STAGE
    // Pattern: update [Company] status/stage to [Stage]
    final updateRegex = RegExp(
        r'(?:update|change|set|mark)\s+([a-zA-Z0-9\s\.\-\&\#]+?)\s+(?:status|stage)?\s*(?:to)?\s*([a-zA-Z0-9\s\-\_]+)$',
        caseSensitive: false);

    if (updateRegex.hasMatch(textToSend) &&
        (query.startsWith('update') || query.startsWith('change') || query.startsWith('set') || query.startsWith('mark'))) {
      final match = updateRegex.firstMatch(textToSend)!;
      final companyName = match.group(1)!.trim().toLowerCase();
      final targetStageStr = match.group(2)!.trim();
      final mappedStage = _mapInputToStage(targetStageStr);

      final targetApp = apps.firstWhere(
        (a) => a.company.toLowerCase() == companyName || a.company.toLowerCase().contains(companyName),
        orElse: () => const JobApplication(id: '', role: '', company: '', type: '', status: '', lastUpdated: ''),
      );

      if (targetApp.id.isEmpty) {
        _addBotMessage(text: "Sorry, I couldn't find any tracked application for \"${match.group(1)!.trim()}\" in your database.");
        return;
      }

      try {
        final updated = await appsRepo.updateStage(targetApp.id, mappedStage);
        _addBotMessage(
          text: "Updated status for **${updated.company}** to **$mappedStage** in Notion.",
          reportType: 'success',
          reportData: updated,
        );
      } catch (e) {
        _addBotMessage(text: "❌ Failed to update application: $e");
      }
      return;
    }

    // 3. COMMAND: PIPELINE SUMMARY
    if (query.contains('pipeline') || query.contains('summary') || query.contains('stats') || query.contains('metrics')) {
      final active = apps.where((a) => !a.status.toLowerCase().contains('reject') && !a.status.toLowerCase().contains('drop') && !a.status.toLowerCase().contains('offer')).length;
      final screening = apps.where((a) => a.status.toLowerCase().contains('screen') || a.status.toLowerCase().contains('hr')).length;
      final interviews = apps.where((a) => a.status.toLowerCase().contains('interview') || a.status.toLowerCase().contains('round') || a.status.toLowerCase().contains('test')).length;
      final offers = apps.where((a) => a.status.toLowerCase().contains('offer') || a.status.toLowerCase().contains('received')).length;

      _addBotMessage(
        text: "Here is your Notion pipeline health summary. Everything is synced real-time:",
        reportType: 'metrics',
        reportData: {
          'total': active,
          'screening': screening,
          'interviews': interviews,
          'offers': offers,
        },
      );
      return;
    }

    // 4. COMMAND: ACTIVE INTERVIEWS
    if (query.contains('interview')) {
      final loops = apps.where((a) => a.status.toLowerCase().contains('interview') || a.status.toLowerCase().contains('round') || a.status.toLowerCase().contains('test')).toList();

      if (loops.isEmpty) {
        _addBotMessage(text: "You don't have any active interview loops scheduled at the moment.");
      } else {
        _addBotMessage(
          text: "You have **${loops.length} active interview loops** in progress:",
          reportType: 'table',
          reportData: loops,
        );
      }
      return;
    }

    // 5. COMMAND: PENDING FOLLOW-UPS
    if (query.contains('follow up') || query.contains('follow-up') || query.contains('pending') || query.contains('action')) {
      final sevenDaysAgo = DateTime.now().subtract(const Duration(days: 7));
      final followUps = apps.where((a) {
        final isActive = !a.status.toLowerCase().contains('reject') && !a.status.toLowerCase().contains('drop') && !a.status.toLowerCase().contains('offer');
        final hasRecruiter = a.recruiterName != null && a.recruiterName!.isNotEmpty;
        if (!isActive || !hasRecruiter) return false;
        if (a.lastContactedDate == null) return true;
        try {
          return DateTime.parse(a.lastContactedDate!).isBefore(sevenDaysAgo);
        } catch (_) {
          return true;
        }
      }).toList();

      if (followUps.isEmpty) {
        _addBotMessage(text: "✅ Fantastic! All active recruiters have been contacted within the last 7 days. No follow-ups are due.");
      } else {
        _addBotMessage(
          text: "Here are the **${followUps.length} opportunities** that haven't been contacted in 7+ days. I recommend bumping them:",
          reportType: 'table',
          reportData: followUps,
        );
      }
      return;
    }

    // Default fallback chat response
    _addBotMessage(
      text: "I didn't quite capture that command. Please try one of the following:\n\n"
          "- `pipeline summary` (displays metrics)\n"
          "- `show active interviews` (list of schedules)\n"
          "- `who needs follow up?` (recruiter follow-up alerts)\n"
          "- `add job at [Company] as [Role]` (adds opportunity)\n"
          "- `mark [Company] as [Stage]` (updates status)",
    );
  }

  void _addBotMessage({required String text, String? reportType, dynamic reportData}) {
    setState(() {
      _isTyping = false;
      _messages.add(
        ChatMessage(
          id: 'bot-${DateTime.now().millisecondsSinceEpoch}',
          sender: 'bot',
          text: text,
          timestamp: DateTime.now(),
          reportType: reportType,
          reportData: reportData,
        ),
      );
    });
    _scrollToBottom();
  }

  Widget _buildReportWidget(String type, dynamic data) {
    if (type == 'metrics') {
      final metrics = data as Map<String, dynamic>;
      return Row(
        children: [
          _buildMetricsCard('Active', '${metrics['total']}', Colors.blueAccent),
          _buildMetricsCard('Screen', '${metrics['screening']}', Colors.amberAccent),
          _buildMetricsCard('Interview', '${metrics['interviews']}', Colors.purpleAccent),
          _buildMetricsCard('Offers', '${metrics['offers']}', Colors.greenAccent),
        ],
      );
    }

    if (type == 'success') {
      final app = data as JobApplication;
      return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(app.company, style: const TextStyle(fontWeight: FontWeight.w900, color: Colors.greenAccent, fontSize: 13)),
            const SizedBox(height: 2),
            Text(app.role, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Stage: ${app.status}', style: const TextStyle(fontSize: 11, color: Colors.white70)),
                Text('Priority: ${app.priority ?? 'Medium'}', style: const TextStyle(fontSize: 11, color: Colors.white70)),
              ],
            )
          ],
        ),
      );
    }

    if (type == 'table') {
      final list = data as List<JobApplication>;
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.02),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          separatorBuilder: (context, index) => const Divider(height: 1, color: Colors.white10),
          itemBuilder: (context, idx) {
            final app = list[idx];
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(app.company, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        Text(app.role, style: const TextStyle(fontSize: 10, color: Colors.white60)),
                      ],
                    ),
                  ),
                  Text(app.status, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                ],
              ),
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildMetricsCard(String label, String value, Color color) {
    return Expanded(
      child: Card(
        color: Colors.white.withOpacity(0.03),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: Colors.white.withOpacity(0.06)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              Text(label, style: const TextStyle(fontSize: 9, color: Colors.white60, fontWeight: FontWeight.bold)),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w900, color: color)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final chips = [
      {'label': "📈 Pipeline Summary", 'query': "pipeline summary"},
      {'label': "🎯 Active Interviews", 'query': "show active interviews"},
      {'label': "⏳ Pending Follow-ups", 'query': "who needs follow up?"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Job Assistant', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Chat message list
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  final isBot = msg.sender == 'bot';
                  return Align(
                    alignment: isBot ? Alignment.centerLeft : Alignment.centerRight,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.85),
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isBot
                            ? (isDark ? const Color(0xFF1E1E26) : Colors.white.withOpacity(0.9))
                            : Colors.blueAccent.withOpacity(0.95),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(14),
                          topRight: const Radius.circular(14),
                          bottomLeft: isBot ? const Radius.circular(0) : const Radius.circular(14),
                          bottomRight: isBot ? const Radius.circular(14) : const Radius.circular(0),
                        ),
                        border: isBot
                            ? Border.all(
                                color: isDark ? const Color(0x2BFFFFFF) : const Color(0x14000000),
                                width: 1,
                              )
                            : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg.text,
                            style: TextStyle(
                              fontSize: 12,
                              color: isBot ? Colors.white : Colors.white,
                              height: 1.35,
                            ),
                          ),
                          if (msg.reportType != null) ...[
                            const SizedBox(height: 8),
                            _buildReportWidget(msg.reportType!, msg.reportData),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            if (_isTyping)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('Assistant typing...', style: TextStyle(fontSize: 10, color: Colors.white54, fontFamily: 'monospace')),
                    ),
                  ],
                ),
              ),

            // Quick Chips
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: chips.map((c) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ActionChip(
                      label: Text(c['label']!, style: const TextStyle(fontSize: 11, color: Colors.white70)),
                      backgroundColor: Colors.white.withOpacity(0.04),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.white.withOpacity(0.08)),
                      ),
                      onPressed: () => _handleSendMessage(c['query']!),
                    ),
                  );
                }).toList(),
              ),
            ),

            // Input Row
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Ask assistant or enter command...',
                        hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.03),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.0),
                        ),
                      ),
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                      onSubmitted: (val) => _handleSendMessage(val),
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton.small(
                    onPressed: () => _handleSendMessage(_textController.text),
                    backgroundColor: Colors.blueAccent,
                    child: const Icon(Icons.send, size: 16, color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
