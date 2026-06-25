import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

enum ChapterId {
  roadSigns,
  roadMarkings,
  trafficRules,
  parking,
  speedLimits,
  rightOfWay,
  expressway,
  vehicleControls,
  safety,
}

class ChapterModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final int color;
  final int order;
  final bool isLocked;
  final bool isPremium;
  final int totalLessons;
  final int totalQuestions;
  final List<LessonModel> lessons;
  final int completedLessons;
  final int questionsAnswered;
  final double accuracy;
  final bool isCompleted;

  const ChapterModel({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.color,
    required this.order,
    this.isLocked = false,
    this.isPremium = false,
    required this.totalLessons,
    required this.totalQuestions,
    this.lessons = const [],
    this.completedLessons = 0,
    this.questionsAnswered = 0,
    this.accuracy = 0.0,
    this.isCompleted = false,
  });

  double get progressPercentage =>
      totalLessons > 0 ? completedLessons / totalLessons : 0.0;

  Color get chapterColor => Color(color);

  ChapterModel copyWith({
    String? id,
    String? title,
    String? description,
    String? emoji,
    int? color,
    int? order,
    bool? isLocked,
    bool? isPremium,
    int? totalLessons,
    int? totalQuestions,
    List<LessonModel>? lessons,
    int? completedLessons,
    int? questionsAnswered,
    double? accuracy,
    bool? isCompleted,
  }) {
    return ChapterModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      emoji: emoji ?? this.emoji,
      color: color ?? this.color,
      order: order ?? this.order,
      isLocked: isLocked ?? this.isLocked,
      isPremium: isPremium ?? this.isPremium,
      totalLessons: totalLessons ?? this.totalLessons,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      lessons: lessons ?? this.lessons,
      completedLessons: completedLessons ?? this.completedLessons,
      questionsAnswered: questionsAnswered ?? this.questionsAnswered,
      accuracy: accuracy ?? this.accuracy,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'emoji': emoji,
    'color': color,
    'order': order,
    'is_locked': isLocked,
    'is_premium': isPremium,
    'total_lessons': totalLessons,
    'total_questions': totalQuestions,
  };

  factory ChapterModel.fromMap(Map<String, dynamic> map) => ChapterModel(
    id: map['id'] as String,
    title: map['title'] as String,
    description: map['description'] as String,
    emoji: map['emoji'] as String? ?? '📚',
    color: map['color'] as int? ?? AppColors.primary.value,
    order: map['order'] as int? ?? 0,
    isLocked: map['is_locked'] as bool? ?? false,
    isPremium: map['is_premium'] as bool? ?? false,
    totalLessons: map['total_lessons'] as int? ?? 0,
    totalQuestions: map['total_questions'] as int? ?? 0,
  );

  @override
  List<Object?> get props => [id, title, order];
}

class LessonModel extends Equatable {
  final String id;
  final String chapterId;
  final String title;
  final String type; // 'theory', 'illustration', 'quiz', 'scenario', 'memory_hack'
  final String content;
  final int order;
  final bool isCompleted;
  final int estimatedMinutes;
  final String? imageUrl;
  final List<String>? keyPoints;

  const LessonModel({
    required this.id,
    required this.chapterId,
    required this.title,
    required this.type,
    required this.content,
    required this.order,
    this.isCompleted = false,
    this.estimatedMinutes = 5,
    this.imageUrl,
    this.keyPoints,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'chapter_id': chapterId,
    'title': title,
    'type': type,
    'content': content,
    'order': order,
    'is_completed': isCompleted,
    'estimated_minutes': estimatedMinutes,
    'image_url': imageUrl,
    'key_points': keyPoints,
  };

  factory LessonModel.fromMap(Map<String, dynamic> map) => LessonModel(
    id: map['id'] as String,
    chapterId: map['chapter_id'] as String,
    title: map['title'] as String,
    type: map['type'] as String? ?? 'theory',
    content: map['content'] as String,
    order: map['order'] as int? ?? 0,
    isCompleted: map['is_completed'] as bool? ?? false,
    estimatedMinutes: map['estimated_minutes'] as int? ?? 5,
    imageUrl: map['image_url'] as String?,
    keyPoints: map['key_points'] != null
        ? List<String>.from(map['key_points'] as List)
        : null,
  );

  @override
  List<Object?> get props => [id, chapterId, order];
}

// Default chapters data
List<ChapterModel> get defaultChapters => [
  ChapterModel(
    id: 'road_signs',
    title: 'Road Signs',
    description: 'Learn all Singapore road signs — mandatory, warning, and informational.',
    emoji: '🚦',
    color: AppColors.chapterSigns.value,
    order: 1,
    totalLessons: 8,
    totalQuestions: 60,
  ),
  ChapterModel(
    id: 'road_markings',
    title: 'Road Markings',
    description: 'Understand road lines, arrows, and markings on Singapore roads.',
    emoji: '🛣️',
    color: AppColors.chapterMarkings.value,
    order: 2,
    totalLessons: 5,
    totalQuestions: 40,
  ),
  ChapterModel(
    id: 'traffic_rules',
    title: 'Traffic Rules',
    description: 'Master the fundamental rules governing traffic in Singapore.',
    emoji: '📋',
    color: AppColors.chapterTrafficRules.value,
    order: 3,
    totalLessons: 10,
    totalQuestions: 80,
  ),
  ChapterModel(
    id: 'parking',
    title: 'Parking Rules',
    description: 'Learn where and how to park legally in Singapore.',
    emoji: '🅿️',
    color: AppColors.chapterParking.value,
    order: 4,
    totalLessons: 5,
    totalQuestions: 35,
  ),
  ChapterModel(
    id: 'speed_limits',
    title: 'Speed Limits',
    description: 'Know the speed limits for different roads and conditions.',
    emoji: '⚡',
    color: AppColors.chapterSpeed.value,
    order: 5,
    totalLessons: 4,
    totalQuestions: 30,
  ),
  ChapterModel(
    id: 'right_of_way',
    title: 'Right of Way',
    description: 'Understand who goes first at junctions and intersections.',
    emoji: '🚗',
    color: AppColors.chapterRightOfWay.value,
    order: 6,
    totalLessons: 6,
    totalQuestions: 45,
  ),
  ChapterModel(
    id: 'expressway',
    title: 'Expressway Rules',
    description: 'Special rules for driving on Singapore expressways (PIE, AYE, etc.).',
    emoji: '🛤️',
    color: AppColors.chapterExpressway.value,
    order: 7,
    totalLessons: 5,
    totalQuestions: 35,
    isPremium: true,
  ),
  ChapterModel(
    id: 'vehicle_controls',
    title: 'Vehicle Controls',
    description: 'Learn about vehicle instruments, controls, and maintenance basics.',
    emoji: '🚘',
    color: AppColors.chapterVehicle.value,
    order: 8,
    totalLessons: 5,
    totalQuestions: 30,
    isPremium: true,
  ),
  ChapterModel(
    id: 'safety',
    title: 'Road Safety',
    description: 'Essential safety practices for Singapore roads.',
    emoji: '🦺',
    color: AppColors.chapterSafety.value,
    order: 9,
    totalLessons: 6,
    totalQuestions: 40,
    isPremium: true,
  ),
];
