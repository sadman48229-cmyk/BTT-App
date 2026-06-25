import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_routes.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/question_model.dart';
import '../../../../shared/widgets/app_button.dart';

class MistakeNotebookPage extends ConsumerStatefulWidget {
  const MistakeNotebookPage({super.key});

  @override
  ConsumerState<MistakeNotebookPage> createState() => _MistakeNotebookPageState();
}

class _MistakeNotebookPageState extends ConsumerState<MistakeNotebookPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<QuestionModel> _mistakes = [];
  List<QuestionModel> _bookmarks = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadData() {
    final mistakeData = LocalStorageService.getAllMistakes();
    final bookmarkData = LocalStorageService.getAllBookmarks();

    setState(() {
      _mistakes = mistakeData.map((d) {
        try { return QuestionModel.fromMap(Map<String, dynamic>.from(d as Map)); }
        catch (_) { return null; }
      }).whereType<QuestionModel>().toList();

      _bookmarks = bookmarkData.map((d) {
        try { return QuestionModel.fromMap(Map<String, dynamic>.from(d as Map)); }
        catch (_) { return null; }
      }).whereType<QuestionModel>().toList();
    });
  }

  void _removeMistake(String id) async {
    await LocalStorageService.removeMistake(id);
    _loadData();
  }

  void _toggleBookmark(QuestionModel q) async {
    await LocalStorageService.toggleBookmark(q.id, q.toMap());
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mistake Notebook', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Mistakes (${_mistakes.length})'),
            Tab(text: 'Bookmarks (${_bookmarks.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _QuestionList(
            questions: _mistakes,
            emptyIcon: '✅',
            emptyTitle: 'No mistakes yet!',
            emptySubtitle: 'Keep practicing and your mistakes will appear here so you can review them.',
            onAction: (q) => _removeMistake(q.id),
            actionLabel: 'Remove',
            actionColor: AppColors.error,
            isBookmarkList: false,
            onBookmark: _toggleBookmark,
            bookmarkedIds: _bookmarks.map((b) => b.id).toSet(),
          ),
          _QuestionList(
            questions: _bookmarks,
            emptyIcon: '🔖',
            emptyTitle: 'No bookmarks yet',
            emptySubtitle: 'Bookmark questions while practicing to save them for later review.',
            onAction: (q) => _toggleBookmark(q),
            actionLabel: 'Remove',
            actionColor: AppColors.error,
            isBookmarkList: true,
            onBookmark: _toggleBookmark,
            bookmarkedIds: _bookmarks.map((b) => b.id).toSet(),
          ),
        ],
      ),
      floatingActionButton: (_mistakes.isNotEmpty || _bookmarks.isNotEmpty)
          ? FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.quiz, extra: {
                'questionCount': (_mistakes.length + _bookmarks.length).clamp(5, 20),
              }),
              backgroundColor: AppColors.primary,
              label: const Text('Practice Mistakes', style: TextStyle(fontWeight: FontWeight.w700)),
              icon: const Icon(Icons.quiz_rounded),
            )
          : null,
    );
  }
}

class _QuestionList extends StatelessWidget {
  final List<QuestionModel> questions;
  final String emptyIcon;
  final String emptyTitle;
  final String emptySubtitle;
  final void Function(QuestionModel) onAction;
  final String actionLabel;
  final Color actionColor;
  final bool isBookmarkList;
  final void Function(QuestionModel) onBookmark;
  final Set<String> bookmarkedIds;

  const _QuestionList({
    required this.questions,
    required this.emptyIcon,
    required this.emptyTitle,
    required this.emptySubtitle,
    required this.onAction,
    required this.actionLabel,
    required this.actionColor,
    required this.isBookmarkList,
    required this.onBookmark,
    required this.bookmarkedIds,
  });

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emptyIcon, style: const TextStyle(fontSize: 64))
                .animate().scale(duration: 600.ms, curve: Curves.elasticOut),
            const SizedBox(height: 16),
            Text(emptyTitle, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800))
                .animate(delay: 100.ms).fadeIn(duration: 400.ms),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(emptySubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.darkTextSecondary))
                  .animate(delay: 200.ms).fadeIn(duration: 400.ms),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: questions.length,
      itemBuilder: (context, i) {
        final q = questions[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _MistakeCard(
            question: q,
            onRemove: () => onAction(q),
            onBookmark: () => onBookmark(q),
            isBookmarked: bookmarkedIds.contains(q.id),
          ).animate(delay: Duration(milliseconds: i * 50))
           .fadeIn(duration: 400.ms)
           .slideX(begin: -0.2, end: 0),
        );
      },
    );
  }
}

class _MistakeCard extends StatelessWidget {
  final QuestionModel question;
  final VoidCallback onRemove;
  final VoidCallback onBookmark;
  final bool isBookmarked;

  const _MistakeCard({
    required this.question,
    required this.onRemove,
    required this.onBookmark,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(question.chapterName,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)),
              ),
              const Spacer(),
              GestureDetector(
                onTap: onBookmark,
                child: Icon(
                  isBookmarked ? Icons.bookmark_rounded : Icons.bookmark_outline_rounded,
                  size: 20,
                  color: isBookmarked ? AppColors.accent : AppColors.darkTextTertiary,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: onRemove,
                child: const Icon(Icons.close_rounded, size: 20, color: AppColors.error),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(question.question,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.5)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.success.withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.success.withOpacity(0.2)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.check_circle_rounded, size: 14, color: AppColors.success),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Correct: ${question.correctOption}',
                    style: const TextStyle(fontSize: 13, color: AppColors.success, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(question.explanation,
              style: TextStyle(fontSize: 12, height: 1.5,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
        ],
      ),
    );
  }
}
