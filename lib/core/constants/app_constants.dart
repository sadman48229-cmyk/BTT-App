class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'BTT Genius AI';
  static const String appVersion = '1.0.0';
  static const String appTagline = 'Your AI-Powered BTT Study Companion';

  // Supabase (replace with your actual project credentials)
  static const String supabaseUrl = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://your-project.supabase.co',
  );
  static const String supabaseAnonKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'your-anon-key',
  );

  // OpenAI
  static const String openAiApiKey = String.fromEnvironment(
    'OPENAI_API_KEY',
    defaultValue: '',
  );
  static const String openAiModel = 'gpt-4o-mini';
  static const String openAiBaseUrl = 'https://api.openai.com/v1';

  // Hive Box Names
  static const String userBox = 'user_box';
  static const String questionsBox = 'questions_box';
  static const String progressBox = 'progress_box';
  static const String settingsBox = 'settings_box';
  static const String mistakeBox = 'mistake_box';
  static const String bookmarkBox = 'bookmark_box';
  static const String chaptersBox = 'chapters_box';

  // Shared Preferences Keys
  static const String keyIsFirstLaunch = 'is_first_launch';
  static const String keyUserId = 'user_id';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyFontSize = 'font_size';
  static const String keyStudyStreak = 'study_streak';
  static const String keyLastStudyDate = 'last_study_date';
  static const String keyDailyGoalMinutes = 'daily_goal_minutes';
  static const String keyNotificationsEnabled = 'notifications_enabled';
  static const String keyOnboardingComplete = 'onboarding_complete';
  static const String keySubscriptionType = 'subscription_type';

  // Spaced Repetition Intervals (in days)
  static const List<int> spacedRepetitionIntervals = [1, 3, 7, 14, 30];

  // Quiz Settings
  static const int mockExamQuestionCount = 50;
  static const int mockExamDurationMinutes = 50;
  static const int dailyChallengeCount = 10;
  static const int minPassScore = 45; // 90% of 50

  // Learning Levels
  static const String levelBeginner = 'beginner';
  static const String levelIntermediate = 'intermediate';
  static const String levelAdvanced = 'advanced';

  // Subscription Types
  static const String planFree = 'free';
  static const String planMonthly = 'monthly';
  static const String planYearly = 'yearly';
  static const String planLifetime = 'lifetime';

  // Free Plan Limits
  static const int freeAiQueriesPerDay = 5;
  static const int freeMockExamsPerMonth = 2;
  static const int freeChaptersUnlocked = 3;

  // Animation Durations
  static const Duration animFast = Duration(milliseconds: 200);
  static const Duration animMedium = Duration(milliseconds: 400);
  static const Duration animSlow = Duration(milliseconds: 600);

  // Pagination
  static const int pageSize = 20;

  // Disclaimer
  static const String disclaimer =
      'BTT Genius AI is an independent study platform and is NOT affiliated with, '
      'endorsed by, or connected to any Singapore government agency, the Traffic '
      'Police, Singapore Safety Driving Centre (SSDC), Bukit Batok Driving Centre '
      '(BBDC), or ComfortDelGro Driving Centre (CDC). Passing the official Basic '
      'Theory Test is not guaranteed. Always refer to the official Singapore Highway '
      'Code for authoritative information.';

  // Support
  static const String supportEmail = 'support@bttgenius.app';
  static const String privacyPolicyUrl = 'https://bttgenius.app/privacy';
  static const String termsUrl = 'https://bttgenius.app/terms';
}
