import '../../../../shared/domain/timeline_event.dart';
import '../../../../shared/data/local/isar_collections.dart';
import '../../../../shared/services/isar_service.dart';
import '../../../../core/network/notion_api_client.dart';

class InterviewsRepository {
  final NotionApiClient _apiClient;
  final IsarService _isarService;

  InterviewsRepository(this._apiClient, this._isarService);

  // Helper mapper: Domain Model -> Cache Collection Model
  TimelineEventCache _toCache(TimelineEvent event, [int? isarId]) {
    final cache = TimelineEventCache()
      ..notionId = event.id
      ..opportunity = event.opportunity
      ..title = event.title
      ..date = event.date
      ..category = event.category
      ..virtualMode = event.virtualMode
      ..notes = event.notes;

    if (isarId != null) {
      cache.id = isarId;
    }
    return cache;
  }

  // Helper mapper: Cache Collection Model -> Domain Model
  TimelineEvent _fromCache(TimelineEventCache cache) {
    return TimelineEvent(
      id: cache.notionId,
      opportunity: cache.opportunity,
      title: cache.title,
      date: cache.date,
      category: cache.category,
      virtualMode: cache.virtualMode,
      notes: cache.notes,
    );
  }

  // Get cached local events
  Future<List<TimelineEvent>> getCachedEvents() async {
    final cached = await _isarService.getAllTimelineEvents();
    return cached.map(_fromCache).toList();
  }

  // Fetch all timeline events, cache to Isar
  Future<List<TimelineEvent>> fetchAndCacheEvents() async {
    try {
      final remoteEvents = await _apiClient.fetchTimelineEvents();
      if (remoteEvents.isNotEmpty) {
        final cacheList = remoteEvents.map((e) => _toCache(e)).toList();
        await _isarService.saveTimelineEvents(cacheList);
        return remoteEvents;
      }
    } catch (e) {
      print('[JCC] Failed to fetch remote timeline events: $e. Serving from cache.');
    }
    return getCachedEvents();
  }

  // Log a new timeline event
  Future<bool> createEvent(TimelineEvent event) async {
    final success = await _apiClient.createTimelineEvent(event);
    if (success) {
      // Optimistically add to local cache if successful
      // If we don't have a Notion ID yet, we'll assign a temporary one or refresh
      final tempCacheObj = _toCache(
        event.copyWith(id: 'temp-${DateTime.now().millisecondsSinceEpoch}'),
      );
      await _isarService.saveSingleTimelineEvent(tempCacheObj);
      
      // Refresh cache from remote in background
      fetchAndCacheEvents().catchError((_) => <TimelineEvent>[]);
    }
    return success;
  }
}
