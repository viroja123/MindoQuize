import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LeaderboardEntry {
  final String name;
  final int score;
  final int totalQuestions;
  final DateTime date;

  LeaderboardEntry({
    required this.name,
    required this.score,
    required this.totalQuestions,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
      'totalQuestions': totalQuestions,
      'date': date.toIso8601String(),
    };
  }

  factory LeaderboardEntry.fromMap(Map<String, dynamic> map) {
    return LeaderboardEntry(
      name: map['name'],
      score: map['score'],
      totalQuestions: map['totalQuestions'] ?? 10,
      date: DateTime.parse(map['date']),
    );
  }
}

class LeaderboardService {
  static const String _key = 'leaderboard_data';

  static Future<void> addEntry(LeaderboardEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataList = prefs.getStringList(_key) ?? [];

    dataList.add(jsonEncode(entry.toMap()));
    await prefs.setStringList(_key, dataList);
  }

  static Future<List<LeaderboardEntry>> getEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataList = prefs.getStringList(_key) ?? [];

    List<LeaderboardEntry> entries = dataList
        .map((data) => LeaderboardEntry.fromMap(jsonDecode(data)))
        .toList();

    // Sort by score descending, then by date descending
    entries.sort((a, b) {
      if (b.score == a.score) {
        return b.date.compareTo(a.date);
      }
      return b.score.compareTo(a.score);
    });

    return entries;
  }

  static Future<void> clearEntries() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
