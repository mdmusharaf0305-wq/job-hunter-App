import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_hunter_app/main.dart';
import 'package:job_hunter_app/shared/services/providers.dart';
import 'package:job_hunter_app/shared/services/isar_service.dart';
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
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          isarServiceProvider.overrideWithValue(FakeIsarService()),
        ],
        child: const MyApp(),
      ),
    );
    expect(find.byType(MyApp), findsOneWidget);
  });
}
