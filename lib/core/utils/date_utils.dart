import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String formatDateShort(String? dateString) {
    if (dateString == null || dateString.isEmpty) return 'N/A';
    try {
      final dateTime = DateTime.parse(dateString);
      return DateFormat('MMM d, y').format(dateTime);
    } catch (_) {
      return dateString;
    }
  }

  static String todayString() {
    return DateTime.now().toIso8601String().split('T')[0];
  }
}
