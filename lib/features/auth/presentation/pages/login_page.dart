import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/auth_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.signIn(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  Future<void> _signInWithGoogle() async {
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    ref.listen(authNotifierProvider, (prev, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
      if (next.hasValue && next.value != null) {
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Logo
                Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(child: Text('🚦', style: TextStyle(fontSize: 24))),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'BTT Genius AI',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: -0.2, end: 0),

                const SizedBox(height: 40),

                // Title
                const Text(
                  'Welcome back! 👋',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
                )
                    .animate(delay: 100.ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.2, end: 0),

                const SizedBox(height: 8),

                Text(
                  'Sign in to continue your BTT journey',
                  style: TextStyle(
                    fontSize: 15,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                )
                    .animate(delay: 200.ms)
                    .fadeIn(duration: 500.ms),

                const SizedBox(height: 40),

                // Email field
                AppTextField(
                  controller: _emailController,
                  label: 'Email Address',
                  hint: 'your@email.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email_outlined,
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Please enter your email';
                    if (!val.contains('@')) return 'Please enter a valid email';
                    return null;
                  },
                )
                    .animate(delay: 300.ms)
                    .fadeIn(duration: 500.ms)
                    .slideX(begin: -0.2, end: 0),

                const SizedBox(height: 16),

                // Password field
                AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: '••••••••',
                  obscureText: _obscurePassword,
                  prefixIcon: Icons.lock_outlined,
                  suffixIcon: _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  onSuffixTap: () => setState(() => _obscurePassword = !_obscurePassword),
                  validator: (val) {
                    if (val == null || val.isEmpty) return 'Please enter your password';
                    if (val.length < 6) return 'Password must be at least 6 characters';
                    return null;
                  },
                )
                    .animate(delay: 400.ms)
                    .fadeIn(duration: 500.ms)
                    .slideX(begin: -0.2, end: 0),

                const SizedBox(height: 12),

                // Forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => context.push(AppRoutes.forgotPassword),
                    child: const Text('Forgot Password?'),
                  ),
                ),

                const SizedBox(height: 24),

                // Login button
                AppButton(
                  label: 'Sign In',
                  onPressed: _login,
                  isLoading: authState.isLoading,
                )
                    .animate(delay: 500.ms)
                    .fadeIn(duration: 500.ms)
                    .slideY(begin: 0.2, end: 0),

                const SizedBox(height: 24),

                // Divider
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or continue with',
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                        ),
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),

                const SizedBox(height: 24),

                // Google Sign In
                _SocialButton(
                  label: 'Continue with Google',
                  icon: '🌐',
                  onPressed: _signInWithGoogle,
                ),

                const SizedBox(height: 32),

                // Register link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                      TextButton(
                        onPressed: () => context.push(AppRoutes.register),
                        child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Disclaimer
                Text(
                  AppConstants.disclaimer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 10,
                    color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final String label;
  final String icon;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        minimumSize: const Size(double.infinity, 54),
        foregroundColor: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
