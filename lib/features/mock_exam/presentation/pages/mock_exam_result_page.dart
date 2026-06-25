import 'package:confetti/confetti.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/question_model.dart';
import '../../../../shared/widgets/app_button.dart';

class MockExamResultPage extends StatefulWidget {
  final Map<String, dynamic> resultData;
  const MockExamResultPage({super.key, required this.resultData});

  @override
  State<MockExamResultPage> createState() => _MockExamResultPageState();
}

class _MockExamResultPageState extends State<MockExamResultPage> {
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
    _confetti = ConfettiController(duration: const Duration(seconds: 5));
    if (_score >= AppConstants.minPassScore) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _confetti.play());
    }
  }

  @override
  void dispose() { _confetti.dispose(); super.dispose(); }

  int get _score => _answers.where((a) => a.isCorrect).length;
  double get _pct => _answers.isNotEmpty ? _score / _answers.length : 0.0;
  bool get _passed => _score >= AppConstants.minPassScore;

  String _formatTime(int s) => '${s ~/ 60}m ${s % 60}s';

  Map<String, _ChapterResult> _byChapter() {
    final map = <String, _ChapterResult>{};
    for (int i = 0; i < _answers.length; i++) {
      final q = _questions[i];
      final a = _answers[i];
      map.putIfAbsent(q.chapterName, () => _ChapterResult(q.chapterName));
      map[q.chapterName]!.total++;
      if (a.isCorrect) map[q.chapterName]!.correct++;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chapterResults = _byChapter();

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Exam Results'),
            automaticallyImplyLeading: false,
            actions: [
              IconButton(icon: const Icon(Icons.home_rounded), onPressed: () => context.go(AppRoutes.home)),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Pass/Fail banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: _passed ? AppColors.successGradient : AppColors.errorGradient,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(_passed ? '🎉 Passed!' : '📚 Keep Practicing', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
                      const SizedBox(height: 6),
                      Text(
                        _passed ? 'Excellent! You scored above the pass mark.' : 'You need ${AppConstants.minPassScore} to pass. Don\'t give up!',
                        style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),

                const SizedBox(height: 24),

                // Score circle
                CircularPercentIndicator(
                  radius: 80,
                  lineWidth: 10,
                  percent: _pct,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('$_score', style: TextStyle(fontSize: 36, fontWeight: FontWeight.w800, color: _passed ? AppColors.success : AppColors.error)),
                      Text('/ ${_answers.length}', style: TextStyle(fontSize: 14, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
                    ],
                  ),
                  progressColor: _passed ? AppColors.success : AppColors.error,
                  backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
                  circularStrokeCap: CircularStrokeCap.round,
                  animation: true,
                  animationDuration: 1500,
                ).animate(delay: 200.ms).scale(duration: 500.ms),

                const SizedBox(height: 24),

                // Stats row
                Row(
                  children: [
                    Expanded(child: _StatCard('✅', 'Correct', '$_score', AppColors.success)),
                    const SizedBox(width: 8),
                    Expanded(child: _StatCard('❌', 'Wrong', '${_answers.length - _score}', AppColors.error)),
                    const SizedBox(width: 8),
                    Expanded(child: _StatCard('⏱️', 'Time', _formatTime(_timeTaken), AppColors.secondary)),
                    const SizedBox(width: 8),
                    Expanded(child: _StatCard('📊', 'Accuracy', '${(_pct * 100).toInt()}%', AppColors.primary)),
                  ],
                ).animate(delay: 300.ms).fadeIn(duration: 500.ms),

                const SizedBox(height: 24),

                // Chapter breakdown
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Performance by Topic', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                ),
                const SizedBox(height: 12),
                ...chapterResults.entries.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _ChapterBar(result: e.value, isDark: isDark),
                )).toList(),

                const SizedBox(height: 24),

                // Actions
                AppButton(
                  label: 'Retake Exam',
                  onPressed: () { context.pop(); context.push(AppRoutes.mockExam); },
                  icon: Icons.refresh_rounded,
                ).animate(delay: 500.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Study Weak Areas with AI',
                  onPressed: () => context.go(AppRoutes.aiTutor),
                  isOutlined: true,
                  icon: Icons.auto_awesome_rounded,
                ).animate(delay: 600.ms).fadeIn(duration: 400.ms),
                const SizedBox(height: 12),
                AppButton(
                  label: 'Review Mistakes',
                  onPressed: () => context.push(AppRoutes.mistakeNotebook),
                  isOutlined: true,
                  icon: Icons.book_outlined,
                ).animate(delay: 700.ms).fadeIn(duration: 400.ms),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirectionality: BlastDirectionality.explosive,
            colors: const [AppColors.success, AppColors.primary, AppColors.accent],
            numberOfParticles: 60,
            gravity: 0.2,
          ),
        ),
      ],
    );
  }
}

class _ChapterResult {
  final String name;
  int total = 0;
  int correct = 0;
  _ChapterResult(this.name);
  double get pct => total > 0 ? correct / total : 0;
}

class _StatCard extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  final Color color;
  const _StatCard(this.icon, this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: color)),
          Text(label, style: TextStyle(fontSize: 10, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
        ],
      ),
    );
  }
}

class _ChapterBar extends StatelessWidget {
  final _ChapterResult result;
  final bool isDark;
  const _ChapterBar({required this.result, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final color = result.pct >= 0.8 ? AppColors.success : result.pct >= 0.5 ? AppColors.warning : AppColors.error;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(result.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
              Text('${result.correct}/${result.total}',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: result.pct,
              backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
