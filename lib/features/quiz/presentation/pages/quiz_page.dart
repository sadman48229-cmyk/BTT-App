import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/question_model.dart';
import '../../../../shared/widgets/app_button.dart';
import '../providers/quiz_provider.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress_bar.dart';

class QuizPage extends ConsumerStatefulWidget {
  final String? chapterId;
  final String? difficulty;
  final int questionCount;

  const QuizPage({
    super.key,
    this.chapterId,
    this.difficulty,
    this.questionCount = 10,
  });

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(quizProvider.notifier).startQuiz(
        chapterId: widget.chapterId,
        difficulty: widget.difficulty,
        questionCount: widget.questionCount,
      );
    });
  }

  Future<bool> _onWillPop() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quit Quiz?'),
        content: const Text('Your progress will be lost. Are you sure you want to quit?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Continue')),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Quit', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(quizProvider);

    if (state.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state.isComplete) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go(AppRoutes.quizResult, extra: {
          'answers': state.answers,
          'questions': state.questions,
          'timeTaken': state.elapsedSeconds,
          'chapterId': widget.chapterId,
        });
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final question = state.currentQuestion;
    if (question == null) {
      return const Scaffold(body: Center(child: Text('No questions available')));
    }

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) {
          final shouldPop = await _onWillPop();
          if (shouldPop && context.mounted) context.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.chapterId != null ? 'Chapter Quiz' : 'Practice Quiz',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () async {
              if (await _onWillPop()) context.pop();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: _TimerWidget(seconds: state.elapsedSeconds),
            ),
          ],
        ),
        body: Column(
          children: [
            // Progress bar
            QuizProgressBar(
              current: state.currentIndex + 1,
              total: state.questions.length,
              correct: state.correctCount,
            ),

            // Question
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // Question number
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Question ${state.currentIndex + 1} of ${state.questions.length}',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _DifficultyBadge(difficulty: question.difficulty),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Question card
                    QuestionCard(question: question, key: ValueKey(question.id)),

                    const SizedBox(height: 24),

                    // Options
                    ...question.options.asMap().entries.map((entry) {
                      final index = entry.key;
                      final option = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _OptionTile(
                          index: index,
                          option: option,
                          selectedIndex: state.selectedOptionIndex,
                          correctIndex: state.showAnswer ? question.correctOptionIndex : null,
                          onTap: state.selectedOptionIndex == null
                              ? () => ref.read(quizProvider.notifier).selectAnswer(index)
                              : null,
                        ),
                      );
                    }),

                    // Explanation
                    if (state.showAnswer) ...[
                      const SizedBox(height: 16),
                      _ExplanationCard(
                        question: question,
                        selectedIndex: state.selectedOptionIndex!,
                      ),
                    ],

                    const SizedBox(height: 24),

                    // Next button
                    if (state.showAnswer)
                      AppButton(
                        label: state.currentIndex < state.questions.length - 1
                            ? 'Next Question'
                            : 'See Results',
                        onPressed: () => ref.read(quizProvider.notifier).nextQuestion(),
                        icon: Icons.arrow_forward_rounded,
                      ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.3, end: 0),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimerWidget extends StatelessWidget {
  final int seconds;

  const _TimerWidget({required this.seconds});

  String _format(int s) {
    final m = s ~/ 60;
    final sec = s % 60;
    return '${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.darkElevated,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.timer_outlined, size: 14, color: AppColors.darkTextSecondary),
          const SizedBox(width: 4),
          Text(
            _format(seconds),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  final Difficulty difficulty;

  const _DifficultyBadge({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    final color = switch (difficulty) {
      Difficulty.easy => AppColors.success,
      Difficulty.medium => AppColors.warning,
      Difficulty.hard => AppColors.error,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 5),
          Text(
            difficulty.difficultyLabel,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color),
          ),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final int index;
  final String option;
  final int? selectedIndex;
  final int? correctIndex;
  final VoidCallback? onTap;

  const _OptionTile({
    required this.index,
    required this.option,
    required this.selectedIndex,
    required this.correctIndex,
    required this.onTap,
  });

  String get _letter => ['A', 'B', 'C', 'D'][index];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isSelected = selectedIndex == index;
    final isCorrect = correctIndex == index;
    final isWrong = isSelected && correctIndex != null && !isCorrect;

    Color bgColor;
    Color borderColor;
    Color textColor;

    if (correctIndex != null) {
      if (isCorrect) {
        bgColor = AppColors.success.withOpacity(0.1);
        borderColor = AppColors.success;
        textColor = AppColors.success;
      } else if (isWrong) {
        bgColor = AppColors.error.withOpacity(0.1);
        borderColor = AppColors.error;
        textColor = AppColors.error;
      } else {
        bgColor = isDark ? AppColors.darkCard : AppColors.lightCard;
        borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
        textColor = isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary;
      }
    } else if (isSelected) {
      bgColor = AppColors.primary.withOpacity(0.1);
      borderColor = AppColors.primary;
      textColor = AppColors.primary;
    } else {
      bgColor = isDark ? AppColors.darkCard : AppColors.lightCard;
      borderColor = isDark ? AppColors.darkBorder : AppColors.lightBorder;
      textColor = isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary;
    }

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: borderColor, width: 1.5),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: borderColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  _letter,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: borderColor,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  height: 1.4,
                ),
              ),
            ),
            if (correctIndex != null) ...[
              const SizedBox(width: 8),
              Icon(
                isCorrect
                    ? Icons.check_circle_rounded
                    : (isWrong ? Icons.cancel_rounded : null),
                color: isCorrect ? AppColors.success : AppColors.error,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ExplanationCard extends StatelessWidget {
  final QuestionModel question;
  final int selectedIndex;

  const _ExplanationCard({required this.question, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isCorrect = selectedIndex == question.correctOptionIndex;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.success.withOpacity(0.05)
            : AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCorrect
              ? AppColors.success.withOpacity(0.3)
              : AppColors.error.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle_rounded : Icons.info_rounded,
                color: isCorrect ? AppColors.success : AppColors.error,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect ? 'Correct! 🎉' : 'Not quite right',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: isCorrect ? AppColors.success : AppColors.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            question.explanation,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          if (!isCorrect && question.wrongExplanations.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              '✓ Correct answer: ${question.correctOption}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.3, end: 0);
  }
}
