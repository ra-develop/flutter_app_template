import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/providers/login_provider.dart';
import '../../domain/providers/user_cache_provider.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_cache_repository.dart';
import 'state/auth_notifier.dart';
import 'state/auth_state.dart';

final authStateNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) {
    final AuthenticationRepository authenticationRepository =
        ref.watch(authRepositoryProvider);
    final UserRepository userRepository =
        ref.watch(userLocalRepositoryProvider);
    return AuthNotifier(
      authRepository: authenticationRepository,
      userRepository: userRepository,
    );
  },
);
