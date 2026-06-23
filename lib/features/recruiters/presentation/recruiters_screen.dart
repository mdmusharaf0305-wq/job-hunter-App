import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../shared/services/providers.dart';
import '../../../shared/presentation/glass_card.dart';
import '../../../shared/presentation/luffy_loader.dart';
import '../../../shared/domain/recruiter.dart';
import '../../../core/utils/link_utils.dart';
import 'call_log_modal.dart';

// Provider to query recruiters list
final recruitersListProvider = FutureProvider<List<Recruiter>>((ref) async {
  final repo = ref.watch(recruitersRepositoryProvider);
  return await repo.fetchRecruiters();
});

class RecruitersScreen extends ConsumerStatefulWidget {
  const RecruitersScreen({super.key});

  @override
  ConsumerState<RecruitersScreen> createState() => _RecruitersScreenState();
}

class _RecruitersScreenState extends ConsumerState<RecruitersScreen> {
  String _searchQuery = '';

  void _openCallLogSheet(BuildContext context, Recruiter r) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CallLogModal(
        recruiter: r,
        onSaved: () => ref.invalidate(recruitersListProvider),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recruitersAsync = ref.watch(recruitersListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Recruiters Directory', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search contacts name or vendor company...',
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
          
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => ref.refresh(recruitersListProvider.future),
              child: recruitersAsync.when(
                loading: () => const Center(
                  child: LuffyLoader(size: 48, loadingText: 'COMPILING RECRUITERS CONTACTS DIRECTORY...'),
                ),
                error: (err, stack) => Center(child: Text('Error loading contacts: $err')),
                data: (list) {
                  final filtered = list.where((r) {
                    return r.recruiterName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                        r.company.toLowerCase().contains(_searchQuery.toLowerCase());
                  }).toList();

                  if (filtered.isEmpty) {
                    return const Center(child: Text('No contacts found.'));
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(24),
                    itemCount: filtered.length,
                    itemBuilder: (context, idx) {
                      final r = filtered[idx];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        r.recruiterName,
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.white),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        '${r.role} at ${r.company}',
                                        style: const TextStyle(fontSize: 10, color: Colors.white60),
                                      )
                                    ],
                                  ),
                                  
                                  // Quick Communication Action triggers
                                  Row(
                                    children: [
                                      if (r.recruiterPhone != null && r.recruiterPhone!.isNotEmpty) ...[
                                        IconButton(
                                          icon: const Icon(Icons.phone_outlined, size: 16, color: Colors.blueAccent),
                                          onPressed: () => _openCallLogSheet(context, r),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.chat_bubble_outline, size: 16, color: Colors.green),
                                          onPressed: () => LinkUtils.triggerWhatsApp(r.recruiterPhone, r.recruiterName),
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.sms_outlined, size: 16, color: Colors.amberAccent),
                                          onPressed: () => LinkUtils.triggerSMS(r.recruiterPhone),
                                        ),
                                      ],
                                      if (r.recruiterEmail != null && r.recruiterEmail!.isNotEmpty) ...[
                                        IconButton(
                                          icon: const Icon(Icons.mail_outline, size: 16, color: Colors.purpleAccent),
                                          onPressed: () => LinkUtils.triggerGmail(r.recruiterEmail, r.recruiterName),
                                        ),
                                      ],
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 8),
                              
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Opportunity: ${r.client}',
                                    style: const TextStyle(fontSize: 9, color: Colors.white54),
                                  ),
                                  if (r.recruiterLinkedin != null && r.recruiterLinkedin!.isNotEmpty)
                                    InkWell(
                                      onTap: () => LinkUtils.launchWeb(r.recruiterLinkedin),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.link, size: 12, color: Colors.blueAccent),
                                          SizedBox(width: 4),
                                          Text(
                                            'LinkedIn Profile',
                                            style: TextStyle(fontSize: 9, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )
                                ],
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
          ),
        ],
      ),
    );
  }
}
