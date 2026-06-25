import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/achievement_model.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final achievements = allAchievements;
    final unlocked = achievements.where((a) => a.isUnlocked).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppColors.accentGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Text('🏆', style: TextStyle(fontSize: 48)),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Your Trophies', style: TextStyle(fontSize: 14, color: Colors.white70)),
                              Text('$unlocked / ${achievements.length}',
                                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: achievements.isNotEmpty ? unlocked / achievements.length : 0,
                                  backgroundColor: Colors.white.withOpacity(0.3),
                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                  minHeight: 6,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
                  const SizedBox(height: 20),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('All Badges', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final a = achievements[i];
                  return _AchievementCard(achievement: a, isDark: isDark)
                      .animate(delay: Duration(milliseconds: i * 40))
                      .fadeIn(duration: 300.ms)
                      .scale(begin: const Offset(0.8, 0.8));
                },
                childCount: achievements.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final AchievementModel achievement;
  final bool isDark;
  const _AchievementCard({required this.achievement, required this.isDark});

  Color get _tierColor => switch (achievement.tier) {
    AchievementTier.bronze => AppColors.bronzeAchievement,
    AchievementTier.silver => AppColors.silverAchievement,
    AchievementTier.gold => AppColors.goldAchievement,
    AchievementTier.platinum => AppColors.primary,
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showDetail(context),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: achievement.isUnlocked
              ? _tierColor.withOpacity(0.08)
              : (isDark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: achievement.isUnlocked ? _tierColor.withOpacity(0.4) : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: achievement.isUnlocked ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  achievement.isUnlocked ? achievement.emoji : '🔒',
                  style: const TextStyle(fontSize: 34),
                ),
                if (!achievement.isUnlocked)
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(
                      color: (isDark ? AppColors.darkBackground : AppColors.lightBackground).withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              achievement.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 1.3,
                color: achievement.isUnlocked ? _tierColor : (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
              ),
            ),
            if (achievement.isUnlocked) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: _tierColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '+${achievement.xpReward} XP',
                  style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: _tierColor),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(achievement.isUnlocked ? achievement.emoji : '🔒', style: const TextStyle(fontSize: 56)),
            const SizedBox(height: 12),
            Text(achievement.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(achievement.description,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.darkTextSecondary)),
            const SizedBox(height: 8),
            Text('Condition: ${achievement.condition}',
                style: const TextStyle(fontSize: 13, color: AppColors.darkTextTertiary)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _tierColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(achievement.tier.name.toUpperCase(),
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _tierColor)),
                  const SizedBox(width: 8),
                  Text('+${achievement.xpReward} XP',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: _tierColor)),
                ],
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
