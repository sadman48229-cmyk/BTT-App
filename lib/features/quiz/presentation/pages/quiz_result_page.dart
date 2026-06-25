import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/question_model.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../presentation/providers/ai_result_provider.dart';

class QuizResultPage extends ConsumerStatefulWidget {
  final Map<String, dynamic> resultData;

  const QuizResultPage({super.key, required this.resultData});

  @override
  ConsumerState<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends ConsumerState<QuizResultPage> {
  late ConfettiController _confetti;
  late List<UserAnswer> _answers;
  late List<QuestionModel> _questions;
  late int _timeTaken;

  @override
  void initState() {
    super.initState();
    _answers = (widget.resultData['answers'] as List).cast<UserAnswer>();
    _questions = (widget.resultData['questions'] as List).cast<QuestionModel>();
    _timeTaken = widget.resultData['timeTaken'] as int? ?? 0;

    _confetti = ConfettiController(duration: const Duration(seconds: 3));

    final correct = _answers.where((a) => a.isCorrect).length;
    final percent = _answers.isNotEmpty ? correct / _answers.length : 0.0;
    if (percent >= 0.7) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _confetti.play());
    }
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  int get _correct => _answers.where((a) => a.isCorrect).length;
  double get _accuracy => _answers.isNotEmpty ? _correct / _answers.length : 0.0;

  String get _resultMessage {
    if (_accuracy >= 0.9) return 'Outstanding! 🏆';
    if (_accuracy >= 0.7) return 'Great job! 🎉';
    if (_accuracy >= 0.5) return 'Good effort! 💪';
    return 'Keep practicing! 📚';
  }

  Color get _resultColor {
    if (_accuracy >= 0.9) return AppColors.success;
    if (_accuracy >= 0.7) return AppColors.primary;
    if (_accuracy >= 0.5) return AppColors.warning;
    return AppColors.error;
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final wrongAnswers = _answers
        .where((a) => !a.isCorrect)
        .map((a) => _questions.firstWhere((q) => q.id == a.questionId))
        .toList();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Quiz Results'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => context.go(AppRoutes.home),
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Score circle
                CircularPercentIndicator(
                  radius: 90,
                  lineWidth: 12,
                  percent: _accuracy,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${(_accuracy * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: _resultColor,
                        ),
                      ),
                      Text(
                        '$_correct/${_answers.length}',
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                  progressColor: _resultColor,
                  backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 1200,
                ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),

                const SizedBox(height: 16),

                Text(
                  _resultMessage,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ).animate(delay: 300.ms).fadeIn(duration: 500.ms),

                const SizedBox(height: 8),

                Text(
                  'You got $_correct out of ${_answers.length} questions correct',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                  textAlign: TextAlign.center,
                ).animate(delay: 400.ms).fadeIn(duration: 500.ms),

                const SizedBox(height: 24),

                // Stats row
                Row(
                  children: [
                    Expanded(child: _StatCard(icon: '✅', label: 'Correct', value: '$_correct', color: AppColors.success)),
                    const SizedBox(width: 12),
                    Expanded(child: _StatCard(icon: '❌', label: 'Wrong', value: '${_answers.length - _correct}', color: AppColors.error)),
                    const SizedBox(width: 12),
                    Expanded(child: _StatCard(icon: '⏱️', label: 'Time', value: _formatTime(_timeTaken), color: AppColors.secondary)),
                  ],
                ).animate(delay: 500.ms).fadeIn(duration: 500.ms),

                const SizedBox(height: 24),

                // Action buttons
                AppButton(
                  label: 'Try Again',
                  onPressed: () {
                    context.pop();
                    context.push(AppRoutes.quiz, extra: {
                      'chapterId': widget.resultData['chapterId'],
                    });
                  },
                  icon: Icons.refresh_rounded,
                ).animate(delay: 600.ms).fadeIn(duration: 500.ms),

                const SizedBox(height: 12),

                AppButton(
                  label: 'Ask AI to Explain Mistakes',
                  onPressed: wrongAnswers.isEmpty
                      ? null
                      : () {
                          context.go(AppRoutes.aiTutor);
                        },
                  isOutlined: true,
                  icon: Icons.auto_awesome_rounded,
                ).animate(delay: 700.ms).fadeIn(duration: 500.ms),

                // Wrong answers review
                if (wrongAnswers.isNotEmpty) ...[
                  const SizedBox(height: 32),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Review Mistakes',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...wrongAnswers.asMap().entries.map((entry) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _WrongAnswerCard(
                      question: entry.value,
                      answer: _answers.firstWhere((a) => a.questionId == entry.value.id),
                      isDark: isDark,
                    ).animate(delay: Duration(milliseconds: 800 + entry.key * 100))
                     .fadeIn(duration: 400.ms)
                     .slideX(begin: -0.2, end: 0),
                  )),
                ],

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),

        // Confetti
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            colors: const [
              AppColors.primary,
              AppColors.secondary,
              AppColors.accent,
              AppColors.success,
            ],
            numberOfParticles: 40,
            gravity: 0.15,
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({required this.icon, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: color)),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _WrongAnswerCard extends StatelessWidget {
  final QuestionModel question;
  final UserAnswer answer;
  final bool isDark;

  const _WrongAnswerCard({required this.question, required this.answer, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.error.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.error.withOpacity(0.2), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question.question,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.close_rounded, size: 14, color: AppColors.error),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'You: ${question.options[answer.selectedOptionIndex]}',
                  style: const TextStyle(fontSize: 13, color: AppColors.error),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.check_rounded, size: 14, color: AppColors.success),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  'Answer: ${question.correctOption}',
                  style: const TextStyle(fontSize: 13, color: AppColors.success, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            question.explanation,
            style: TextStyle(
              fontSize: 12,
              height: 1.5,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
