import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../providers/auth_notifier.dart';

class ForgotPasswordPage extends ConsumerStatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  ConsumerState<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ConsumerState<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendReset() async {
    if (!_formKey.currentState!.validate()) return;
    final notifier = ref.read(authNotifierProvider.notifier);
    await notifier.sendPasswordReset(_emailController.text.trim());
    if (mounted) setState(() => _emailSent = true);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _emailSent ? _SuccessView(email: _emailController.text) : _FormView(
            formKey: _formKey,
            emailController: _emailController,
            isLoading: authState.isLoading,
            onSubmit: _sendReset,
          ),
        ),
      ),
    );
  }
}

class _FormView extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final bool isLoading;
  final VoidCallback onSubmit;

  const _FormView({
    required this.formKey,
    required this.emailController,
    required this.isLoading,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Center(child: Icon(Icons.lock_reset_rounded, size: 36, color: AppColors.primary)),
          ).animate().scale(duration: 500.ms, curve: Curves.elasticOut),

          const SizedBox(height: 24),

          const Text(
            'Forgot your password?',
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          ).animate(delay: 100.ms).fadeIn(duration: 500.ms),

          const SizedBox(height: 8),

          Text(
            'Enter your email address and we\'ll send you a link to reset your password.',
            style: TextStyle(fontSize: 15, height: 1.6, color: AppColors.darkTextSecondary),
          ).animate(delay: 200.ms).fadeIn(duration: 500.ms),

          const SizedBox(height: 32),

          AppTextField(
            controller: emailController,
            label: 'Email Address',
            hint: 'your@email.com',
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
            validator: (val) {
              if (val == null || val.isEmpty) return 'Please enter your email';
              if (!val.contains('@')) return 'Please enter a valid email';
              return null;
            },
          ).animate(delay: 300.ms).fadeIn(duration: 500.ms),

          const SizedBox(height: 24),

          AppButton(
            label: 'Send Reset Link',
            onPressed: onSubmit,
            isLoading: isLoading,
          ).animate(delay: 400.ms).fadeIn(duration: 500.ms),
        ],
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final String email;

  const _SuccessView({required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: const Center(child: Text('✉️', style: TextStyle(fontSize: 48))),
        ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),

        const SizedBox(height: 24),

        const Text(
          'Check your email!',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
          textAlign: TextAlign.center,
        ).animate(delay: 200.ms).fadeIn(duration: 500.ms),

        const SizedBox(height: 12),

        Text(
          'We\'ve sent a password reset link to:\n$email',
          style: TextStyle(fontSize: 15, height: 1.6, color: AppColors.darkTextSecondary),
          textAlign: TextAlign.center,
        ).animate(delay: 300.ms).fadeIn(duration: 500.ms),

        const SizedBox(height: 32),

        AppButton(
          label: 'Back to Sign In',
          onPressed: () => context.pop(),
        ).animate(delay: 400.ms).fadeIn(duration: 500.ms),
      ],
    );
  }
}
