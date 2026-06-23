class AppKeys {
  AppKeys._();

  // Secure Storage Keys
  static const String notionToken = 'notion_token';
  static const String opportunitiesDbId = 'opportunities_db_id';
  static const String timelineDbId = 'timeline_db_id';

  // Shared Preferences Keys
  static const String themeMode = 'theme_mode';
  static const String candidateProfile = 'candidate_profile';
  static const String companyWatchlist = 'company_watchlist';
  static const String isarCacheTimestamp = 'isar_cache_timestamp';
  
  // Scraper cache key
  static const String scraperCache = 'scraper_cache';

  // Fallback defaults
  static const String defaultNotionToken = '';
  static const String defaultOpportunitiesDbId = '0125bede0c3a8375bdf4816eb04465a2';
  static const String defaultTimelineDbId = 'cbc5bede-0c3a-8316-ae77-0116356fe49c';
}
