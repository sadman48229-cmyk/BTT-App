import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/providers/auth_provider.dart';
import '../../../../shared/providers/locale_provider.dart';
import '../../../../shared/providers/theme_provider.dart';
import '../../../auth/presentation/providers/auth_notifier.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _dailyReminder = true;
  bool _streakReminder = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [

          // Appearance
          _SectionHeader(title: 'Appearance'),
          _SettingsCard(
            isDark: isDark,
            children: [
              _SettingsTile(
                icon: Icons.dark_mode_rounded,
                iconColor: AppColors.primary,
                title: 'Dark Mode',
                subtitle: themeMode == ThemeMode.dark ? 'On' : themeMode == ThemeMode.light ? 'Off' : 'System',
                trailing: Switch(
                  value: themeMode == ThemeMode.dark,
                  onChanged: (v) => ref.read(themeModeProvider.notifier).setTheme(v ? ThemeMode.dark : ThemeMode.light),
                  activeColor: AppColors.primary,
                ),
              ),
              _Divider(isDark: isDark),
              _SettingsTile(
                icon: Icons.contrast_rounded,
                iconColor: AppColors.secondary,
                title: 'System Theme',
                subtitle: 'Follow device setting',
                trailing: Switch(
                  value: themeMode == ThemeMode.system,
                  onChanged: (v) => ref.read(themeModeProvider.notifier).setTheme(v ? ThemeMode.system : ThemeMode.light),
                  activeColor: AppColors.primary,
                ),
              ),
            ],
          ).animate().fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // Language
          _SectionHeader(title: 'Language'),
          _SettingsCard(
            isDark: isDark,
            children: [
              _LanguageTile(
                language: 'English',
                flag: '🇬🇧',
                langCode: 'en',
                selected: locale.languageCode == 'en',
                isDark: isDark,
                onTap: () => ref.read(localeProvider.notifier).setLocale(const Locale('en')),
              ),
              _Divider(isDark: isDark),
              _LanguageTile(
                language: 'বাংলা (Bengali)',
                flag: '🇧🇩',
                langCode: 'bn',
                selected: locale.languageCode == 'bn',
                isDark: isDark,
                onTap: () => ref.read(localeProvider.notifier).setLocale(const Locale('bn')),
              ),
              _Divider(isDark: isDark),
              _LanguageTile(
                language: 'हिंदी (Hindi)',
                flag: '🇮🇳',
                langCode: 'hi',
                selected: locale.languageCode == 'hi',
                isDark: isDark,
                onTap: () => ref.read(localeProvider.notifier).setLocale(const Locale('hi')),
              ),
            ],
          ).animate(delay: 100.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // Notifications
          _SectionHeader(title: 'Notifications'),
          _SettingsCard(
            isDark: isDark,
            children: [
              _SettingsTile(
                icon: Icons.notifications_rounded,
                iconColor: AppColors.accent,
                title: 'All Notifications',
                subtitle: 'Enable push notifications',
                trailing: Switch(
                  value: _notificationsEnabled,
                  onChanged: (v) => setState(() => _notificationsEnabled = v),
                  activeColor: AppColors.primary,
                ),
              ),
              _Divider(isDark: isDark),
              _SettingsTile(
                icon: Icons.access_alarm_rounded,
                iconColor: AppColors.secondary,
                title: 'Daily Study Reminder',
                subtitle: 'Remind me to study every day',
                trailing: Switch(
                  value: _dailyReminder && _notificationsEnabled,
                  onChanged: _notificationsEnabled ? (v) => setState(() => _dailyReminder = v) : null,
                  activeColor: AppColors.primary,
                ),
              ),
              _Divider(isDark: isDark),
              _SettingsTile(
                icon: Icons.local_fire_department_rounded,
                iconColor: AppColors.error,
                title: 'Streak Reminder',
                subtitle: 'Don\'t lose your streak',
                trailing: Switch(
                  value: _streakReminder && _notificationsEnabled,
                  onChanged: _notificationsEnabled ? (v) => setState(() => _streakReminder = v) : null,
                  activeColor: AppColors.primary,
                ),
              ),
            ],
          ).animate(delay: 200.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // Account
          _SectionHeader(title: 'Account'),
          _SettingsCard(
            isDark: isDark,
            children: [
              _SettingsTile(
                icon: Icons.person_rounded,
                iconColor: AppColors.primary,
                title: 'Edit Profile',
                subtitle: 'Update your name and photo',
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.darkTextTertiary),
                onTap: () => context.push(AppRoutes.profile),
              ),
              _Divider(isDark: isDark),
              _SettingsTile(
                icon: Icons.workspace_premium_rounded,
                iconColor: AppColors.goldAchievement,
                title: 'Premium Subscription',
                subtitle: 'Manage your plan',
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.darkTextTertiary),
                onTap: () => context.push(AppRoutes.subscription),
              ),
            ],
          ).animate(delay: 300.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // About
          _SectionHeader(title: 'About'),
          _SettingsCard(
            isDark: isDark,
            children: [
              _SettingsTile(
                icon: Icons.info_outline_rounded,
                iconColor: AppColors.secondary,
                title: 'App Version',
                subtitle: 'v${AppConstants.appVersion}',
              ),
              _Divider(isDark: isDark),
              _SettingsTile(
                icon: Icons.privacy_tip_outlined,
                iconColor: AppColors.primary,
                title: 'Privacy Policy',
                trailing: const Icon(Icons.open_in_new_rounded, size: 14, color: AppColors.darkTextTertiary),
                onTap: () {},
              ),
              _Divider(isDark: isDark),
              _SettingsTile(
                icon: Icons.description_outlined,
                iconColor: AppColors.primary,
                title: 'Terms of Service',
                trailing: const Icon(Icons.open_in_new_rounded, size: 14, color: AppColors.darkTextTertiary),
                onTap: () {},
              ),
              _Divider(isDark: isDark),
              _SettingsTile(
                icon: Icons.help_outline_rounded,
                iconColor: AppColors.secondary,
                title: 'Help & Support',
                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.darkTextTertiary),
                onTap: () {},
              ),
            ],
          ).animate(delay: 400.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // Disclaimer
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.warning.withOpacity(0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('⚠️', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    AppConstants.disclaimer,
                    style: TextStyle(fontSize: 11, height: 1.5,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary),
                  ),
                ),
              ],
            ),
          ).animate(delay: 500.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 16),

          // Sign Out
          _SettingsCard(
            isDark: isDark,
            children: [
              _SettingsTile(
                icon: Icons.logout_rounded,
                iconColor: AppColors.error,
                title: 'Sign Out',
                titleColor: AppColors.error,
                onTap: () => _showSignOutDialog(context),
              ),
            ],
          ).animate(delay: 600.ms).fadeIn(duration: 400.ms),

          const SizedBox(height: 32),
        ],
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out', style: TextStyle(fontWeight: FontWeight.w700)),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => ctx.pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              ctx.pop();
              await ref.read(authNotifierProvider.notifier).signOut();
              if (mounted) context.go(AppRoutes.login);
            },
            child: Text('Sign Out', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary)),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final bool isDark;
  final List<Widget> children;
  const _SettingsCard({required this.isDark, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? AppColors.darkBorder : AppColors.lightBorder),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Color? titleColor;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.titleColor,
    this.subtitle,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 36, height: 36,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600,
                      color: titleColor)),
                  if (subtitle != null)
                    Text(subtitle!, style: TextStyle(fontSize: 12, color: AppColors.darkTextSecondary)),
                ],
              ),
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  final String language;
  final String flag;
  final String langCode;
  final bool selected;
  final bool isDark;
  final VoidCallback onTap;

  const _LanguageTile({
    required this.language,
    required this.flag,
    required this.langCode,
    required this.selected,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(flag, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 14),
            Expanded(
              child: Text(language, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            ),
            if (selected)
              const Icon(Icons.check_circle_rounded, color: AppColors.primary, size: 20),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  final bool isDark;
  const _Divider({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1, indent: 66,
      color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
    );
  }
}
