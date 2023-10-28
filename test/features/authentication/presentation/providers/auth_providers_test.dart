import 'package:app_template/core/domain/models/user/user_model.dart';
import 'package:app_template/core/errors/exceptions/app_exception.dart';
import 'package:app_template/core/errors/exceptions/cache_failure_excwption.dart';
import 'package:app_template/core/services/auth_service/user_cache_service/domain/repositories/user_cache_repository.dart';
import 'package:app_template/features/authentication/domain/repositories/auth_repository.dart';
import 'package:app_template/features/authentication/presentation/providers/state/auth_notifier.dart';
import 'package:app_template/features/authentication/presentation/providers/state/auth_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:state_notifier_test/state_notifier_test.dart';

import '../../../../fixtures/dummy_data.dart';
import 'auth_providers_test.mapper.g.dart';

void main() {
  initializeJsonMapper();
  late AuthenticationRepository authRepository;
  late UserRepository userRepository;
  late AuthNotifier authNotifier;

  setUpAll(
    () {
      registerFallbackValue(ktestUser);
    },
  );
  setUp(() {
    authRepository = MockAuthRepository();
    userRepository = MockUserRepository();
    authNotifier = AuthNotifier(
      authRepository: authRepository,
      userRepository: userRepository,
    );
  });

  stateNotifierTest<AuthNotifier, AuthState>(
    'emits [] when no methods are called',
    build: () => authNotifier,
    actions: (_) {},
    expect: () => [],
  );
  group(
    'Authentication test\n',
    () {
      stateNotifierTest<AuthNotifier, AuthState>(
        'emits [AuthState.loading, AuthState.success] when login and cache is success',
        build: () => authNotifier,
        setUp: () {
          when(
            () => authRepository.loginUser(user: any(named: 'user')),
          ).thenAnswer(
              (invocation) async => Right<AppException, User>(ktestUser));

          when(() => userRepository.saveUser(user: any(named: 'user')))
              .thenAnswer(
            (invocation) async => true,
          );
        },
        actions: (stateNotifier) async {
          await stateNotifier.loginUser('', '');
        },
        expect: () => [
          const AuthState.loading(),
          const AuthState.success(),
        ],
      );
      stateNotifierTest<AuthNotifier, AuthState>(
        'emits [AuthState.loading, AuthState.failure] when login is success but cache is fail',
        build: () => authNotifier,
        setUp: () {
          when(
            () => authRepository.loginUser(user: any(named: 'user')),
          ).thenAnswer(
            (invocation) async => Right<AppException, User>(ktestUser),
          );

          when(
            () => userRepository.saveUser(user: any(named: 'user')),
          ).thenAnswer(
            (invocation) async => false,
          );
        },
        actions: (stateNotifier) async {
          await stateNotifier.loginUser('', '');
        },
        expect: () => [
          const AuthState.loading(),
          AuthState.failure(CacheFailureException()),
        ],
      );
      test(
        'when the login fails then the saveUser method is not called',
        () async {
          // arrange
          when(
            () => authRepository.loginUser(user: any(named: 'user')),
          ).thenAnswer((invocation) async =>
              Left<AppException, User>(ktestAppException));

          // assert
          await authNotifier.loginUser('', '');

          //act

          verifyNever(() => userRepository.saveUser(user: ktestUser));
        },
      );

      stateNotifierTest<AuthNotifier, AuthState>(
        'emits [AuthState.loading, AuthState.failure] when login is fail',
        build: () => authNotifier,
        setUp: () {
          when(
            () => authRepository.loginUser(user: any(named: 'user')),
          ).thenAnswer(
            (invocation) async => Left<AppException, User>(ktestAppException),
          );
        },
        actions: (stateNotifier) async {
          await stateNotifier.loginUser('', '');
        },
        expect: () => [
          const AuthState.loading(),
          AuthState.failure(ktestAppException),
        ],
      );
    },
  );
}

class MockAuthRepository extends Mock implements AuthenticationRepository {}

class MockUserRepository extends Mock implements UserRepository {}
