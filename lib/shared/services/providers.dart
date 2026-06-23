import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/notion_api_client.dart';
import 'isar_service.dart';
import 'secure_storage_service.dart';
import '../../features/applications/data/applications_repository.dart';
import '../../features/recruiters/data/recruiters_repository.dart';
import '../../features/interviews/data/interviews_repository.dart';
import '../../features/jobs/data/jobs_repository.dart';

// --- Services ---
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

final notionApiClientProvider = Provider<NotionApiClient>((ref) {
  final storage = ref.watch(secureStorageServiceProvider);
  return NotionApiClient(storage);
});

// --- Repositories ---
final applicationsRepositoryProvider = Provider<ApplicationsRepository>((ref) {
  final api = ref.watch(notionApiClientProvider);
  final isar = ref.watch(isarServiceProvider);
  return ApplicationsRepository(api, isar);
});

final recruitersRepositoryProvider = Provider<RecruitersRepository>((ref) {
  final appsRepo = ref.watch(applicationsRepositoryProvider);
  return RecruitersRepository(appsRepo);
});

final interviewsRepositoryProvider = Provider<InterviewsRepository>((ref) {
  final api = ref.watch(notionApiClientProvider);
  final isar = ref.watch(isarServiceProvider);
  return InterviewsRepository(api, isar);
});

final jobsRepositoryProvider = Provider<JobsRepository>((ref) {
  final isar = ref.watch(isarServiceProvider);
  return JobsRepository(isar);
});
