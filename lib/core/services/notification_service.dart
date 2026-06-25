import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const String studyReminderId = 'study_reminder';
  static const String dailyChallengeId = 'daily_challenge';
  static const String streakReminderId = 'streak_reminder';
  static const String revisionReminderId = 'revision_reminder';

  static Future<void> init() async {
    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _notifications.initialize(
      const InitializationSettings(android: androidSettings, iOS: iosSettings),
      onDidReceiveNotificationResponse: _onNotificationTap,
    );

    await _requestPermissions();
  }

  static Future<void> _requestPermissions() async {
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static void _onNotificationTap(NotificationResponse response) {
    // Handle notification tap - navigate to relevant screen
  }

  static Future<void> scheduleStudyReminder({
    required int hour,
    required int minute,
  }) async {
    await _notifications.periodicallyShow(
      1,
      'Time to Study! 📚',
      'Your BTT exam is approaching. Let\'s practice!',
      RepeatInterval.daily,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          studyReminderId,
          'Study Reminders',
          channelDescription: 'Daily study reminder notifications',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFF6366F1),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  static Future<void> showDailyChallengeNotification() async {
    await _notifications.show(
      2,
      '🎯 Daily Challenge Ready!',
      '10 new questions are waiting for you today.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          dailyChallengeId,
          'Daily Challenge',
          channelDescription: 'Daily challenge available notifications',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFF06B6D4),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  static Future<void> showStreakReminderNotification(int streak) async {
    await _notifications.show(
      3,
      '🔥 Keep Your Streak Alive!',
      'You have a $streak day streak. Study today to keep it!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          streakReminderId,
          'Streak Reminders',
          channelDescription: 'Study streak reminder notifications',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFFF59E0B),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  static Future<void> showRevisionReminder(String topic) async {
    await _notifications.show(
      4,
      '📖 Time to Revise!',
      'Review "$topic" to strengthen your memory.',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          revisionReminderId,
          'Revision Reminders',
          channelDescription: 'Spaced repetition revision reminders',
          importance: Importance.high,
          priority: Priority.high,
          color: Color(0xFF10B981),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }

  static Future<void> cancelAll() async => await _notifications.cancelAll();

  static Future<void> cancel(int id) async => await _notifications.cancel(id);
}
