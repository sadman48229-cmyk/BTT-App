import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/network/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/providers/theme_provider.dart';
import 'shared/providers/locale_provider.dart';

class BTTGeniusApp extends ConsumerWidget {
  const BTTGeniusApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'BTT Genius AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      locale: locale,
      supportedLocales: const [
        Locale('en'),
        Locale('bn'), // Bengali
        Locale('hi'), // Hindi
      ],
      routerConfig: router,
    );
  }
}
