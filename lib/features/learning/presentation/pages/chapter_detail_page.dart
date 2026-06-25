import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/chapter_model.dart';
import '../../../../shared/widgets/app_button.dart';

class ChapterDetailPage extends ConsumerWidget {
  final String chapterId;

  const ChapterDetailPage({super.key, required this.chapterId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chapter = defaultChapters.firstWhere(
      (c) => c.id == chapterId,
      orElse: () => defaultChapters.first,
    );

    final lessons = _getLessons(chapter);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Hero app bar
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.arrow_back_ios_new_rounded, size: 16, color: Colors.white),
              ),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      chapter.chapterColor,
                      chapter.chapterColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(chapter.emoji, style: const TextStyle(fontSize: 48)),
                        const SizedBox(height: 8),
                        Text(
                          chapter.title,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          chapter.description,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.85),
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats row
                  Row(
                    children: [
                      Expanded(child: _StatBadge(icon: '📚', label: 'Lessons', value: '${lessons.length}')),
                      const SizedBox(width: 12),
                      Expanded(child: _StatBadge(icon: '❓', label: 'Questions', value: '${chapter.totalQuestions}')),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CircularPercentIndicator(
                          radius: 28,
                          lineWidth: 4,
                          percent: chapter.progressPercentage,
                          center: Text(
                            '${(chapter.progressPercentage * 100).toInt()}%',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700),
                          ),
                          progressColor: chapter.chapterColor,
                          backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
                          circularStrokeCap: CircularStrokeCap.round,
                          animation: true,
                          animationDuration: 1000,
                        ),
                      ),
                    ],
                  ).animate().fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  // Quick actions
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: 'Practice Quiz',
                          onPressed: () => context.push(AppRoutes.quiz, extra: {
                            'chapterId': chapter.id,
                            'questionCount': 10,
                          }),
                          icon: Icons.quiz_rounded,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AppButton(
                          label: 'Ask AI',
                          onPressed: () => context.go(AppRoutes.aiTutor),
                          isOutlined: true,
                          icon: Icons.auto_awesome_rounded,
                        ),
                      ),
                    ],
                  ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  const Text(
                    'Lessons',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final lesson = lessons[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _LessonTile(
                      lesson: lesson,
                      index: index,
                      chapterId: chapterId,
                      color: chapter.chapterColor,
                    ).animate(delay: Duration(milliseconds: 200 + index * 60))
                     .fadeIn(duration: 400.ms)
                     .slideX(begin: -0.2, end: 0),
                  );
                },
                childCount: lessons.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  List<LessonModel> _getLessons(ChapterModel chapter) {
    final types = ['Theory', 'Road Signs Guide', 'Memory Hacks', 'Exam Traps', 'Practice Questions', 'Quick Review'];
    return List.generate(
      chapter.totalLessons.clamp(4, 8),
      (i) => LessonModel(
        id: '${chapter.id}_lesson_$i',
        chapterId: chapter.id,
        title: i < types.length ? '${types[i]}' : 'Lesson ${i + 1}',
        type: i == 0 ? 'theory' : i == 2 ? 'memory_hack' : i == 3 ? 'exam_trap' : i == 4 ? 'quiz' : 'review',
        content: '',
        order: i,
        estimatedMinutes: [8, 6, 5, 5, 10, 4, 6, 5][i % 8],
        isCompleted: false,
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const _StatBadge({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          Text(label, style: TextStyle(fontSize: 11, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
        ],
      ),
    );
  }
}

class _LessonTile extends StatelessWidget {
  final LessonModel lesson;
  final int index;
  final String chapterId;
  final Color color;

  const _LessonTile({
    required this.lesson,
    required this.index,
    required this.chapterId,
    required this.color,
  });

  IconData get _typeIcon {
    return switch (lesson.type) {
      'theory' => Icons.menu_book_rounded,
      'memory_hack' => Icons.lightbulb_rounded,
      'exam_trap' => Icons.warning_amber_rounded,
      'quiz' => Icons.quiz_rounded,
      'review' => Icons.checklist_rounded,
      _ => Icons.article_rounded,
    };
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.push('/learning/chapter/$chapterId/lesson/${lesson.id}'),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: lesson.isCompleted ? AppColors.success.withOpacity(0.1) : color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                lesson.isCompleted ? Icons.check_circle_rounded : _typeIcon,
                color: lesson.isCompleted ? AppColors.success : color,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(lesson.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, size: 12, color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
                      const SizedBox(width: 4),
                      Text(
                        '${lesson.estimatedMinutes} min',
                        style: TextStyle(fontSize: 12, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(lesson.type.replaceAll('_', ' ').toUpperCase(), style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: color)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 14, color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
          ],
        ),
      ),
    );
  }
}
