import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/achievement_model.dart';
import '../../../../shared/models/chapter_model.dart';
import '../../../../shared/providers/auth_provider.dart';

class ProgressPage extends ConsumerWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final streak = LocalStorageService.getStudyStreak();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events_rounded),
            onPressed: () => context.push(AppRoutes.achievements),
            tooltip: 'Achievements',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall stats
            userAsync.when(
              data: (user) => _OverallStats(
                streak: streak,
                totalAnswered: user?.totalQuestionsAnswered ?? 0,
                accuracy: user?.accuracy ?? 0.0,
                studyMinutes: user?.totalStudyMinutes ?? 0,
                level: user?.levelDisplay ?? 'Beginner',
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
              loading: () => const SizedBox(height: 160, child: Center(child: CircularProgressIndicator())),
              error: (_, __) => const SizedBox.shrink(),
            ),

            const SizedBox(height: 24),

            // Streak heatmap
            _StreakSection(streak: streak)
                .animate(delay: 100.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 24),

            // Chapter progress
            const Text('Chapter Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))
                .animate(delay: 200.ms).fadeIn(duration: 400.ms),
            const SizedBox(height: 12),
            ...defaultChapters.asMap().entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _ChapterProgressTile(chapter: e.value)
                  .animate(delay: Duration(milliseconds: 200 + e.key * 50))
                  .fadeIn(duration: 400.ms).slideX(begin: -0.2, end: 0),
            )),

            const SizedBox(height: 24),

            // Recent achievements
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Achievements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                TextButton(onPressed: () => context.push(AppRoutes.achievements), child: const Text('See All')),
              ],
            ).animate(delay: 600.ms).fadeIn(duration: 400.ms),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: allAchievements.take(6).length,
                itemBuilder: (context, i) {
                  final a = allAchievements[i];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: _AchievementChip(achievement: a)
                        .animate(delay: Duration(milliseconds: 700 + i * 60))
                        .fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8)),
                  );
                },
              ),
            ),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _OverallStats extends StatelessWidget {
  final int streak;
  final int totalAnswered;
  final double accuracy;
  final int studyMinutes;
  final String level;

  const _OverallStats({
    required this.streak,
    required this.totalAnswered,
    required this.accuracy,
    required this.studyMinutes,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircularPercentIndicator(
                radius: 50,
                lineWidth: 7,
                percent: (accuracy / 100).clamp(0.0, 1.0),
                center: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${accuracy.toInt()}%',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.white)),
                    const Text('accuracy', style: TextStyle(fontSize: 9, color: Colors.white70)),
                  ],
                ),
                progressColor: Colors.white,
                backgroundColor: Colors.white.withOpacity(0.3),
                circularStrokeCap: CircularStrokeCap.round,
                animation: true,
                animationDuration: 1200,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(level, style: const TextStyle(fontSize: 13, color: Colors.white70)),
                    const SizedBox(height: 4),
                    const Text('Learning Journey', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _MiniStat(icon: '🔥', value: '$streak', label: 'streak'),
                        const SizedBox(width: 16),
                        _MiniStat(icon: '📝', value: '$totalAnswered', label: 'answered'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _StatBubble(icon: '⏱️', value: '${studyMinutes}m', label: 'Total Study Time')),
              const SizedBox(width: 12),
              Expanded(child: _StatBubble(icon: '📚', value: '0/9', label: 'Chapters Done')),
              const SizedBox(width: 12),
              Expanded(child: _StatBubble(icon: '🏆', value: '0', label: 'Achievements')),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  const _MiniStat({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(icon, style: const TextStyle(fontSize: 14)),
      const SizedBox(width: 4),
      Text('$value $label', style: const TextStyle(fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500)),
    ],
  );
}

class _StatBubble extends StatelessWidget {
  final String icon;
  final String value;
  final String label;
  const _StatBubble({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.15),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
        Text(label, style: const TextStyle(fontSize: 9, color: Colors.white70), textAlign: TextAlign.center),
      ],
    ),
  );
}

class _StreakSection extends StatelessWidget {
  final int streak;
  const _StreakSection({required this.streak});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Study Streak', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              Row(
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 20)),
                  const SizedBox(width: 4),
                  Text('$streak days',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.accent)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // 7-day mini grid
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(7, (i) {
              final label = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i];
              final active = i < (streak % 7);
              return Column(
                children: [
                  Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(
                      color: active ? AppColors.accent.withOpacity(0.2) : (isDark ? AppColors.darkElevated : AppColors.lightElevated),
                      borderRadius: BorderRadius.circular(10),
                      border: active ? Border.all(color: AppColors.accent, width: 1.5) : null,
                    ),
                    child: Center(
                      child: active ? const Text('🔥', style: TextStyle(fontSize: 16)) : const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(label, style: TextStyle(fontSize: 10, color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary)),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _ChapterProgressTile extends StatelessWidget {
  final ChapterModel chapter;
  const _ChapterProgressTile({required this.chapter});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Row(
        children: [
          Text(chapter.emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(chapter.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    Text('${(chapter.progressPercentage * 100).toInt()}%',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: chapter.chapterColor)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: chapter.progressPercentage,
                    backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
                    valueColor: AlwaysStoppedAnimation<Color>(chapter.chapterColor),
                    minHeight: 5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementChip extends StatelessWidget {
  final AchievementModel achievement;
  const _AchievementChip({required this.achievement});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = switch (achievement.tier) {
      AchievementTier.bronze => AppColors.bronzeAchievement,
      AchievementTier.silver => AppColors.silverAchievement,
      AchievementTier.gold => AppColors.goldAchievement,
      AchievementTier.platinum => AppColors.primary,
    };
    return Container(
      width: 90,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: achievement.isUnlocked ? color.withOpacity(0.1) : (isDark ? AppColors.darkCard : AppColors.lightCard),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: achievement.isUnlocked ? color.withOpacity(0.3) : (isDark ? AppColors.darkBorder : AppColors.lightBorder)),
      ),
      child: Column(
        children: [
          Text(achievement.isUnlocked ? achievement.emoji : '🔒', style: const TextStyle(fontSize: 26)),
          const SizedBox(height: 6),
          Text(
            achievement.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9,
              fontWeight: FontWeight.w600,
              color: achievement.isUnlocked ? color : (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
              height: 1.3,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
