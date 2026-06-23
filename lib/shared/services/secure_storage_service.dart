import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/app_keys.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage;

  SecureStorageService()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(encryptedSharedPreferences: true),
        );

  Future<String?> getNotionToken() async {
    final token = await _storage.read(key: AppKeys.notionToken);
    return token ?? AppKeys.defaultNotionToken;
  }

  Future<void> saveNotionToken(String token) async {
    await _storage.write(key: AppKeys.notionToken, value: token);
  }

  Future<String?> getOpportunitiesDbId() async {
    final dbId = await _storage.read(key: AppKeys.opportunitiesDbId);
    return dbId ?? AppKeys.defaultOpportunitiesDbId;
  }

  Future<void> saveOpportunitiesDbId(String dbId) async {
    await _storage.write(key: AppKeys.opportunitiesDbId, value: dbId);
  }

  Future<String?> getTimelineDbId() async {
    final dbId = await _storage.read(key: AppKeys.timelineDbId);
    return dbId ?? AppKeys.defaultTimelineDbId;
  }

  Future<void> saveTimelineDbId(String dbId) async {
    await _storage.write(key: AppKeys.timelineDbId, value: dbId);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
