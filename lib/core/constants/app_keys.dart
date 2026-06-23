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

  // Fallback defaults loaded securely at build time via --dart-define
  static const String defaultNotionToken = String.fromEnvironment('NOTION_TOKEN', defaultValue: '');
  static const String defaultOpportunitiesDbId = String.fromEnvironment('OPPORTUNITIES_DB_ID', defaultValue: '');
  static const String defaultTimelineDbId = String.fromEnvironment('TIMELINE_DB_ID', defaultValue: '');
}
