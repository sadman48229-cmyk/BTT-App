import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/local_storage_service.dart';

class HomeData {
  final double dailyProgress;
  final int questionsToday;
  final int minutesStudied;

  const HomeData({
    this.dailyProgress = 0.0,
    this.questionsToday = 0,
    this.minutesStudied = 0,
  });
}

final homeDataProvider = Provider<HomeData>((ref) {
  final questionsToday = LocalStorageService.getInt('questions_today', defaultValue: 0);
  final minutesStudied = LocalStorageService.getInt('minutes_today', defaultValue: 0);
  final dailyGoal = LocalStorageService.getInt('daily_goal_minutes', defaultValue: 30);
  final progress = dailyGoal > 0 ? minutesStudied / dailyGoal : 0.0;

  return HomeData(
    dailyProgress: progress.clamp(0.0, 1.0),
    questionsToday: questionsToday,
    minutesStudied: minutesStudied,
  );
});
