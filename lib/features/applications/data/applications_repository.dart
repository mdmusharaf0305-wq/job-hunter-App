import '../../../../shared/domain/job_application.dart';
import '../../../../shared/data/local/isar_collections.dart';
import '../../../../shared/services/isar_service.dart';
import '../../../../core/network/notion_api_client.dart';

class ApplicationsRepository {
  final NotionApiClient _apiClient;
  final IsarService _isarService;

  ApplicationsRepository(this._apiClient, this._isarService);

  // Helper mapper: Domain Model -> Cache Collection Model
  JobApplicationCache _toCache(JobApplication app, [int? isarId]) {
    final cache = JobApplicationCache()
      ..notionId = app.id
      ..role = app.role
      ..company = app.company
      ..client = app.client
      ..type = app.type
      ..status = app.status
      ..lastUpdated = app.lastUpdated
      ..location = app.location
      ..workMode = app.workMode
      ..salary = app.salary
      ..interviewRounds = app.interviewRounds
      ..roundPlan = app.roundPlan
      ..applicationUrl = app.applicationUrl
      ..priority = app.priority
      ..recruiterName = app.recruiterName
      ..recruiterCompany = app.recruiterCompany
      ..recruiterPhone = app.recruiterPhone
      ..recruiterEmail = app.recruiterEmail
      ..recruiterLinkedin = app.recruiterLinkedin
      ..relatedTimelineId = app.relatedTimelineId
      ..callStatus = app.callStatus
      ..resumeSentOn = app.resumeSentOn
      ..receivedCallOn = app.receivedCallOn
      ..interviewMode = app.interviewMode
      ..employmentType = app.employmentType
      ..lastContactedDate = app.lastContactedDate
      ..companyType = app.companyType
      ..companySize = app.companySize
      ..resumeSent = app.resumeSent
      ..followupChannel = app.followupChannel
      ..notes = app.notes;

    if (isarId != null) {
      cache.id = isarId;
    }
    return cache;
  }

  // Helper mapper: Cache Collection Model -> Domain Model
  JobApplication _fromCache(JobApplicationCache cache) {
    return JobApplication(
      id: cache.notionId,
      role: cache.role,
      company: cache.company,
      client: cache.client,
      type: cache.type,
      status: cache.status,
      lastUpdated: cache.lastUpdated,
      location: cache.location,
      workMode: cache.workMode,
      salary: cache.salary,
      interviewRounds: cache.interviewRounds,
      roundPlan: cache.roundPlan,
      applicationUrl: cache.applicationUrl,
      priority: cache.priority,
      recruiterName: cache.recruiterName,
      recruiterCompany: cache.recruiterCompany,
      recruiterPhone: cache.recruiterPhone,
      recruiterEmail: cache.recruiterEmail,
      recruiterLinkedin: cache.recruiterLinkedin,
      relatedTimelineId: cache.relatedTimelineId,
      callStatus: cache.callStatus,
      resumeSentOn: cache.resumeSentOn,
      receivedCallOn: cache.receivedCallOn,
      interviewMode: cache.interviewMode,
      employmentType: cache.employmentType,
      lastContactedDate: cache.lastContactedDate,
      companyType: cache.companyType,
      companySize: cache.companySize,
      resumeSent: cache.resumeSent,
      followupChannel: cache.followupChannel,
      notes: cache.notes,
    );
  }

  // Get cached local opportunities
  Future<List<JobApplication>> getCachedApplications() async {
    final cached = await _isarService.getAllApplications();
    return cached.map(_fromCache).toList();
  }

  // Fetch all applications, writing to Isar on success. Falls back to cache.
  Future<List<JobApplication>> fetchAndCacheApplications() async {
    try {
      final remoteApps = await _apiClient.fetchApplications();
      if (remoteApps.isNotEmpty) {
        final cacheList = remoteApps.map((a) => _toCache(a)).toList();
        await _isarService.saveApplications(cacheList);
        return remoteApps;
      }
    } catch (e) {
      // safe fallback to cache
      print('[JCC] Failed to fetch remote opportunities: $e. Serving from cache.');
    }
    return getCachedApplications();
  }

  // Update stage (optimistic UI write first, then Notion async)
  Future<JobApplication> updateStage(String pageId, String newStage) async {
    final cached = await _isarService.getAllApplications();
    final matchIdx = cached.indexWhere((c) => c.notionId == pageId);

    if (matchIdx > -1) {
      final localCache = cached[matchIdx];
      localCache.status = newStage;
      localCache.lastUpdated = DateTime.now().toIso8601String().split('T')[0];
      await _isarService.saveSingleApplication(localCache);
    }

    try {
      final updated = await _apiClient.updateApplicationStage(pageId, newStage);
      final cacheObj = _toCache(updated, matchIdx > -1 ? cached[matchIdx].id : null);
      await _isarService.saveSingleApplication(cacheObj);
      return updated;
    } catch (e) {
      print('[JCC] Remote update stage failed: $e');
      // If remote fails, return the updated local object
      if (matchIdx > -1) {
        return _fromCache(cached[matchIdx]);
      }
      rethrow;
    }
  }

  // Update opportunity details
  Future<JobApplication> updateOpportunity(String pageId, Map<String, dynamic> updateProps) async {
    final cached = await _isarService.getAllApplications();
    final matchIdx = cached.indexWhere((c) => c.notionId == pageId);

    try {
      final updated = await _apiClient.updateApplication(pageId, updateProps);
      final cacheObj = _toCache(updated, matchIdx > -1 ? cached[matchIdx].id : null);
      await _isarService.saveSingleApplication(cacheObj);
      return updated;
    } catch (e) {
      print('[JCC] Remote update details failed: $e');
      rethrow;
    }
  }

  // Create new opportunity
  Future<JobApplication> createOpportunity(Map<String, dynamic> insertProps) async {
    try {
      final created = await _apiClient.createApplication(insertProps);
      final cacheObj = _toCache(created);
      await _isarService.saveSingleApplication(cacheObj);
      return created;
    } catch (e) {
      print('[JCC] Remote create opportunity failed: $e');
      rethrow;
    }
  }

  // Fetch Notion dropdown options
  Future<Map<String, List<String>>> fetchSchemaOptions() async {
    try {
      return await _apiClient.fetchDatabaseSchemaOptions();
    } catch (_) {
      return {};
    }
  }
}
