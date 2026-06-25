import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../shared/models/user_model.dart' show UserModel, LearningLevel;

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, UserModel?>(AuthNotifier.new);

class AuthNotifier extends AsyncNotifier<UserModel?> {
  SupabaseClient get _supabase => Supabase.instance.client;

  @override
  Future<UserModel?> build() async {
    final session = _supabase.auth.currentSession;
    if (session == null) return null;
    return _fetchUser(session.user.id);
  }

  Future<UserModel?> _fetchUser(String userId) async {
    try {
      final data = await _supabase.from('users').select().eq('id', userId).single();
      return UserModel.fromMap(data);
    } catch (_) {
      return null;
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncLoading();
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      if (response.user != null) {
        state = AsyncData(await _fetchUser(response.user!.id));
      }
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncError('Sign in failed. Please try again.', StackTrace.current);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    state = const AsyncLoading();
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': displayName},
      );

      if (response.user != null) {
        // Create user profile
        final user = UserModel(
          id: response.user!.id,
          email: email,
          displayName: displayName,
          createdAt: DateTime.now(),
        );
        await _supabase.from('users').upsert(user.toMap());
        state = AsyncData(user);
      }
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncError('Sign up failed. Please try again.', StackTrace.current);
    }
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncLoading();
    try {
      await _supabase.auth.signInWithOAuth(OAuthProvider.google);
      // OAuth redirects externally; state update handled by auth listener
      state = const AsyncData(null);
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncError('Google sign in failed.', StackTrace.current);
    }
  }

  Future<void> sendPasswordReset(String email) async {
    state = const AsyncLoading();
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      state = const AsyncData(null);
    } on AuthException catch (e) {
      state = AsyncError(e.message, StackTrace.current);
    } catch (e) {
      state = AsyncError('Failed to send reset email.', StackTrace.current);
    }
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
    state = const AsyncData(null);
  }

  Future<void> updateProfile({
    String? displayName,
    String? avatarUrl,
    String? language,
    LearningLevel? level,
  }) async {
    final current = state.valueOrNull;
    if (current == null) return;

    final updated = current.copyWith(
      displayName: displayName,
      avatarUrl: avatarUrl,
      language: language,
      level: level,
    );

    await _supabase.from('users').update(updated.toMap()).eq('id', current.id);
    state = AsyncData(updated);
  }
}
