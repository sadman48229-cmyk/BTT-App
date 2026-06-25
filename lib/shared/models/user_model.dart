import 'package:equatable/equatable.dart';

enum UserRole { student, admin }
enum SubscriptionType { free, monthly, yearly, lifetime }
enum LearningLevel { beginner, intermediate, advanced }

class UserModel extends Equatable {
  final String id;
  final String email;
  final String? displayName;
  final String? avatarUrl;
  final UserRole role;
  final SubscriptionType subscription;
  final LearningLevel level;
  final String language;
  final int studyStreak;
  final int totalQuestionsAnswered;
  final int totalCorrectAnswers;
  final int totalStudyMinutes;
  final double confidenceScore;
  final DateTime createdAt;
  final DateTime? subscriptionExpiresAt;
  final bool notificationsEnabled;
  final String? fcmToken;

  const UserModel({
    required this.id,
    required this.email,
    this.displayName,
    this.avatarUrl,
    this.role = UserRole.student,
    this.subscription = SubscriptionType.free,
    this.level = LearningLevel.beginner,
    this.language = 'en',
    this.studyStreak = 0,
    this.totalQuestionsAnswered = 0,
    this.totalCorrectAnswers = 0,
    this.totalStudyMinutes = 0,
    this.confidenceScore = 0.0,
    required this.createdAt,
    this.subscriptionExpiresAt,
    this.notificationsEnabled = true,
    this.fcmToken,
  });

  double get accuracy => totalQuestionsAnswered > 0
      ? (totalCorrectAnswers / totalQuestionsAnswered) * 100
      : 0.0;

  bool get isPremium => subscription != SubscriptionType.free;

  bool get isAdmin => role == UserRole.admin;

  bool get isSubscriptionActive {
    if (subscription == SubscriptionType.free) return false;
    if (subscription == SubscriptionType.lifetime) return true;
    return subscriptionExpiresAt?.isAfter(DateTime.now()) ?? false;
  }

  String get levelDisplay {
    switch (level) {
      case LearningLevel.beginner: return 'Beginner';
      case LearningLevel.intermediate: return 'Intermediate';
      case LearningLevel.advanced: return 'Advanced';
    }
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? displayName,
    String? avatarUrl,
    UserRole? role,
    SubscriptionType? subscription,
    LearningLevel? level,
    String? language,
    int? studyStreak,
    int? totalQuestionsAnswered,
    int? totalCorrectAnswers,
    int? totalStudyMinutes,
    double? confidenceScore,
    DateTime? createdAt,
    DateTime? subscriptionExpiresAt,
    bool? notificationsEnabled,
    String? fcmToken,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      subscription: subscription ?? this.subscription,
      level: level ?? this.level,
      language: language ?? this.language,
      studyStreak: studyStreak ?? this.studyStreak,
      totalQuestionsAnswered: totalQuestionsAnswered ?? this.totalQuestionsAnswered,
      totalCorrectAnswers: totalCorrectAnswers ?? this.totalCorrectAnswers,
      totalStudyMinutes: totalStudyMinutes ?? this.totalStudyMinutes,
      confidenceScore: confidenceScore ?? this.confidenceScore,
      createdAt: createdAt ?? this.createdAt,
      subscriptionExpiresAt: subscriptionExpiresAt ?? this.subscriptionExpiresAt,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      fcmToken: fcmToken ?? this.fcmToken,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'email': email,
    'display_name': displayName,
    'avatar_url': avatarUrl,
    'role': role.name,
    'subscription': subscription.name,
    'level': level.name,
    'language': language,
    'study_streak': studyStreak,
    'total_questions_answered': totalQuestionsAnswered,
    'total_correct_answers': totalCorrectAnswers,
    'total_study_minutes': totalStudyMinutes,
    'confidence_score': confidenceScore,
    'created_at': createdAt.toIso8601String(),
    'subscription_expires_at': subscriptionExpiresAt?.toIso8601String(),
    'notifications_enabled': notificationsEnabled,
    'fcm_token': fcmToken,
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'] as String,
    email: map['email'] as String,
    displayName: map['display_name'] as String?,
    avatarUrl: map['avatar_url'] as String?,
    role: UserRole.values.firstWhere(
      (e) => e.name == map['role'],
      orElse: () => UserRole.student,
    ),
    subscription: SubscriptionType.values.firstWhere(
      (e) => e.name == map['subscription'],
      orElse: () => SubscriptionType.free,
    ),
    level: LearningLevel.values.firstWhere(
      (e) => e.name == map['level'],
      orElse: () => LearningLevel.beginner,
    ),
    language: map['language'] as String? ?? 'en',
    studyStreak: map['study_streak'] as int? ?? 0,
    totalQuestionsAnswered: map['total_questions_answered'] as int? ?? 0,
    totalCorrectAnswers: map['total_correct_answers'] as int? ?? 0,
    totalStudyMinutes: map['total_study_minutes'] as int? ?? 0,
    confidenceScore: (map['confidence_score'] as num?)?.toDouble() ?? 0.0,
    createdAt: DateTime.parse(map['created_at'] as String),
    subscriptionExpiresAt: map['subscription_expires_at'] != null
        ? DateTime.parse(map['subscription_expires_at'] as String)
        : null,
    notificationsEnabled: map['notifications_enabled'] as bool? ?? true,
    fcmToken: map['fcm_token'] as String?,
  );

  @override
  List<Object?> get props => [id, email, subscription, level, studyStreak];
}
