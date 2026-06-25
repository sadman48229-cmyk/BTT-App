import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/auth_provider.dart';

class SubscriptionPage extends ConsumerStatefulWidget {
  const SubscriptionPage({super.key});

  @override
  ConsumerState<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends ConsumerState<SubscriptionPage> {
  int _selectedPlan = 1; // 0=monthly, 1=yearly, 2=lifetime

  static const _plans = [
    _PlanData(
      id: 'monthly',
      label: 'Monthly',
      price: 'S\$4.99',
      period: '/month',
      badge: null,
      savings: null,
      color: AppColors.secondary,
    ),
    _PlanData(
      id: 'yearly',
      label: 'Yearly',
      price: 'S\$29.99',
      period: '/year',
      badge: 'POPULAR',
      savings: 'Save 50%',
      color: AppColors.primary,
    ),
    _PlanData(
      id: 'lifetime',
      label: 'Lifetime',
      price: 'S\$79.99',
      period: 'one-time',
      badge: 'BEST VALUE',
      savings: 'Pay once, learn forever',
      color: AppColors.goldAchievement,
    ),
  ];

  static const _features = [
    _FeatureRow('Unlimited AI Tutor chats', free: false, premium: true),
    _FeatureRow('Full question bank (500+ questions)', free: false, premium: true),
    _FeatureRow('All 9 chapter modules', free: false, premium: true),
    _FeatureRow('Mock Exam (50 questions)', free: false, premium: true),
    _FeatureRow('AI-generated study plans', free: false, premium: true),
    _FeatureRow('Offline mode', free: false, premium: true),
    _FeatureRow('Priority support', free: false, premium: true),
    _FeatureRow('Basic practice (10 questions)', free: true, premium: true),
    _FeatureRow('Mistake Notebook', free: true, premium: true),
    _FeatureRow('Daily Challenge', free: true, premium: true),
    _FeatureRow('Progress tracking', free: true, premium: true),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Premium', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      ),
      body: CustomScrollView(
        slivers: [

          // Hero banner
          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Text('🚗', style: TextStyle(fontSize: 52)),
                  const SizedBox(height: 12),
                  const Text('Unlock Your Full\nBTT Journey',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.white, height: 1.2)),
                  const SizedBox(height: 8),
                  const Text('AI-powered learning, unlimited practice\nand a higher chance of passing',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white70, height: 1.5)),
                ],
              ),
            ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
          ),

          // Plan selector
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: List.generate(_plans.length, (i) => Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: i > 0 ? 8 : 0),
                        child: _PlanCard(
                          plan: _plans[i],
                          selected: _selectedPlan == i,
                          isDark: isDark,
                          onTap: () => setState(() => _selectedPlan = i),
                        ),
                      ),
                    )),
                  ),
                ],
              ).animate(delay: 200.ms).fadeIn(duration: 400.ms),
            ),
          ),

          // CTA
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => _handleSubscribe(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      backgroundColor: _plans[_selectedPlan].color,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      'Get ${_plans[_selectedPlan].label} — ${_plans[_selectedPlan].price}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _plans[_selectedPlan].id == 'lifetime'
                        ? 'One-time payment, no renewal'
                        : 'Cancel anytime. No hidden fees.',
                    style: TextStyle(fontSize: 12, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                  ),
                ],
              ).animate(delay: 300.ms).fadeIn(duration: 400.ms),
            ),
          ),

          // Feature comparison
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Text('What\'s included',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary)),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                ),
                child: Column(
                  children: [
                    // Header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          _TableHeader('Free', color: AppColors.darkTextSecondary),
                          const SizedBox(width: 24),
                          _TableHeader('Premium', color: AppColors.primary),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                    ..._features.asMap().entries.map((e) => Column(
                      children: [
                        _FeatureTile(feature: e.value, isDark: isDark),
                        if (e.key < _features.length - 1)
                          Divider(height: 1, indent: 16,
                              color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      ],
                    )),
                  ],
                ),
              ).animate(delay: 400.ms).fadeIn(duration: 400.ms),
            ),
          ),

          // Restore & Legal
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Restore Purchase',
                        style: TextStyle(fontSize: 13, color: AppColors.primary)),
                  ),
                  Text(
                    'Subscriptions auto-renew unless cancelled at least 24 hours before the end of the current period. Manage subscriptions in your App Store account settings.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 10, height: 1.5,
                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
                  ),
                ],
              ).animate(delay: 500.ms).fadeIn(duration: 400.ms),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  void _handleSubscribe(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(height: 20),
            const Text('🚧', style: TextStyle(fontSize: 48)),
            const SizedBox(height: 12),
            const Text('Coming Soon!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text(
              'In-app purchases will be available when the app launches on the App Store and Google Play.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, height: 1.6, color: AppColors.darkTextSecondary),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
              child: const Text('Got it'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _PlanData {
  final String id;
  final String label;
  final String price;
  final String period;
  final String? badge;
  final String? savings;
  final Color color;

  const _PlanData({
    required this.id,
    required this.label,
    required this.price,
    required this.period,
    required this.badge,
    required this.savings,
    required this.color,
  });
}

class _PlanCard extends StatelessWidget {
  final _PlanData plan;
  final bool selected;
  final bool isDark;
  final VoidCallback onTap;

  const _PlanCard({required this.plan, required this.selected, required this.isDark, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? plan.color.withOpacity(0.1) : (isDark ? AppColors.darkCard : AppColors.lightCard),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? plan.color : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: selected ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (plan.badge != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: plan.color,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(plan.badge!, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.w800, color: Colors.white)),
              )
            else
              const SizedBox(height: 18),
            const SizedBox(height: 6),
            Text(plan.label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700,
                color: selected ? plan.color : null)),
            Text(plan.price, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800,
                color: selected ? plan.color : null)),
            Text(plan.period, style: const TextStyle(fontSize: 10, color: AppColors.darkTextSecondary)),
            if (plan.savings != null) ...[
              const SizedBox(height: 4),
              Text(plan.savings!, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: plan.color)),
            ],
          ],
        ),
      ),
    );
  }
}

class _FeatureRow {
  final String title;
  final bool free;
  final bool premium;
  const _FeatureRow(this.title, {required this.free, required this.premium});
}

class _TableHeader extends StatelessWidget {
  final String text;
  final Color color;
  const _TableHeader(this.text, {required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      child: Text(text, textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color)),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final _FeatureRow feature;
  final bool isDark;
  const _FeatureTile({required this.feature, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Text(feature.title,
                style: TextStyle(fontSize: 13,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
          ),
          SizedBox(
            width: 56,
            child: Center(child: _CheckIcon(value: feature.free)),
          ),
          const SizedBox(width: 24),
          SizedBox(
            width: 56,
            child: Center(child: _CheckIcon(value: feature.premium, highlight: true)),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _CheckIcon extends StatelessWidget {
  final bool value;
  final bool highlight;
  const _CheckIcon({required this.value, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    if (value) {
      return Icon(Icons.check_circle_rounded,
          size: 18, color: highlight ? AppColors.primary : AppColors.success);
    }
    return Icon(Icons.remove_rounded, size: 16, color: AppColors.darkTextTertiary.withOpacity(0.4));
  }
}
