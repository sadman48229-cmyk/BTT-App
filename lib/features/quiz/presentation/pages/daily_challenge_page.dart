import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';

class DailyChallengePage extends ConsumerWidget {
  const DailyChallengePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Challenge', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 100, height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFF7C3AED), Color(0xFF2563EB)]),
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              child: const Center(child: Text('🎯', style: TextStyle(fontSize: 52))),
            ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),

            const SizedBox(height: 24),

            const Text("Today's Challenge", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800))
                .animate(delay: 100.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 8),

            Text(
              '10 fresh questions every day\nKeep your streak going!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, height: 1.6, color: AppColors.darkTextSecondary),
            ).animate(delay: 200.ms).fadeIn(duration: 500.ms),

            const SizedBox(height: 32),

            // Challenge info
            ...[
              ['🎯', '10 Questions', 'Mixed difficulty — covers all chapters'],
              ['⏱️', 'No time limit', 'Take your time and learn well'],
              ['🔥', 'Streak builder', 'Maintain your daily streak'],
              ['📊', 'Tracked progress', 'Counts toward your daily goal'],
            ].asMap().entries.map((e) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _InfoRow(icon: e.value[0], title: e.value[1], subtitle: e.value[2])
                  .animate(delay: Duration(milliseconds: 300 + e.key * 80))
                  .fadeIn(duration: 400.ms)
                  .slideX(begin: -0.2, end: 0),
            )),

            const Spacer(),

            AppButton(
              label: 'Start Daily Challenge',
              onPressed: () => context.pushReplacement(AppRoutes.quiz, extra: {
                'questionCount': AppConstants.dailyChallengeCount,
              }),
              icon: Icons.play_arrow_rounded,
            ).animate(delay: 700.ms).fadeIn(duration: 400.ms),

            const SizedBox(height: 16),

            Text(
              'Come back tomorrow for a new challenge!',
              style: TextStyle(fontSize: 12, color: AppColors.darkTextTertiary),
            ).animate(delay: 800.ms).fadeIn(duration: 400.ms),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;

  const _InfoRow({required this.icon, required this.title, required this.subtitle});

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
          Text(icon, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                Text(subtitle, style: TextStyle(fontSize: 12, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
