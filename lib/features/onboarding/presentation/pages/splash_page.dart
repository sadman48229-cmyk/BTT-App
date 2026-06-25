import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/theme/app_colors.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;

    final session = Supabase.instance.client.auth.currentSession;
    final onboardingDone = LocalStorageService.getBool(
      AppConstants.keyOnboardingComplete,
    );

    if (session != null) {
      context.go(AppRoutes.home);
    } else if (!onboardingDone) {
      context.go(AppRoutes.onboarding);
    } else {
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Center(
                child: Text('🚦', style: TextStyle(fontSize: 48)),
              ),
            )
                .animate()
                .scale(
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                  begin: const Offset(0.5, 0.5),
                )
                .fadeIn(duration: 400.ms),

            const SizedBox(height: 24),

            // App Name
            const Text(
              'BTT Genius AI',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            )
                .animate(delay: 400.ms)
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 8),

            // Tagline
            Text(
              'Your AI-Powered BTT Companion',
              style: TextStyle(
                color: AppColors.darkTextSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
                .animate(delay: 600.ms)
                .fadeIn(duration: 500.ms)
                .slideY(begin: 0.3, end: 0),

            const SizedBox(height: 60),

            // Loading indicator
            SizedBox(
              width: 100,
              child: LinearProgressIndicator(
                backgroundColor: AppColors.darkElevated,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                borderRadius: BorderRadius.circular(4),
              ),
            )
                .animate(delay: 800.ms)
                .fadeIn(duration: 400.ms),
          ],
        ),
      ),
    );
  }
}
