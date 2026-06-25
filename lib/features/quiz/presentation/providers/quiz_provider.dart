import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/models/question_model.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/data/sample_questions.dart';

class QuizState {
  final List<QuestionModel> questions;
  final int currentIndex;
  final int? selectedOptionIndex;
  final bool showAnswer;
  final List<UserAnswer> answers;
  final bool isLoading;
  final bool isComplete;
  final int elapsedSeconds;

  const QuizState({
    this.questions = const [],
    this.currentIndex = 0,
    this.selectedOptionIndex,
    this.showAnswer = false,
    this.answers = const [],
    this.isLoading = true,
    this.isComplete = false,
    this.elapsedSeconds = 0,
  });

  QuestionModel? get currentQuestion =>
      questions.isNotEmpty && currentIndex < questions.length ? questions[currentIndex] : null;

  int get correctCount => answers.where((a) => a.isCorrect).length;

  double get accuracy => answers.isNotEmpty ? correctCount / answers.length : 0.0;

  QuizState copyWith({
    List<QuestionModel>? questions,
    int? currentIndex,
    int? selectedOptionIndex,
    bool? showAnswer,
    List<UserAnswer>? answers,
    bool? isLoading,
    bool? isComplete,
    int? elapsedSeconds,
    bool clearSelected = false,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedOptionIndex: clearSelected ? null : (selectedOptionIndex ?? this.selectedOptionIndex),
      showAnswer: showAnswer ?? this.showAnswer,
      answers: answers ?? this.answers,
      isLoading: isLoading ?? this.isLoading,
      isComplete: isComplete ?? this.isComplete,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
    );
  }
}

final quizProvider = StateNotifierProvider<QuizNotifier, QuizState>((ref) {
  return QuizNotifier();
});

class QuizNotifier extends StateNotifier<QuizState> {
  Timer? _timer;
  int _questionStartTime = 0;

  QuizNotifier() : super(const QuizState());

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> startQuiz({
    String? chapterId,
    String? difficulty,
    int questionCount = 10,
  }) async {
    state = const QuizState(isLoading: true);

    try {
      // Load questions from sample data or Supabase
      var questions = SampleQuestions.get(
        chapterId: chapterId,
        difficulty: difficulty,
        count: questionCount,
      );

      questions.shuffle();

      state = QuizState(
        questions: questions,
        isLoading: false,
        currentIndex: 0,
      );

      _startTimer();
      _questionStartTime = DateTime.now().millisecondsSinceEpoch;
    } catch (e) {
      state = const QuizState(isLoading: false);
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state = state.copyWith(elapsedSeconds: state.elapsedSeconds + 1);
    });
  }

  void selectAnswer(int optionIndex) {
    if (state.selectedOptionIndex != null) return;

    final question = state.currentQuestion;
    if (question == null) return;

    final timeTaken = ((DateTime.now().millisecondsSinceEpoch - _questionStartTime) / 1000).round();
    final isCorrect = optionIndex == question.correctOptionIndex;

    final answer = UserAnswer(
      questionId: question.id,
      selectedOptionIndex: optionIndex,
      isCorrect: isCorrect,
      timeTakenSeconds: timeTaken,
      answeredAt: DateTime.now(),
    );

    state = state.copyWith(
      selectedOptionIndex: optionIndex,
      showAnswer: true,
      answers: [...state.answers, answer],
    );

    // Save mistake if wrong
    if (!isCorrect) {
      LocalStorageService.saveMistake(question.id, {
        ...question.toMap(),
        'selectedOptionIndex': optionIndex,
      });
    }
  }

  void nextQuestion() {
    if (state.currentIndex >= state.questions.length - 1) {
      _timer?.cancel();
      state = state.copyWith(isComplete: true);
    } else {
      _questionStartTime = DateTime.now().millisecondsSinceEpoch;
      state = state.copyWith(
        currentIndex: state.currentIndex + 1,
        clearSelected: true,
        showAnswer: false,
      );
    }
  }

  void resetQuiz() {
    _timer?.cancel();
    state = const QuizState();
  }
}
