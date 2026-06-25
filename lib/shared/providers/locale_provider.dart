import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/local_storage_service.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en')) {
    _loadLocale();
  }

  void _loadLocale() {
    final saved = LocalStorageService.getString(AppConstants.keyLanguage, defaultValue: 'en');
    state = Locale(saved);
  }

  Future<void> setLocale(String languageCode) async {
    state = Locale(languageCode);
    await LocalStorageService.setString(AppConstants.keyLanguage, languageCode);
  }

  String get currentLanguageCode => state.languageCode;

  String get currentLanguageName {
    switch (state.languageCode) {
      case 'en': return 'English';
      case 'bn': return 'বাংলা (Bengali)';
      case 'hi': return 'हिन्दी (Hindi)';
      default: return 'English';
    }
  }
}
