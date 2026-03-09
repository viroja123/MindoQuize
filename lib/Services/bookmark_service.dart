import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mindo_quize/data/gk_questions.dart';

class BookmarkService {
  static const String _key = 'bookmarked_questions';

  static Future<void> toggleBookmark(GkQuestion question) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataList = prefs.getStringList(_key) ?? [];

    // Check if question is already bookmarked
    int index = -1;
    for (int i = 0; i < dataList.length; i++) {
      final map = jsonDecode(dataList[i]);
      if (map['id'] == question.id) {
        index = i;
        break;
      }
    }

    if (index != -1) {
      // Remove
      dataList.removeAt(index);
    } else {
      // Add
      dataList.add(jsonEncode(question.toMap()));
    }

    await prefs.setStringList(_key, dataList);
  }

  static Future<bool> isBookmarked(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataList = prefs.getStringList(_key) ?? [];

    for (int i = 0; i < dataList.length; i++) {
      final map = jsonDecode(dataList[i]);
      if (map['id'] == id) {
        return true;
      }
    }
    return false;
  }

  static Future<List<GkQuestion>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> dataList = prefs.getStringList(_key) ?? [];

    return dataList
        .map((data) => GkQuestion.fromMap(jsonDecode(data)))
        .toList();
  }
}
