import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants/app_routes.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/auth/presentation/pages/forgot_password_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/onboarding/presentation/pages/splash_page.dart';
import '../../features/learning/presentation/pages/learning_page.dart';
import '../../features/learning/presentation/pages/chapter_detail_page.dart';
import '../../features/learning/presentation/pages/lesson_detail_page.dart';
import '../../features/quiz/presentation/pages/quiz_page.dart';
import '../../features/quiz/presentation/pages/quiz_result_page.dart';
import '../../features/mock_exam/presentation/pages/mock_exam_page.dart';
import '../../features/mock_exam/presentation/pages/mock_exam_result_page.dart';
import '../../features/ai_tutor/presentation/pages/ai_tutor_page.dart';
import '../../features/progress/presentation/pages/progress_page.dart';
import '../../features/achievements/presentation/pages/achievements_page.dart';
import '../../features/mistake_notebook/presentation/pages/mistake_notebook_page.dart';
import '../../features/search/presentation/pages/search_page.dart';
import '../../features/glossary/presentation/pages/glossary_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/subscription_page.dart';
import '../../features/settings/presentation/pages/profile_page.dart';
import '../../features/quiz/presentation/pages/daily_challenge_page.dart';
import '../../shared/widgets/main_scaffold.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: false,
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isAuthenticated = session != null;

      final publicRoutes = [
        AppRoutes.splash,
        AppRoutes.onboarding,
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.forgotPassword,
      ];

      final isPublicRoute = publicRoutes.any((r) => state.matchedLocation == r);

      if (!isAuthenticated && !isPublicRoute) {
        return AppRoutes.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: AppRoutes.learning,
            builder: (context, state) => const LearningPage(),
            routes: [
              GoRoute(
                path: 'chapter/:id',
                builder: (context, state) => ChapterDetailPage(
                  chapterId: state.pathParameters['id']!,
                ),
                routes: [
                  GoRoute(
                    path: 'lesson/:lessonId',
                    builder: (context, state) => LessonDetailPage(
                      chapterId: state.pathParameters['id']!,
                      lessonId: state.pathParameters['lessonId']!,
                    ),
                  ),
                ],
              ),
            ],
          ),
          GoRoute(
            path: AppRoutes.progress,
            builder: (context, state) => const ProgressPage(),
          ),
          GoRoute(
            path: AppRoutes.aiTutor,
            builder: (context, state) => const AiTutorPage(),
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.quiz,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return QuizPage(
            chapterId: extra?['chapterId'] as String?,
            difficulty: extra?['difficulty'] as String?,
            questionCount: extra?['questionCount'] as int? ?? 10,
          );
        },
      ),
      GoRoute(
        path: AppRoutes.quizResult,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return QuizResultPage(resultData: extra);
        },
      ),
      GoRoute(
        path: AppRoutes.mockExam,
        builder: (context, state) => const MockExamPage(),
      ),
      GoRoute(
        path: AppRoutes.mockExamResult,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return MockExamResultPage(resultData: extra);
        },
      ),
      GoRoute(
        path: AppRoutes.achievements,
        builder: (context, state) => const AchievementsPage(),
      ),
      GoRoute(
        path: AppRoutes.mistakeNotebook,
        builder: (context, state) => const MistakeNotebookPage(),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchPage(),
      ),
      GoRoute(
        path: AppRoutes.glossary,
        builder: (context, state) => const GlossaryPage(),
      ),
      GoRoute(
        path: AppRoutes.subscription,
        builder: (context, state) => const SubscriptionPage(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: AppRoutes.dailyChallenge,
        builder: (context, state) => const DailyChallengePage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Page not found', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
