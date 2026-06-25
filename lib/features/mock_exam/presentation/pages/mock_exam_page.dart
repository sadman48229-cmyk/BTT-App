import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/data/sample_questions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/question_model.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../quiz/presentation/widgets/question_card.dart';

class MockExamPage extends ConsumerStatefulWidget {
  const MockExamPage({super.key});

  @override
  ConsumerState<MockExamPage> createState() => _MockExamPageState();
}

class _MockExamPageState extends ConsumerState<MockExamPage> {
  List<QuestionModel> _questions = [];
  List<int?> _selectedAnswers = [];
  List<bool> _flagged = [];
  int _currentIndex = 0;
  int _remainingSeconds = AppConstants.mockExamDurationMinutes * 60;
  Timer? _timer;
  bool _started = false;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startExam() {
    final all = SampleQuestions.all;
    final selected = List<QuestionModel>.from(all)..shuffle();
    setState(() {
      _questions = selected.take(AppConstants.mockExamQuestionCount.clamp(0, all.length)).toList();
      _selectedAnswers = List.filled(_questions.length, null);
      _flagged = List.filled(_questions.length, false);
      _started = true;
    });
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        _submitExam();
      } else {
        setState(() => _remainingSeconds--);
      }
    });
  }

  void _selectAnswer(int optionIndex) {
    setState(() => _selectedAnswers[_currentIndex] = optionIndex);
  }

  void _toggleFlag() {
    setState(() => _flagged[_currentIndex] = !_flagged[_currentIndex]);
  }

  void _submitExam() {
    _timer?.cancel();
    final answers = _questions.asMap().entries.map((e) {
      final selected = _selectedAnswers[e.key];
      return UserAnswer(
        questionId: e.value.id,
        selectedOptionIndex: selected ?? 0,
        isCorrect: selected == e.value.correctOptionIndex,
        timeTakenSeconds: 0,
        answeredAt: DateTime.now(),
      );
    }).toList();

    final timeTaken = AppConstants.mockExamDurationMinutes * 60 - _remainingSeconds;

    context.go(AppRoutes.mockExamResult, extra: {
      'answers': answers,
      'questions': _questions,
      'timeTaken': timeTaken,
    });
  }

  String get _timerDisplay {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  Color get _timerColor {
    if (_remainingSeconds <= 300) return AppColors.error;
    if (_remainingSeconds <= 600) return AppColors.warning;
    return AppColors.darkTextSecondary;
  }

  int get _answeredCount => _selectedAnswers.where((a) => a != null).length;
  int get _flaggedCount => _flagged.where((f) => f).length;

  @override
  Widget build(BuildContext context) {
    if (!_started) return _StartScreen(onStart: _startExam);
    return _ExamScreen(this);
  }
}

class _StartScreen extends StatelessWidget {
  final VoidCallback onStart;
  const _StartScreen({required this.onStart});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mock Exam'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_new_rounded), onPressed: () => context.pop()),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 100, height: 100,
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), shape: BoxShape.circle),
                child: const Center(child: Text('📋', style: TextStyle(fontSize: 52))),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
            ),
            const SizedBox(height: 24),
            const Center(
              child: Text('Full Mock Exam', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800)),
            ).animate(delay: 100.ms).fadeIn(duration: 500.ms),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Simulate the real Singapore BTT experience',
                style: TextStyle(fontSize: 14, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                textAlign: TextAlign.center,
              ),
            ).animate(delay: 200.ms).fadeIn(duration: 500.ms),
            const SizedBox(height: 32),
            // Exam info cards
            _InfoCard(icon: '❓', title: 'Questions', value: '${AppConstants.mockExamQuestionCount}', subtitle: 'Multiple choice', color: AppColors.primary),
            const SizedBox(height: 12),
            _InfoCard(icon: '⏱️', title: 'Duration', value: '${AppConstants.mockExamDurationMinutes} min', subtitle: 'Auto-submit when time expires', color: AppColors.secondary),
            const SizedBox(height: 12),
            _InfoCard(icon: '✅', title: 'Passing Score', value: '${AppConstants.minPassScore}/50', subtitle: '90% accuracy required (unofficial)', color: AppColors.success),
            const SizedBox(height: 12),
            _InfoCard(icon: '🚩', title: 'Flag Feature', value: 'Available', subtitle: 'Mark questions to review later', color: AppColors.accent),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.warning.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.warning.withOpacity(0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline_rounded, color: AppColors.warning, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'This is a practice exam. Questions are original and for study purposes only. Not affiliated with official Singapore BTT.',
                      style: TextStyle(fontSize: 12, height: 1.5, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                    ),
                  ),
                ],
              ),
            ).animate(delay: 500.ms).fadeIn(duration: 400.ms),
            const SizedBox(height: 24),
            AppButton(
              label: 'Start Mock Exam',
              onPressed: onStart,
              icon: Icons.play_arrow_rounded,
            ).animate(delay: 600.ms).fadeIn(duration: 400.ms),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String icon;
  final String title;
  final String value;
  final String subtitle;
  final Color color;

  const _InfoCard({required this.icon, required this.title, required this.value, required this.subtitle, required this.color});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(icon, style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 12, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
                Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: color)),
                Text(subtitle, style: TextStyle(fontSize: 11, color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExamScreen extends StatelessWidget {
  final _MockExamPageState state;
  const _ExamScreen(this.state);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final q = state._questions[state._currentIndex];
    final selected = state._selectedAnswers[state._currentIndex];
    final isFlagged = state._flagged[state._currentIndex];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${state._currentIndex + 1} / ${state._questions.length}',
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Icon(Icons.timer_outlined, size: 16, color: state._timerColor),
                    const SizedBox(width: 4),
                    Text(state._timerDisplay,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: state._timerColor)),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.check_circle_rounded, size: 14, color: AppColors.success),
                    const SizedBox(width: 4),
                    Text('${state._answeredCount}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 8),
                    Icon(Icons.flag_rounded, size: 14, color: state._flaggedCount > 0 ? AppColors.warning : AppColors.darkTextTertiary),
                    const SizedBox(width: 4),
                    Text('${state._flaggedCount}', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (state._currentIndex + 1) / state._questions.length,
                backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                minHeight: 4,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Flag & question number row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text('Q${state._currentIndex + 1}',
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.primary)),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: state._toggleFlag,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isFlagged ? AppColors.warning.withOpacity(0.1) : (isDark ? AppColors.darkElevated : AppColors.lightElevated),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: isFlagged ? AppColors.warning : Colors.transparent),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(isFlagged ? Icons.flag_rounded : Icons.flag_outlined,
                                  size: 14, color: isFlagged ? AppColors.warning : AppColors.darkTextTertiary),
                              const SizedBox(width: 4),
                              Text(isFlagged ? 'Flagged' : 'Flag',
                                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,
                                      color: isFlagged ? AppColors.warning : AppColors.darkTextTertiary)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  QuestionCard(question: q, key: ValueKey(q.id)),
                  const SizedBox(height: 20),
                  ...q.options.asMap().entries.map((entry) {
                    final idx = entry.key;
                    final isSelected = selected == idx;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        onTap: () => (state as dynamic)._selectAnswer(idx),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.primary.withOpacity(0.1) : (isDark ? AppColors.darkCard : AppColors.lightCard),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 32, height: 32,
                                decoration: BoxDecoration(
                                  color: (isSelected ? AppColors.primary : AppColors.darkTextTertiary).withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(['A', 'B', 'C', 'D'][idx],
                                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                                          color: isSelected ? AppColors.primary : AppColors.darkTextTertiary)),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(entry.value,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500,
                                        color: isSelected ? AppColors.primary : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary))),
                              ),
                              if (isSelected) const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 18),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),

          // Bottom navigation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              border: Border(top: BorderSide(color: isDark ? AppColors.darkBorder : AppColors.lightBorder)),
            ),
            child: SafeArea(
              child: Row(
                children: [
                  if (state._currentIndex > 0)
                    Expanded(
                      child: AppButton(
                        label: 'Previous',
                        isOutlined: true,
                        onPressed: () => (state as dynamic).setState(() => state._currentIndex--),
                        icon: Icons.arrow_back_rounded,
                      ),
                    ),
                  if (state._currentIndex > 0) const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: state._currentIndex < state._questions.length - 1
                        ? AppButton(
                            label: 'Next',
                            onPressed: () => (state as dynamic).setState(() => state._currentIndex++),
                            icon: Icons.arrow_forward_rounded,
                          )
                        : AppButton(
                            label: 'Submit Exam',
                            onPressed: () => _confirmSubmit(context, state),
                            color: AppColors.success,
                            icon: Icons.check_rounded,
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmSubmit(BuildContext context, _MockExamPageState state) {
    final unanswered = state._selectedAnswers.where((a) => a == null).length;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Submit Exam?'),
        content: Text(unanswered > 0
            ? 'You have $unanswered unanswered question${unanswered == 1 ? '' : 's'}. Are you sure you want to submit?'
            : 'You have answered all ${state._questions.length} questions. Submit now?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Review')),
          ElevatedButton(
            onPressed: () { Navigator.pop(ctx); state._submitExam(); },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.success),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
