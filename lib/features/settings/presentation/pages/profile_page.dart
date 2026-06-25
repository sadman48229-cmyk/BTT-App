import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/models/user_model.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final _nameController = TextEditingController();
  LearningLevel _selectedLevel = LearningLevel.beginner;
  bool _saving = false;
  bool _edited = false;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() {
    final user = ref.read(currentUserProvider).valueOrNull;
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _selectedLevel = user.level;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final userAsync = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
        actions: [
          if (_edited)
            TextButton(
              onPressed: _saving ? null : _saveProfile,
              child: Text(_saving ? 'Saving...' : 'Save',
                  style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700)),
            ),
        ],
      ),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) {
          if (user == null) return const Center(child: Text('Not logged in'));
          return ListView(
            padding: const EdgeInsets.all(20),
            children: [

              // Avatar section
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 52,
                      backgroundColor: AppColors.primary.withOpacity(0.15),
                      child: Text(
                        (user.displayName?.isNotEmpty == true) ? user.displayName![0].toUpperCase() : '?',
                        style: const TextStyle(fontSize: 44, fontWeight: FontWeight.w700, color: AppColors.primary),
                      ),
                    ),
                    Positioned(
                      bottom: 0, right: 0,
                      child: Container(
                        width: 32, height: 32,
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: const Icon(Icons.camera_alt_rounded, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),

              const SizedBox(height: 8),
              Center(
                child: Text(user.email,
                    style: TextStyle(fontSize: 13, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
              ).animate(delay: 100.ms).fadeIn(),

              const SizedBox(height: 24),

              // Stats row
              Row(
                children: [
                  _StatBox(value: '${user.studyStreak}', label: 'Day Streak', icon: '🔥', isDark: isDark),
                  const SizedBox(width: 12),
                  _StatBox(value: '${user.totalQuestionsAnswered}', label: 'Questions', icon: '📝', isDark: isDark),
                  const SizedBox(width: 12),
                  _StatBox(
                    value: user.totalQuestionsAnswered > 0
                        ? '${(user.totalCorrectAnswers / user.totalQuestionsAnswered * 100).round()}%'
                        : '0%',
                    label: 'Accuracy',
                    icon: '🎯',
                    isDark: isDark,
                  ),
                ],
              ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 24),

              // Edit form
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Display Name', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _nameController,
                      onChanged: (_) => setState(() => _edited = true),
                      decoration: InputDecoration(
                        hintText: 'Your name',
                        prefixIcon: const Icon(Icons.person_outline_rounded, size: 18),
                        suffixIcon: _nameController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () { _nameController.clear(); setState(() => _edited = true); },
                                child: const Icon(Icons.close_rounded, size: 16))
                            : null,
                      ),
                    ),

                    const SizedBox(height: 20),
                    const Text('Learning Level', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),

                    ...LearningLevel.values.map((level) => _LevelOption(
                      level: level,
                      selected: _selectedLevel == level,
                      isDark: isDark,
                      onTap: () => setState(() { _selectedLevel = level; _edited = true; }),
                    )),
                  ],
                ),
              ).animate(delay: 300.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 20),

              // Subscription badge
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: user.isPremium
                      ? AppColors.accentGradient
                      : LinearGradient(colors: [AppColors.darkCard, AppColors.darkCard]),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: user.isPremium ? Colors.transparent : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                  ),
                ),
                child: Row(
                  children: [
                    Text(user.isPremium ? '⭐' : '🆓', style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.isPremium ? 'Premium Member' : 'Free Plan',
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700,
                              color: user.isPremium ? Colors.white : null,
                            ),
                          ),
                          Text(
                            user.isPremium
                                ? 'Subscription: ${user.subscription.name}'
                                : 'Upgrade for full access',
                            style: TextStyle(
                              fontSize: 12,
                              color: user.isPremium ? Colors.white70 : AppColors.darkTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!user.isPremium)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text('Upgrade',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.white)),
                      ),
                  ],
                ),
              ).animate(delay: 400.ms).fadeIn(duration: 400.ms),

              const SizedBox(height: 32),
            ],
          );
        },
      ),
    );
  }

  Future<void> _saveProfile() async {
    if (_nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Name cannot be empty')),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      await ref.read(authNotifierProvider.notifier).updateProfile(
        displayName: _nameController.text.trim(),
        level: _selectedLevel,
      );
      if (mounted) {
        setState(() { _edited = false; _saving = false; });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated!'), backgroundColor: AppColors.success),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() => _saving = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
        );
      }
    }
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final String icon;
  final bool isDark;

  const _StatBox({required this.value, required this.label, required this.icon, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
        ),
        child: Column(
          children: [
            Text(icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
            Text(label, style: TextStyle(fontSize: 10, color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary)),
          ],
        ),
      ),
    );
  }
}

class _LevelOption extends StatelessWidget {
  final LearningLevel level;
  final bool selected;
  final bool isDark;
  final VoidCallback onTap;

  const _LevelOption({required this.level, required this.selected, required this.isDark, required this.onTap});

  String get _emoji => switch (level) {
    LearningLevel.beginner => '🌱',
    LearningLevel.intermediate => '🌿',
    LearningLevel.advanced => '🌳',
  };

  String get _desc => switch (level) {
    LearningLevel.beginner => 'New to driving theory',
    LearningLevel.intermediate => 'Know some basics',
    LearningLevel.advanced => 'Ready for exam',
  };

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.primary.withOpacity(0.5) : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(_emoji, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(level.name[0].toUpperCase() + level.name.substring(1),
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
                          color: selected ? AppColors.primary : null)),
                  Text(_desc, style: const TextStyle(fontSize: 12, color: AppColors.darkTextSecondary)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }
}
