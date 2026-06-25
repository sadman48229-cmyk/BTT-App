import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/chapter_model.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/widgets/app_button.dart';
import '../providers/home_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final homeData = ref.watch(homeDataProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            snap: true,
            backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
            surfaceTintColor: Colors.transparent,
            title: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(child: Text('🚦', style: TextStyle(fontSize: 18))),
                ),
                const SizedBox(width: 10),
                const Text('BTT Genius AI', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () => context.push(AppRoutes.search),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting + Streak
                  userAsync.when(
                    data: (user) => _GreetingCard(
                      name: user?.displayName ?? 'Learner',
                      streak: LocalStorageService.getStudyStreak(),
                      level: user?.levelDisplay ?? 'Beginner',
                    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
                    loading: () => const SizedBox(height: 80),
                    error: (e, _) => const SizedBox(height: 80),
                  ),

                  const SizedBox(height: 20),

                  // Daily Goal Card
                  _DailyGoalCard(progress: homeData.dailyProgress)
                      .animate(delay: 100.ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 24),

                  // Quick Actions
                  _QuickActionsRow()
                      .animate(delay: 200.ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 24),

                  // Today's Challenge Banner
                  _DailyChallengeBanner()
                      .animate(delay: 300.ms)
                      .fadeIn(duration: 500.ms)
                      .slideX(begin: 0.2, end: 0),

                  const SizedBox(height: 24),

                  // Continue Learning
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Continue Learning', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      TextButton(
                        onPressed: () => context.go(AppRoutes.learning),
                        child: const Text('See All'),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  ...defaultChapters.take(3).toList().asMap().entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _ChapterCard(chapter: entry.value)
                          .animate(delay: Duration(milliseconds: 400 + entry.key * 100))
                          .fadeIn(duration: 500.ms)
                          .slideX(begin: -0.2, end: 0),
                    );
                  }),

                  const SizedBox(height: 16),

                  // AI Tutor Banner
                  _AiTutorBanner()
                      .animate(delay: 700.ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 24),

                  // Mock Exam CTA
                  _MockExamCard()
                      .animate(delay: 800.ms)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: 0.2, end: 0),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GreetingCard extends StatelessWidget {
  final String name;
  final int streak;
  final String level;

  const _GreetingCard({required this.name, required this.streak, required this.level});

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$_greeting! 👋',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.darkTextSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  level,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (streak > 0)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text('🔥', style: TextStyle(fontSize: 28)),
                const SizedBox(height: 4),
                Text(
                  '$streak',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.accent,
                  ),
                ),
                Text(
                  'day streak',
                  style: TextStyle(fontSize: 11, color: AppColors.darkTextSecondary),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _DailyGoalCard extends StatelessWidget {
  final double progress;

  const _DailyGoalCard({required this.progress});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CircularPercentIndicator(
            radius: 36,
            lineWidth: 6,
            percent: progress.clamp(0.0, 1.0),
            center: Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
            ),
            progressColor: AppColors.primary,
            backgroundColor: AppColors.darkElevated,
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
            animationDuration: 1000,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Goal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  progress >= 1.0
                      ? '✅ Goal completed! Great work!'
                      : 'Study 30 minutes today to reach your goal',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    progress >= 1.0 ? AppColors.success : AppColors.primary,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    final actions = [
      _QuickAction(icon: '📝', label: 'Practice\nQuiz', route: AppRoutes.quiz, color: AppColors.primary),
      _QuickAction(icon: '📋', label: 'Mock\nExam', route: AppRoutes.mockExam, color: AppColors.secondary),
      _QuickAction(icon: '❌', label: 'My\nMistakes', route: AppRoutes.mistakeNotebook, color: AppColors.error),
      _QuickAction(icon: '📖', label: 'Glossary', route: AppRoutes.glossary, color: AppColors.accent),
    ];

    return Row(
      children: actions.map((a) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: _QuickActionCard(action: a),
        ),
      )).toList(),
    );
  }
}

class _QuickAction {
  final String icon;
  final String label;
  final String route;
  final Color color;

  const _QuickAction({required this.icon, required this.label, required this.route, required this.color});
}

class _QuickActionCard extends StatelessWidget {
  final _QuickAction action;

  const _QuickActionCard({required this.action});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => context.push(action.route),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: action.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: action.color.withOpacity(0.2), width: 1),
        ),
        child: Column(
          children: [
            Text(action.icon, style: const TextStyle(fontSize: 26)),
            const SizedBox(height: 8),
            Text(
              action.label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: action.color,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyChallengeBanner extends StatelessWidget {
  const _DailyChallengeBanner();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.dailyChallenge),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF7C3AED), Color(0xFF2563EB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'TODAY\'S CHALLENGE',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '10 New Questions\nWaiting for You!',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white, height: 1.3),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Start Challenge →',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            const Text('🎯', style: TextStyle(fontSize: 60)),
          ],
        ),
      ),
    );
  }
}

class _ChapterCard extends StatelessWidget {
  final ChapterModel chapter;

  const _ChapterCard({required this.chapter});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => context.push('/learning/chapter/${chapter.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: chapter.chapterColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(child: Text(chapter.emoji, style: const TextStyle(fontSize: 26))),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chapter.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  Text(
                    '${chapter.totalLessons} lessons • ${chapter.totalQuestions} questions',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: chapter.progressPercentage,
                    backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
                    valueColor: AlwaysStoppedAnimation<Color>(chapter.chapterColor),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
            ),
          ],
        ),
      ),
    );
  }
}

class _AiTutorBanner extends StatelessWidget {
  const _AiTutorBanner();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(AppRoutes.aiTutor),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: AppColors.aiGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Text('🤖', style: TextStyle(fontSize: 40)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Ask Your AI Tutor',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Explain road signs • Quiz me • Analyze mistakes',
                    style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.85), height: 1.4),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

class _MockExamCard extends StatelessWidget {
  const _MockExamCard();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Text('📋', style: TextStyle(fontSize: 40)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Full Mock Exam',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  '50 questions • 50 minutes • Real exam format',
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          AppSmallButton(
            label: 'Start',
            onPressed: () => context.push(AppRoutes.mockExam),
          ),
        ],
      ),
    );
  }
}
