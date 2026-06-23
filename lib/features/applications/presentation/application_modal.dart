import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/domain/job_application.dart';
import '../../../core/constants/app_colors.dart';

class ApplicationModal extends ConsumerStatefulWidget {
  final JobApplication? application;
  final String defaultType;
  final VoidCallback onSaved;

  const ApplicationModal({
    super.key,
    this.application,
    required this.defaultType,
    required this.onSaved,
  });

  @override
  ConsumerState<ApplicationModal> createState() => _ApplicationModalState();
}

class _ApplicationModalState extends ConsumerState<ApplicationModal> {
  final _formKey = GlobalKey<FormState>();

  late String _role;
  late String _company;
  late String _client;
  late String _type;
  late String _priority;
  late String _workMode;
  late String _location;
  late String _recruiterName;
  late String _recruiterPhone;
  late String _recruiterEmail;
  late String _recruiterLinkedin;
  late String _status;
  late String _notes;
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final app = widget.application;
    _role = app?.role ?? '';
    _company = app?.company ?? '';
    _client = app?.client ?? 'Direct';
    _type = app?.type ?? widget.defaultType;
    _priority = app?.priority ?? 'Medium';
    _workMode = app?.workMode ?? 'Hybrid';
    _location = app?.location ?? '';
    _recruiterName = app?.recruiterName ?? '';
    _recruiterPhone = app?.recruiterPhone ?? '';
    _recruiterEmail = app?.recruiterEmail ?? '';
    _recruiterLinkedin = app?.recruiterLinkedin ?? '';
    _status = app?.status ?? '📄 Applied';
    _notes = app?.notes ?? '';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isLoading = true);
    final repo = ref.read(applicationsRepositoryProvider);

    final data = {
      'role': _role,
      'company': _company,
      'client': _client,
      'type': _type,
      'priority': _priority,
      'workMode': _workMode,
      'location': _location,
      'recruiterName': _recruiterName,
      'recruiterPhone': _recruiterPhone,
      'recruiterEmail': _recruiterEmail,
      'recruiterLinkedin': _recruiterLinkedin,
      'status': _status,
      'notes': _notes,
    };

    try {
      if (widget.application != null) {
        await repo.updateOpportunity(widget.application!.id, data);
      } else {
        await repo.createOpportunity(data);
      }
      widget.onSaved();
      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save opportunity details: $e'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  Widget _buildFieldCell(String label, String initial, void Function(String?) onSave, {String? hint, bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
          const SizedBox(height: 6),
          TextFormField(
            initialValue: initial,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
              filled: true,
              fillColor: Colors.white.withOpacity(0.04),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
            ),
            style: const TextStyle(fontSize: 13, color: Colors.white),
            validator: (val) {
              if (required && (val == null || val.trim().isEmpty)) {
                return '$label is required';
              }
              return null;
            },
            onSaved: onSave,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: mediaQuery.viewInsets.bottom + 24,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF0F0F15) : const Color(0xFFF9FAFB),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.application != null ? 'Edit Opportunity' : 'Add Opportunity',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 20),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              const SizedBox(height: 16),
              
              _buildFieldCell('COMPANY NAME', _company, (val) => _company = val ?? '', required: true),
              _buildFieldCell('JOB ROLE', _role, (val) => _role = val ?? '', required: true),
              _buildFieldCell('CLIENT (DIRECT IF Direct)', _client, (val) => _client = val ?? ''),
              _buildFieldCell('LOCATION', _location, (val) => _location = val ?? ''),
              
              // Select Priority & Work Mode
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('PRIORITY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          value: _priority,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.04),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                          ),
                          dropdownColor: const Color(0xFF1E1E26),
                          items: ['High', 'Medium', 'Low'].map((opt) {
                            return DropdownMenuItem<String>(value: opt, child: Text(opt));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _priority = val);
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
                        const Text('WORK MODE', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white70)),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          value: _workMode,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.04),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withOpacity(0.1))),
                          ),
                          dropdownColor: const Color(0xFF1E1E26),
                          items: ['Remote', 'Hybrid', 'Onsite'].map((opt) {
                            return DropdownMenuItem<String>(value: opt, child: Text(opt));
                          }).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _workMode = val);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              _buildFieldCell('RECRUITER NAME', _recruiterName, (val) => _recruiterName = val ?? ''),
              _buildFieldCell('RECRUITER PHONE', _recruiterPhone, (val) => _recruiterPhone = val ?? ''),
              _buildFieldCell('RECRUITER EMAIL', _recruiterEmail, (val) => _recruiterEmail = val ?? ''),
              _buildFieldCell('RECRUITER LINKEDIN', _recruiterLinkedin, (val) => _recruiterLinkedin = val ?? ''),
              _buildFieldCell('NOTES', _notes, (val) => _notes = val ?? ''),
              
              const SizedBox(height: 24),
              
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: _isLoading
                          ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                          : const Text('Save Details', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
