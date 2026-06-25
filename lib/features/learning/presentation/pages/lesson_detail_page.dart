import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/services/openai_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/chapter_model.dart';
import '../../../../shared/widgets/app_button.dart';

class LessonDetailPage extends ConsumerStatefulWidget {
  final String chapterId;
  final String lessonId;

  const LessonDetailPage({super.key, required this.chapterId, required this.lessonId});

  @override
  ConsumerState<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends ConsumerState<LessonDetailPage> {
  String? _aiContent;
  bool _loadingAi = false;

  late ChapterModel _chapter;
  late LessonModel _lesson;

  @override
  void initState() {
    super.initState();
    _chapter = defaultChapters.firstWhere((c) => c.id == widget.chapterId, orElse: () => defaultChapters.first);
    _lesson = LessonModel(
      id: widget.lessonId,
      chapterId: widget.chapterId,
      title: widget.lessonId.contains('lesson_') ? _getLessonTitle() : 'Lesson',
      type: 'theory',
      content: _getSampleContent(),
      order: 0,
      estimatedMinutes: 8,
    );
    _loadContent();
  }

  String _getLessonTitle() {
    final idx = int.tryParse(widget.lessonId.split('_').last) ?? 0;
    final titles = ['Theory', 'Visual Guide', 'Memory Hacks', 'Exam Traps', 'Practice', 'Quick Review'];
    return idx < titles.length ? titles[idx] : 'Lesson ${idx + 1}';
  }

  String _getSampleContent() {
    return '''
## ${_chapter.title} — ${_getLessonTitle()}

Welcome to this lesson on **${_chapter.title}**. This section covers essential concepts you need to know for your Singapore BTT exam.

### Key Points

1. **Understanding the Basics** — Every driver in Singapore must know these rules thoroughly before taking the test.

2. **Singapore Road Rules** — All rules are based on the Singapore Highway Code. Always follow posted signs and markings.

3. **Common Exam Questions** — Pay attention to the highlighted sections — these topics appear frequently in the BTT exam.

### What You Will Learn

- The core principles of ${_chapter.title.toLowerCase()}
- How to identify and respond to relevant road situations
- Common mistakes and how to avoid them
- Quick-recall tips for the exam

> 💡 **Memory Tip:** Connect each rule to a real-world scenario you can visualize. This makes rules easier to remember under exam pressure.

### Practice Tip

After reading this lesson, use the **Practice Quiz** to test your understanding. Focus on questions you get wrong — those are your learning opportunities!

---

*Tap the "Ask AI" button below to get a deeper explanation of any concept in this lesson.*
''';
  }

  Future<void> _loadContent() async {
    if (_aiContent != null) return;
    setState(() => _loadingAi = true);
    try {
      final service = ref.read(openAiServiceProvider);
      final summary = await service.generateChapterSummary(_chapter.title);
      if (mounted) setState(() { _aiContent = summary; _loadingAi = false; });
    } catch (_) {
      if (mounted) setState(() => _loadingAi = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_lesson.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
            onPressed: () => context.go(AppRoutes.aiTutor),
            tooltip: 'Ask AI Tutor',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Chapter badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _chapter.chapterColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(_chapter.emoji, style: const TextStyle(fontSize: 14)),
                  const SizedBox(width: 6),
                  Text(
                    _chapter.title,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _chapter.chapterColor),
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 400.ms),

            const SizedBox(height: 16),

            // Static content
            MarkdownBody(
              data: _lesson.content,
              styleSheet: MarkdownStyleSheet(
                h2: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary, height: 1.3),
                h3: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary, height: 1.4),
                p: TextStyle(fontSize: 15, height: 1.7, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                listBullet: TextStyle(fontSize: 15, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                strong: TextStyle(fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                blockquoteDecoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  border: const Border(left: BorderSide(color: AppColors.primary, width: 3)),
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                ),
                blockquote: TextStyle(fontSize: 14, height: 1.6, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
              ),
            ).animate(delay: 100.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 24),

            // AI-generated detailed explanation
            if (_loadingAi) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary)),
                    const SizedBox(width: 12),
                    Text('AI is generating lesson content...', style: TextStyle(fontSize: 13, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
                  ],
                ),
              ),
            ] else if (_aiContent != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary.withOpacity(0.05), AppColors.secondary.withOpacity(0.05)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            gradient: AppColors.aiGradient,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('🤖', style: TextStyle(fontSize: 12)),
                              SizedBox(width: 4),
                              Text('AI Summary', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    MarkdownBody(
                      data: _aiContent!,
                      styleSheet: MarkdownStyleSheet(
                        p: TextStyle(fontSize: 14, height: 1.6, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                        strong: TextStyle(fontWeight: FontWeight.w700, color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                        listBullet: TextStyle(fontSize: 14, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                      ),
                    ),
                  ],
                ),
              ).animate(delay: 200.ms).fadeIn(duration: 500.ms),
            ],

            const SizedBox(height: 32),

            // Practice button
            AppButton(
              label: 'Practice This Chapter',
              onPressed: () => context.push(AppRoutes.quiz, extra: {'chapterId': _chapter.id, 'questionCount': 10}),
              icon: Icons.quiz_rounded,
            ).animate(delay: 300.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 12),

            AppButton(
              label: 'Ask AI Tutor About This Lesson',
              onPressed: () => context.go(AppRoutes.aiTutor),
              isOutlined: true,
              icon: Icons.auto_awesome_rounded,
            ).animate(delay: 400.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
