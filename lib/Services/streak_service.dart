import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static const String _keyInstallDate = 'install_date';

  static Future<int> getStreakDays() async {
    final prefs = await SharedPreferences.getInstance();
    final installDateStr = prefs.getString(_keyInstallDate);

    final now = DateTime.now();

    if (installDateStr == null) {
      // First time install
      await prefs.setString(_keyInstallDate, now.toIso8601String());
      return 1;
    }

    final installDate = DateTime.parse(installDateStr);

    // We only care about the day difference (ignoring hours/minutes).
    // E.g., installed at 11 PM, opening again next day at 1 AM should make it Day 2.
    final installDay = DateTime(
      installDate.year,
      installDate.month,
      installDate.day,
    );
    final currentDay = DateTime(now.year, now.month, now.day);

    final diff = currentDay.difference(installDay);
    return diff.inDays + 1; // +1 because install day is Day 1
  }
}
