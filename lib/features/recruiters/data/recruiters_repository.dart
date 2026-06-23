import '../../../../shared/domain/recruiter.dart';
import '../../../../shared/domain/job_application.dart';
import '../../applications/data/applications_repository.dart';

class RecruitersRepository {
  final ApplicationsRepository _applicationsRepository;

  RecruitersRepository(this._applicationsRepository);

  // Extract unique recruiters from application opportunities list
  List<Recruiter> _extractRecruiters(List<JobApplication> apps) {
    final recruitersMap = <String, Recruiter>{};

    for (final app in apps) {
      final name = app.recruiterName;
      if (name != null && name.isNotEmpty) {
        final compName = app.recruiterCompany ?? app.company;
        final key = '${name.toLowerCase()}-${compName.toLowerCase()}';

        if (!recruitersMap.containsKey(key)) {
          // Derive default contacted values
          final threeDaysAgo = DateTime.now().subtract(const Duration(days: 3));
          final lastContacted = threeDaysAgo.toIso8601String().split('T')[0];
          
          final nextFollowUp = DateTime.now().toIso8601String().split('T')[0];
          final isPipelineActive = ['sourcing', 'screening', 'interview']
              .contains(app.status.toLowerCase().replaceAll(RegExp(r'[^\w]'), ''));

          recruitersMap[key] = Recruiter(
            id: app.id, // Opportunity page ID
            company: compName,
            client: app.company,
            role: app.role,
            recruiterName: name,
            recruiterPhone: app.recruiterPhone,
            recruiterEmail: app.recruiterEmail,
            recruiterLinkedin: app.recruiterLinkedin,
            contactStatus: app.status,
            priority: app.priority ?? 'Low',
            lastContacted: lastContacted,
            nextFollowUp: isPipelineActive ? nextFollowUp : null,
            applicationUrl: app.applicationUrl,
            dbSource: app.type,
            relatedTimelineId: app.relatedTimelineId,
          );
        }
      }
    }
    return recruitersMap.values.toList();
  }

  // Load recruiters from cached applications
  Future<List<Recruiter>> getCachedRecruiters() async {
    final apps = await _applicationsRepository.getCachedApplications();
    return _extractRecruiters(apps);
  }

  // Fetch recruiters from remote/fresh applications
  Future<List<Recruiter>> fetchRecruiters() async {
    final apps = await _applicationsRepository.fetchAndCacheApplications();
    return _extractRecruiters(apps);
  }

  // Update recruiter details (saves back to the linked Notion opportunity page)
  Future<Recruiter> updateRecruiterDetails(String appPageId, Map<String, dynamic> data) async {
    final props = <String, dynamic>{};
    if (data.containsKey('recruiterName')) props['recruiterName'] = data['recruiterName'];
    if (data.containsKey('company')) props['recruiterCompany'] = data['company'];
    if (data.containsKey('priority')) props['priority'] = data['priority'];
    if (data.containsKey('applicationUrl')) props['applicationUrl'] = data['applicationUrl'];
    if (data.containsKey('recruiterPhone')) props['recruiterPhone'] = data['recruiterPhone'];
    if (data.containsKey('recruiterEmail')) props['recruiterEmail'] = data['recruiterEmail'];
    if (data.containsKey('recruiterLinkedin')) props['recruiterLinkedin'] = data['recruiterLinkedin'];

    final updatedApp = await _applicationsRepository.updateOpportunity(appPageId, props);
    
    return Recruiter(
      id: updatedApp.id,
      company: updatedApp.recruiterCompany ?? updatedApp.company,
      client: updatedApp.company,
      role: updatedApp.role,
      recruiterName: updatedApp.recruiterName ?? 'Unknown Recruiter',
      recruiterPhone: updatedApp.recruiterPhone,
      recruiterEmail: updatedApp.recruiterEmail,
      recruiterLinkedin: updatedApp.recruiterLinkedin,
      contactStatus: updatedApp.status,
      dbSource: updatedApp.type,
      priority: updatedApp.priority ?? 'Low',
    );
  }

  // Update recruiter contact status (marks application status directly)
  Future<Recruiter> updateRecruiterStatus(String appPageId, String newStatus) async {
    final updatedApp = await _applicationsRepository.updateStage(appPageId, newStatus);
    
    // Set last contacted date on this application too
    final today = DateTime.now().toIso8601String().split('T')[0];
    final fullUpdated = await _applicationsRepository.updateOpportunity(appPageId, {
      'lastContactedDate': today,
    });

    return Recruiter(
      id: fullUpdated.id,
      company: fullUpdated.recruiterCompany ?? fullUpdated.company,
      client: fullUpdated.company,
      role: fullUpdated.role,
      recruiterName: fullUpdated.recruiterName ?? 'Unknown Recruiter',
      recruiterPhone: fullUpdated.recruiterPhone,
      recruiterEmail: fullUpdated.recruiterEmail,
      recruiterLinkedin: fullUpdated.recruiterLinkedin,
      contactStatus: fullUpdated.status,
      dbSource: fullUpdated.type,
      priority: fullUpdated.priority ?? 'Low',
      lastContacted: today,
    );
  }
}
