import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/user_model.dart';

final supabaseProvider = Provider<SupabaseClient>((ref) => Supabase.instance.client);

final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

final currentUserProvider = FutureProvider<UserModel?>((ref) async {
  final supabase = ref.watch(supabaseProvider);
  final session = supabase.auth.currentSession;
  if (session == null) return null;

  try {
    final data = await supabase
        .from('users')
        .select()
        .eq('id', session.user.id)
        .single();
    return UserModel.fromMap(data);
  } catch (_) {
    // Return minimal user if profile doesn't exist yet
    return UserModel(
      id: session.user.id,
      email: session.user.email ?? '',
      displayName: session.user.userMetadata?['full_name'] as String?,
      avatarUrl: session.user.userMetadata?['avatar_url'] as String?,
      createdAt: DateTime.now(),
    );
  }
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final session = Supabase.instance.client.auth.currentSession;
  return session != null;
});
