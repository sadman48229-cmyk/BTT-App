import 'package:equatable/equatable.dart';

enum AchievementTier { bronze, silver, gold, platinum }

class AchievementModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final AchievementTier tier;
  final int xpReward;
  final bool isUnlocked;
  final DateTime? unlockedAt;
  final double progress; // 0.0 to 1.0
  final String condition;

  const AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.tier,
    required this.xpReward,
    this.isUnlocked = false,
    this.unlockedAt,
    this.progress = 0.0,
    required this.condition,
  });

  AchievementModel copyWith({
    bool? isUnlocked,
    DateTime? unlockedAt,
    double? progress,
  }) {
    return AchievementModel(
      id: id,
      title: title,
      description: description,
      emoji: emoji,
      tier: tier,
      xpReward: xpReward,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      unlockedAt: unlockedAt ?? this.unlockedAt,
      progress: progress ?? this.progress,
      condition: condition,
    );
  }

  @override
  List<Object?> get props => [id, isUnlocked, progress];
}

List<AchievementModel> get allAchievements => [
  const AchievementModel(
    id: 'first_quiz',
    title: 'First Step',
    description: 'Complete your first quiz',
    emoji: '🎯',
    tier: AchievementTier.bronze,
    xpReward: 50,
    condition: 'Complete 1 quiz',
  ),
  const AchievementModel(
    id: 'streak_3',
    title: '3 Day Streak',
    description: 'Study for 3 days in a row',
    emoji: '🔥',
    tier: AchievementTier.bronze,
    xpReward: 100,
    condition: 'Study for 3 consecutive days',
  ),
  const AchievementModel(
    id: 'streak_7',
    title: 'Week Warrior',
    description: 'Study for 7 days in a row',
    emoji: '🏆',
    tier: AchievementTier.silver,
    xpReward: 200,
    condition: 'Study for 7 consecutive days',
  ),
  const AchievementModel(
    id: 'streak_30',
    title: 'Dedication Master',
    description: 'Study for 30 days in a row',
    emoji: '💎',
    tier: AchievementTier.gold,
    xpReward: 500,
    condition: 'Study for 30 consecutive days',
  ),
  const AchievementModel(
    id: 'questions_100',
    title: 'Century Learner',
    description: 'Answer 100 questions',
    emoji: '💯',
    tier: AchievementTier.bronze,
    xpReward: 150,
    condition: 'Answer 100 questions',
  ),
  const AchievementModel(
    id: 'questions_500',
    title: 'Knowledge Seeker',
    description: 'Answer 500 questions',
    emoji: '📚',
    tier: AchievementTier.silver,
    xpReward: 300,
    condition: 'Answer 500 questions',
  ),
  const AchievementModel(
    id: 'perfect_quiz',
    title: 'Perfect Score',
    description: 'Get 100% on any quiz',
    emoji: '⭐',
    tier: AchievementTier.silver,
    xpReward: 250,
    condition: 'Score 100% on a quiz',
  ),
  const AchievementModel(
    id: 'road_sign_master',
    title: 'Road Sign Master',
    description: 'Complete all Road Signs lessons with 90%+ accuracy',
    emoji: '🚦',
    tier: AchievementTier.gold,
    xpReward: 400,
    condition: '90%+ accuracy in Road Signs',
  ),
  const AchievementModel(
    id: 'parking_expert',
    title: 'Parking Expert',
    description: 'Complete all Parking lessons with 90%+ accuracy',
    emoji: '🅿️',
    tier: AchievementTier.gold,
    xpReward: 400,
    condition: '90%+ accuracy in Parking',
  ),
  const AchievementModel(
    id: 'mock_pass',
    title: 'Mock Champion',
    description: 'Score 45/50 or more in a mock exam',
    emoji: '🎓',
    tier: AchievementTier.gold,
    xpReward: 500,
    condition: 'Score 45+ in mock exam',
  ),
  const AchievementModel(
    id: 'fast_learner',
    title: 'Fast Learner',
    description: 'Answer 10 questions correctly in under 30 seconds each',
    emoji: '⚡',
    tier: AchievementTier.silver,
    xpReward: 200,
    condition: 'Answer 10 questions quickly',
  ),
  const AchievementModel(
    id: 'all_chapters',
    title: 'Complete Scholar',
    description: 'Complete all 9 chapters',
    emoji: '🌟',
    tier: AchievementTier.platinum,
    xpReward: 1000,
    condition: 'Complete all chapters',
  ),
  const AchievementModel(
    id: 'ai_explorer',
    title: 'AI Explorer',
    description: 'Have 10 conversations with BTT AI Tutor',
    emoji: '🤖',
    tier: AchievementTier.bronze,
    xpReward: 100,
    condition: '10 AI conversations',
  ),
  const AchievementModel(
    id: 'daily_7',
    title: 'Daily Champion',
    description: 'Complete 7 daily challenges',
    emoji: '📅',
    tier: AchievementTier.silver,
    xpReward: 300,
    condition: 'Complete 7 daily challenges',
  ),
];
