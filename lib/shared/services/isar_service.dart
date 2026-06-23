import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import '../data/local/isar_collections.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = _initDb();
  }

  Future<Isar> _initDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [
          JobApplicationCacheSchema,
          TimelineEventCacheSchema,
          WatchlistCompanyCacheSchema,
        ],
        directory: dir.path,
        inspector: true, // DevTools Isar database inspector helper
      );
    }
    return Isar.getInstance()!;
  }

  // --- Job Applications ---
  Future<List<JobApplicationCache>> getAllApplications() async {
    final isar = await db;
    return await isar.jobApplicationCaches.where().findAll();
  }

  Future<void> saveApplications(List<JobApplicationCache> apps) async {
    final isar = await db;
    await isar.writeTxn(() async {
      // Clear out outdated cache to prevent stale records
      await isar.jobApplicationCaches.clear();
      await isar.jobApplicationCaches.putAll(apps);
    });
  }

  Future<void> saveSingleApplication(JobApplicationCache app) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.jobApplicationCaches.put(app);
    });
  }

  // --- Timeline Events ---
  Future<List<TimelineEventCache>> getAllTimelineEvents() async {
    final isar = await db;
    return await isar.timelineEventCaches.where().findAll();
  }

  Future<void> saveTimelineEvents(List<TimelineEventCache> events) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.timelineEventCaches.clear();
      await isar.timelineEventCaches.putAll(events);
    });
  }

  Future<void> saveSingleTimelineEvent(TimelineEventCache event) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.timelineEventCaches.put(event);
    });
  }

  // --- Watchlist Companies ---
  Future<List<WatchlistCompanyCache>> getAllCompanies() async {
    final isar = await db;
    return await isar.watchlistCompanyCaches.where().findAll();
  }

  Future<void> saveCompanies(List<WatchlistCompanyCache> companies) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.watchlistCompanyCaches.clear();
      await isar.watchlistCompanyCaches.putAll(companies);
    });
  }

  Future<void> saveSingleCompany(WatchlistCompanyCache company) async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.watchlistCompanyCaches.put(company);
    });
  }

  // --- General ---
  Future<void> clearCache() async {
    final isar = await db;
    await isar.writeTxn(() async {
      await isar.jobApplicationCaches.clear();
      await isar.timelineEventCaches.clear();
      await isar.watchlistCompanyCaches.clear();
    });
  }
}
