import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/data/sample_questions.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/chapter_model.dart';
import '../../../../shared/models/question_model.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  String _query = '';
  String _filter = 'all'; // all, chapters, questions

  List<ChapterModel> get _chapterResults {
    if (_query.isEmpty) return [];
    return defaultChapters
        .where((c) => c.title.toLowerCase().contains(_query.toLowerCase()) ||
            c.description.toLowerCase().contains(_query.toLowerCase()))
        .toList();
  }

  List<QuestionModel> get _questionResults {
    if (_query.isEmpty) return [];
    return SampleQuestions.all
        .where((q) =>
            q.question.toLowerCase().contains(_query.toLowerCase()) ||
            q.tags.any((t) => t.toLowerCase().contains(_query.toLowerCase())))
        .take(20)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _focus.requestFocus());
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final chapters = _filter != 'questions' ? _chapterResults : <ChapterModel>[];
    final questions = _filter != 'chapters' ? _questionResults : <QuestionModel>[];

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          focusNode: _focus,
          onChanged: (v) => setState(() => _query = v),
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Search chapters, rules, signs...',
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintStyle: TextStyle(color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
            contentPadding: EdgeInsets.zero,
            isDense: true,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (_query.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.close_rounded),
              onPressed: () { _controller.clear(); setState(() => _query = ''); },
            ),
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          if (_query.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  _FilterChip(label: 'All', value: 'all', selected: _filter == 'all', onTap: () => setState(() => _filter = 'all')),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Chapters', value: 'chapters', selected: _filter == 'chapters', onTap: () => setState(() => _filter = 'chapters')),
                  const SizedBox(width: 8),
                  _FilterChip(label: 'Questions', value: 'questions', selected: _filter == 'questions', onTap: () => setState(() => _filter = 'questions')),
                ],
              ),
            ),

          // Results
          Expanded(
            child: _query.isEmpty
                ? _EmptySearchView()
                : (chapters.isEmpty && questions.isEmpty)
                    ? _NoResultsView(query: _query)
                    : ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          if (chapters.isNotEmpty) ...[
                            const Text('Chapters', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 8),
                            ...chapters.map((c) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _ChapterResult(chapter: c),
                            )),
                            const SizedBox(height: 16),
                          ],
                          if (questions.isNotEmpty) ...[
                            Text('Questions (${questions.length})', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 8),
                            ...questions.asMap().entries.map((e) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: _QuestionResult(question: e.value)
                                  .animate(delay: Duration(milliseconds: e.key * 30))
                                  .fadeIn(duration: 300.ms),
                            )),
                          ],
                        ],
                      ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({required this.label, required this.value, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : AppColors.primary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? AppColors.primary : AppColors.primary.withOpacity(0.3)),
        ),
        child: Text(label,
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: selected ? Colors.white : AppColors.primary)),
      ),
    );
  }
}

class _EmptySearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final suggestions = ['Road Signs', 'Speed Limit', 'Parking Rules', 'Right of Way', 'Expressway'];
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Popular Searches', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: suggestions.map((s) => ActionChip(
              label: Text(s),
              onPressed: () {},
              backgroundColor: AppColors.primary.withOpacity(0.08),
              side: BorderSide(color: AppColors.primary.withOpacity(0.3)),
              labelStyle: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500, fontSize: 13),
            )).toList(),
          ),
        ],
      ),
    );
  }
}

class _NoResultsView extends StatelessWidget {
  final String query;
  const _NoResultsView({required this.query});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('🔍', style: TextStyle(fontSize: 56)).animate().scale(duration: 500.ms, curve: Curves.elasticOut),
          const SizedBox(height: 16),
          Text('No results for "$query"', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)).animate(delay: 100.ms).fadeIn(),
          const SizedBox(height: 8),
          Text('Try different keywords', style: TextStyle(fontSize: 14, color: AppColors.darkTextSecondary)).animate(delay: 200.ms).fadeIn(),
        ],
      ),
    );
  }
}

class _ChapterResult extends StatelessWidget {
  final ChapterModel chapter;
  const _ChapterResult({required this.chapter});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => context.push('/learning/chapter/${chapter.id}'),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Row(
          children: [
            Text(chapter.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(chapter.title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                  Text('${chapter.totalLessons} lessons', style: TextStyle(fontSize: 12, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.darkTextTertiary),
          ],
        ),
      ),
    );
  }
}

class _QuestionResult extends StatelessWidget {
  final QuestionModel question;
  const _QuestionResult({required this.question});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
            child: Text(question.chapterName, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AppColors.primary)),
          ),
          const SizedBox(height: 8),
          Text(question.question, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, height: 1.4), maxLines: 2, overflow: TextOverflow.ellipsis),
          const SizedBox(height: 6),
          Text('✓ ${question.correctOption}', style: const TextStyle(fontSize: 12, color: AppColors.success, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
