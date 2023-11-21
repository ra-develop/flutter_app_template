import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/errors/exceptions/cache_failure_excwption.dart';
import '../../../../../core/services/auth_service/user_cache_service/data/models/user/user_model.dart';
import '../../../../../core/services/auth_service/user_cache_service/domain/repositories/user_cache_repository.dart';
import '../../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthenticationRepository authRepository;
  final UserRepository userRepository;

  AuthNotifier({
    required this.authRepository,
    required this.userRepository,
  }) : super(const AuthState.initial());

  Future<void> loginUser(String username, String password) async {
    state = const AuthState.loading();
    final response = await authRepository.loginUser(
      user: User(username: username, password: password),
    );

    state = await response.fold(
      (failure) => AuthState.failure(failure),
      (user) async {
        final hasSavedUser = await userRepository.saveUser(user: user);
        if (hasSavedUser) {
          return const AuthState.success();
        }
        return AuthState.failure(CacheFailureException());
      },
    );
  }
}
