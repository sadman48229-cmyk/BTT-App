import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;
  static late Box _userBox;
  static late Box _questionsBox;
  static late Box _progressBox;
  static late Box _settingsBox;
  static late Box _mistakeBox;
  static late Box _bookmarkBox;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();

    _userBox = await Hive.openBox(AppConstants.userBox);
    _questionsBox = await Hive.openBox(AppConstants.questionsBox);
    _progressBox = await Hive.openBox(AppConstants.progressBox);
    _settingsBox = await Hive.openBox(AppConstants.settingsBox);
    _mistakeBox = await Hive.openBox(AppConstants.mistakeBox);
    _bookmarkBox = await Hive.openBox(AppConstants.bookmarkBox);
  }

  // SharedPreferences
  static Future<void> setBool(String key, bool value) async =>
      await _prefs.setBool(key, value);
  static bool getBool(String key, {bool defaultValue = false}) =>
      _prefs.getBool(key) ?? defaultValue;

  static Future<void> setString(String key, String value) async =>
      await _prefs.setString(key, value);
  static String getString(String key, {String defaultValue = ''}) =>
      _prefs.getString(key) ?? defaultValue;

  static Future<void> setInt(String key, int value) async =>
      await _prefs.setInt(key, value);
  static int getInt(String key, {int defaultValue = 0}) =>
      _prefs.getInt(key) ?? defaultValue;

  static Future<void> remove(String key) async => await _prefs.remove(key);
  static Future<void> clearAll() async => await _prefs.clear();

  // Hive Boxes
  static Box get userBox => _userBox;
  static Box get questionsBox => _questionsBox;
  static Box get progressBox => _progressBox;
  static Box get settingsBox => _settingsBox;
  static Box get mistakeBox => _mistakeBox;
  static Box get bookmarkBox => _bookmarkBox;

  // Bookmarks
  static bool isBookmarked(String questionId) =>
      _bookmarkBox.containsKey(questionId);

  static Future<void> toggleBookmark(String questionId, Map<String, dynamic> data) async {
    if (_bookmarkBox.containsKey(questionId)) {
      await _bookmarkBox.delete(questionId);
    } else {
      await _bookmarkBox.put(questionId, data);
    }
  }

  static List<dynamic> getAllBookmarks() => _bookmarkBox.values.toList();

  // Mistakes
  static Future<void> saveMistake(String questionId, Map<String, dynamic> data) async {
    await _mistakeBox.put(questionId, {
      ...data,
      'savedAt': DateTime.now().toIso8601String(),
      'retryCount': (_mistakeBox.get(questionId)?['retryCount'] ?? 0) + 1,
    });
  }

  static Future<void> removeMistake(String questionId) async =>
      await _mistakeBox.delete(questionId);

  static List<dynamic> getAllMistakes() => _mistakeBox.values.toList();

  // Progress
  static Future<void> saveProgress(String key, dynamic value) async =>
      await _progressBox.put(key, value);
  static dynamic getProgress(String key) => _progressBox.get(key);

  // Study Streak
  static Future<int> updateStudyStreak() async {
    final lastStudyDate = _prefs.getString(AppConstants.keyLastStudyDate);
    final today = DateTime.now();
    final todayStr = '${today.year}-${today.month}-${today.day}';

    int streak = _prefs.getInt(AppConstants.keyStudyStreak) ?? 0;

    if (lastStudyDate == null) {
      streak = 1;
    } else {
      final last = DateTime.parse(lastStudyDate);
      final diff = today.difference(last).inDays;
      if (diff == 1) {
        streak += 1;
      } else if (diff == 0) {
        // Same day, no change
      } else {
        streak = 1; // Streak broken
      }
    }

    await _prefs.setInt(AppConstants.keyStudyStreak, streak);
    await _prefs.setString(AppConstants.keyLastStudyDate, todayStr);
    return streak;
  }

  static int getStudyStreak() => _prefs.getInt(AppConstants.keyStudyStreak) ?? 0;
}
