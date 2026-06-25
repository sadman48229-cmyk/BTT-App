import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class QuizProgressBar extends StatelessWidget {
  final int current;
  final int total;
  final int correct;

  const QuizProgressBar({
    super.key,
    required this.current,
    required this.total,
    required this.correct,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final progress = total > 0 ? (current - 1) / total : 0.0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$current / $total',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              Row(
                children: [
                  const Icon(Icons.check_circle_rounded, size: 14, color: AppColors.success),
                  const SizedBox(width: 4),
                  Text(
                    '$correct correct',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: isDark ? AppColors.darkElevated : AppColors.lightElevated,
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}
