import 'package:equatable/equatable.dart';

enum Difficulty { easy, medium, hard }
enum QuestionType { multipleChoice, trueFalse, scenario }

class QuestionModel extends Equatable {
  final String id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;
  final String explanation;
  final List<String> wrongExplanations;
  final Difficulty difficulty;
  final QuestionType type;
  final String chapterId;
  final String chapterName;
  final List<String> tags;
  final String? imageUrl;
  final int estimatedTimeSeconds;
  final bool isActive;
  final DateTime createdAt;

  const QuestionModel({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
    required this.explanation,
    this.wrongExplanations = const [],
    this.difficulty = Difficulty.medium,
    this.type = QuestionType.multipleChoice,
    required this.chapterId,
    required this.chapterName,
    this.tags = const [],
    this.imageUrl,
    this.estimatedTimeSeconds = 60,
    this.isActive = true,
    required this.createdAt,
  });

  String get correctOption => options[correctOptionIndex];

  String get difficultyLabel {
    switch (difficulty) {
      case Difficulty.easy: return 'Easy';
      case Difficulty.medium: return 'Medium';
      case Difficulty.hard: return 'Hard';
    }
  }

  QuestionModel copyWith({
    String? id,
    String? question,
    List<String>? options,
    int? correctOptionIndex,
    String? explanation,
    List<String>? wrongExplanations,
    Difficulty? difficulty,
    QuestionType? type,
    String? chapterId,
    String? chapterName,
    List<String>? tags,
    String? imageUrl,
    int? estimatedTimeSeconds,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return QuestionModel(
      id: id ?? this.id,
      question: question ?? this.question,
      options: options ?? this.options,
      correctOptionIndex: correctOptionIndex ?? this.correctOptionIndex,
      explanation: explanation ?? this.explanation,
      wrongExplanations: wrongExplanations ?? this.wrongExplanations,
      difficulty: difficulty ?? this.difficulty,
      type: type ?? this.type,
      chapterId: chapterId ?? this.chapterId,
      chapterName: chapterName ?? this.chapterName,
      tags: tags ?? this.tags,
      imageUrl: imageUrl ?? this.imageUrl,
      estimatedTimeSeconds: estimatedTimeSeconds ?? this.estimatedTimeSeconds,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'question': question,
    'options': options,
    'correct_option_index': correctOptionIndex,
    'explanation': explanation,
    'wrong_explanations': wrongExplanations,
    'difficulty': difficulty.name,
    'type': type.name,
    'chapter_id': chapterId,
    'chapter_name': chapterName,
    'tags': tags,
    'image_url': imageUrl,
    'estimated_time_seconds': estimatedTimeSeconds,
    'is_active': isActive,
    'created_at': createdAt.toIso8601String(),
  };

  factory QuestionModel.fromMap(Map<String, dynamic> map) => QuestionModel(
    id: map['id'] as String,
    question: map['question'] as String,
    options: List<String>.from(map['options'] as List),
    correctOptionIndex: map['correct_option_index'] as int,
    explanation: map['explanation'] as String,
    wrongExplanations: map['wrong_explanations'] != null
        ? List<String>.from(map['wrong_explanations'] as List)
        : [],
    difficulty: Difficulty.values.firstWhere(
      (e) => e.name == map['difficulty'],
      orElse: () => Difficulty.medium,
    ),
    type: QuestionType.values.firstWhere(
      (e) => e.name == map['type'],
      orElse: () => QuestionType.multipleChoice,
    ),
    chapterId: map['chapter_id'] as String,
    chapterName: map['chapter_name'] as String,
    tags: map['tags'] != null ? List<String>.from(map['tags'] as List) : [],
    imageUrl: map['image_url'] as String?,
    estimatedTimeSeconds: map['estimated_time_seconds'] as int? ?? 60,
    isActive: map['is_active'] as bool? ?? true,
    createdAt: DateTime.parse(map['created_at'] as String),
  );

  @override
  List<Object?> get props => [id, question, correctOptionIndex];
}

class UserAnswer extends Equatable {
  final String questionId;
  final int selectedOptionIndex;
  final bool isCorrect;
  final int timeTakenSeconds;
  final DateTime answeredAt;

  const UserAnswer({
    required this.questionId,
    required this.selectedOptionIndex,
    required this.isCorrect,
    required this.timeTakenSeconds,
    required this.answeredAt,
  });

  Map<String, dynamic> toMap() => {
    'question_id': questionId,
    'selected_option_index': selectedOptionIndex,
    'is_correct': isCorrect,
    'time_taken_seconds': timeTakenSeconds,
    'answered_at': answeredAt.toIso8601String(),
  };

  factory UserAnswer.fromMap(Map<String, dynamic> map) => UserAnswer(
    questionId: map['question_id'] as String,
    selectedOptionIndex: map['selected_option_index'] as int,
    isCorrect: map['is_correct'] as bool,
    timeTakenSeconds: map['time_taken_seconds'] as int,
    answeredAt: DateTime.parse(map['answered_at'] as String),
  );

  @override
  List<Object?> get props => [questionId, selectedOptionIndex, isCorrect];
}
