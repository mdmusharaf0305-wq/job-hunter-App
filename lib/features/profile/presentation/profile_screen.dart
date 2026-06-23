import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/presentation/glass_card.dart';
import '../../jobs/domain/candidate_profile.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late CandidateProfile _profile;
  bool _isLoading = true;
  final _salaryController = TextEditingController();
  final _roleInputController = TextEditingController();
  final _locationInputController = TextEditingController();
  final _skillInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final jobsRepo = ref.read(jobsRepositoryProvider);
    final profile = await jobsRepo.getCandidateProfile();
    setState(() {
      _profile = profile;
      _salaryController.text = profile.salaryExpectations;
      _isLoading = false;
    });
  }

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);
    final jobsRepo = ref.read(jobsRepositoryProvider);
    final updated = _profile.copyWith(
      salaryExpectations: _salaryController.text.trim(),
    );
    await jobsRepo.saveCandidateProfile(updated);
    setState(() {
      _profile = updated;
      _isLoading = false;
    });
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Developer Profile Updated! Watchlist Relevance Scores recalculated.'),
          backgroundColor: Colors.teal,
        ),
      );
    }
  }

  Widget _buildChipSection({
    required String title,
    required List<String> items,
    required TextEditingController controller,
    required void Function(String) onAdd,
    required void Function(String) onRemove,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: 'Press (+) to add item',
                  hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.04),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                  ),
                ),
                style: const TextStyle(fontSize: 13, color: Colors.white),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.blueAccent),
              onPressed: () {
                final val = controller.text.trim();
                if (val.isNotEmpty) {
                  onAdd(val);
                  controller.clear();
                }
              },
            )
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: items.map((item) {
            return Chip(
              label: Text(
                item,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              backgroundColor: Colors.white.withOpacity(0.06),
              side: BorderSide(color: Colors.white.withOpacity(0.1)),
              deleteIcon: const Icon(Icons.close, size: 12, color: Colors.redAccent),
              onDeleted: () => onRemove(item),
            );
          }).toList(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Developer Profile Target', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            GlassCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '🎯 TARGET MATCHING SETTINGS',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.3,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tailor relevance scores and job scraper configurations to match your parameters (optimized for 4.4 YOE, filtering locations and matching skills).',
                    style: TextStyle(fontSize: 12, color: Colors.white70, height: 1.4),
                  ),
                  const SizedBox(height: 24),
                  
                  // Slider YOE
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'YEARS OF EXPERIENCE (YOE)',
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white70),
                          ),
                          Text(
                            '${_profile.experience.toStringAsFixed(1)} YOE',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Colors.blueAccent, fontFamily: 'monospace'),
                          ),
                        ],
                      ),
                      Slider(
                        value: _profile.experience,
                        min: 0.0,
                        max: 10.0,
                        divisions: 20,
                        activeColor: Colors.blueAccent,
                        inactiveColor: Colors.white12,
                        onChanged: (val) {
                          setState(() {
                            _profile = _profile.copyWith(experience: val);
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  // Dropdown Remote Preference
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'REMOTE WORK PREFERENCE',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white70),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        value: _profile.remotePreference,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.04),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                          ),
                        ),
                        dropdownColor: const Color(0xFF1E1E26),
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                        items: ['Remote', 'Hybrid', 'Onsite'].map((opt) {
                          return DropdownMenuItem<String>(
                            value: opt,
                            child: Text(opt),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _profile = _profile.copyWith(remotePreference: val);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Input Salary
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SALARY EXPECTATION RANGE',
                        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white70),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: _salaryController,
                        decoration: InputDecoration(
                          hintText: 'e.g. ₹15L - ₹25L',
                          hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.04),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                          ),
                        ),
                        style: const TextStyle(fontSize: 13, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Preferred Roles
                  _buildChipSection(
                    title: 'PREFERRED JOB ROLES',
                    items: _profile.preferredRoles,
                    controller: _roleInputController,
                    onAdd: (role) {
                      setState(() {
                        _profile = _profile.copyWith(
                          preferredRoles: [..._profile.preferredRoles, role],
                        );
                      });
                    },
                    onRemove: (role) {
                      setState(() {
                        _profile = _profile.copyWith(
                          preferredRoles: _profile.preferredRoles.where((r) => r != role).toList(),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Preferred Locations
                  _buildChipSection(
                    title: 'PREFERRED WORK LOCATIONS',
                    items: _profile.preferredLocations,
                    controller: _locationInputController,
                    onAdd: (loc) {
                      setState(() {
                        _profile = _profile.copyWith(
                          preferredLocations: [..._profile.preferredLocations, loc],
                        );
                      });
                    },
                    onRemove: (loc) {
                      setState(() {
                        _profile = _profile.copyWith(
                          preferredLocations: _profile.preferredLocations.where((l) => l != loc).toList(),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 20),

                  // Skills
                  _buildChipSection(
                    title: 'REQUIRED TECH STACK / SKILLS',
                    items: _profile.requiredSkills,
                    controller: _skillInputController,
                    onAdd: (skill) {
                      setState(() {
                        _profile = _profile.copyWith(
                          requiredSkills: [..._profile.requiredSkills, skill],
                        );
                      });
                    },
                    onRemove: (skill) {
                      setState(() {
                        _profile = _profile.copyWith(
                          requiredSkills: _profile.requiredSkills.where((s) => s != skill).toList(),
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 32),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text('Update Profile', style: TextStyle(fontWeight: FontWeight.bold)),
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
