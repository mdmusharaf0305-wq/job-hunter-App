import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_hunter_app/shared/services/isar_service.dart';
import 'package:job_hunter_app/features/jobs/data/jobs_repository.dart';
import 'package:job_hunter_app/shared/data/local/isar_collections.dart';
import 'package:isar/isar.dart';

class FakeIsarService implements IsarService {
  @override
  late Future<Isar> db;

  @override
  Future<List<JobApplicationCache>> getAllApplications() async => [];

  @override
  Future<void> saveApplications(List<JobApplicationCache> apps) async {}

  @override
  Future<void> saveSingleApplication(JobApplicationCache app) async {}

  @override
  Future<List<TimelineEventCache>> getAllTimelineEvents() async => [];

  @override
  Future<void> saveTimelineEvents(List<TimelineEventCache> events) async {}

  @override
  Future<void> saveSingleTimelineEvent(TimelineEventCache event) async {}

  @override
  Future<List<WatchlistCompanyCache>> getAllCompanies() async => [];

  @override
  Future<void> saveCompanies(List<WatchlistCompanyCache> companies) async {}

  @override
  Future<void> saveSingleCompany(WatchlistCompanyCache company) async {}

  @override
  Future<void> clearCache() async {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async {
        return '.';
      },
    );
  });

  group('Company Watchlist Scoring Engines', () {
    late JobsRepository jobsRepo;

    setUp(() {
      jobsRepo = JobsRepository(FakeIsarService());
    });

    test('Calculate Authenticity: Tier 1 Direct Employer', () {
      final res = jobsRepo.calculateAuthenticity('Google', tier: 1);
      expect(res['score'], equals(98));
      expect(res['badge'], equals('✓ Direct Employer'));
    });

    test('Calculate Authenticity: Recruiter Agency Penalty', () {
      final res = jobsRepo.calculateAuthenticity('Randstad Staffing Solutions', tier: 1);
      expect(res['score'], lessThan(55));
      expect(res['badge'], equals('Recruitment Agency'));
    });

    test('Calculate Authenticity: ATS Boost', () {
      final resWithAts = jobsRepo.calculateAuthenticity('Stripe', ats: 'lever', tier: 2);
      final resWithoutAts = jobsRepo.calculateAuthenticity('Stripe', tier: 2);
      
      expect(resWithAts['score'], greaterThan(resWithoutAts['score'] as num));
    });
  });
}
