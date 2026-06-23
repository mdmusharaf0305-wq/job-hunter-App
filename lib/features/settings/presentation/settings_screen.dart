import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/presentation/glass_card.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _BaseInputCell extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hint;
  final bool obscure;

  const _BaseInputCell({
    required this.label,
    required this.controller,
    required this.hint,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
            filled: true,
            fillColor: Colors.white.withOpacity(0.04),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
            ),
          ),
          style: const TextStyle(fontSize: 13, color: Colors.white),
        ),
      ],
    );
  }
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _tokenController = TextEditingController();
  final _oppsController = TextEditingController();
  final _timelineController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final storage = ref.read(secureStorageServiceProvider);
    final token = await storage.getNotionToken();
    final oppsId = await storage.getOpportunitiesDbId();
    final timelineId = await storage.getTimelineDbId();

    setState(() {
      _tokenController.text = token ?? '';
      _oppsController.text = oppsId ?? '';
      _timelineController.text = timelineId ?? '';
      _isLoading = false;
    });
  }

  Future<void> _saveSettings() async {
    setState(() => _isLoading = true);
    final storage = ref.read(secureStorageServiceProvider);
    await storage.saveNotionToken(_tokenController.text.trim());
    await storage.saveOpportunitiesDbId(_oppsController.text.trim());
    await storage.saveTimelineDbId(_timelineController.text.trim());
    
    // Clear local cache to force a full resync from fresh DB IDs
    final isar = ref.read(isarServiceProvider);
    await isar.clearCache();

    setState(() => _isLoading = false);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notion DB Credentials Saved! Local caches cleared for full sync.'),
          backgroundColor: Colors.teal,
        ),
      );
    }
  }

  Future<void> _clearCache() async {
    final isar = ref.read(isarServiceProvider);
    await isar.clearCache();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Local database cache cleared successfully.'),
          backgroundColor: Colors.indigo,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Credentials Setup', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🛰️ NOTION INTEGRATION SETTINGS',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.3,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Provide your Notion API Integration Token and Database IDs to synchronize your application loops in real-time. If left at default, the application serves standard sandbox datasets.',
                    style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.4),
                  ),
                  const SizedBox(height: 24),
                  _BaseInputCell(
                    label: 'NOTION INTEGRATION TOKEN',
                    controller: _tokenController,
                    hint: 'secret_...',
                    obscure: true,
                  ),
                  const SizedBox(height: 16),
                  _BaseInputCell(
                    label: 'OPPORTUNITIES DATABASE ID',
                    controller: _oppsController,
                    hint: '32-character hexadecimal database ID',
                  ),
                  const SizedBox(height: 16),
                  _BaseInputCell(
                    label: 'TIMELINE EVENTS DATABASE ID',
                    controller: _timelineController,
                    hint: '32-character hexadecimal database ID',
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveSettings,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Save Credentials', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🧹 DATABASE CACHE MANAGEMENT',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.3,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Manually purge the local Isar cache. This deletes cached application listings and timeline events stored on your Android device, prompting a complete re-fetch upon next reload.',
                    style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.4),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _clearCache,
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.redAccent,
                            side: const BorderSide(color: Colors.redAccent),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Wipe Local Cache', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
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
