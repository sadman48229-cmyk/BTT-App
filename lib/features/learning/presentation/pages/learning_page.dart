import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/chapter_model.dart';
import '../../../../shared/providers/auth_provider.dart';

class LearningPage extends ConsumerWidget {
  const LearningPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(currentUserProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chapters = defaultChapters;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Path', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress overview
                  userAsync.when(
                    data: (user) => _LearningOverview(user: user),
                    loading: () => const SizedBox(height: 80),
                    error: (_, __) => const SizedBox(height: 80),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'All Chapters',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ).animate().fadeIn(duration: 400.ms),
                  const SizedBox(height: 4),
                  Text(
                    '9 chapters • 395+ questions',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ).animate(delay: 100.ms).fadeIn(duration: 400.ms),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _ChapterTile(
                    chapter: chapters[index],
                    index: index,
                  ).animate(delay: Duration(milliseconds: 100 + index * 60))
                   .fadeIn(duration: 400.ms)
                   .slideX(begin: -0.2, end: 0),
                ),
                childCount: chapters.length,
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}

class _LearningOverview extends StatelessWidget {
  final dynamic user;

  const _LearningOverview({this.user});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Progress',
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
                const SizedBox(height: 4),
                const Text(
                  '0 of 9 chapters',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.0,
                    backgroundColor: Colors.white.withOpacity(0.3),
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Text('📚', style: TextStyle(fontSize: 48)),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0);
  }
}

class _ChapterTile extends StatelessWidget {
  final ChapterModel chapter;
  final int index;

  const _ChapterTile({required this.chapter, required this.index});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLocked = chapter.isLocked;

    return GestureDetector(
      onTap: isLocked
          ? () => _showLockedDialog(context, chapter)
          : () => context.push('/learning/chapter/${chapter.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isLocked
                ? (isDark ? AppColors.darkBorder : AppColors.lightBorder).withOpacity(0.5)
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Chapter icon
            Stack(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: isLocked
                        ? (isDark ? AppColors.darkElevated : AppColors.lightElevated)
                        : chapter.chapterColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      chapter.emoji,
                      style: TextStyle(
                        fontSize: 28,
                        color: isLocked ? null : null,
                      ),
                    ),
                  ),
                ),
                if (isLocked)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkElevated : AppColors.lightElevated,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                          width: 2,
                        ),
                      ),
                      child: const Icon(Icons.lock_rounded, size: 12, color: AppColors.darkTextTertiary),
                    ),
                  ),
                if (chapter.isPremium && !isLocked)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text('PRO', style: TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white)),
                    ),
                  ),
              ],
            ),

            const SizedBox(width: 14),

            // Chapter info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chapter.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isLocked
                                ? (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary)
                                : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${chapter.totalLessons} lessons • ${chapter.totalQuestions} questions',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: chapter.progressPercentage,
                            backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              isLocked ? AppColors.darkTextTertiary : chapter.chapterColor,
                            ),
                            minHeight: 5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${(chapter.progressPercentage * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),
            Icon(
              isLocked ? Icons.lock_rounded : Icons.arrow_forward_ios_rounded,
              size: 16,
              color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
            ),
          ],
        ),
      ),
    );
  }

  void _showLockedDialog(BuildContext context, ChapterModel chapter) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🔒', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 16),
            Text(
              '${chapter.title} is Premium',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Upgrade to BTT Genius AI Premium to unlock all 9 chapters, unlimited AI tutor, and more!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.darkTextSecondary),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                // Navigate to subscription
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                minimumSize: const Size(double.infinity, 54),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Upgrade to Premium', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Not Now'),
            ),
          ],
        ),
      ),
    );
  }
}
