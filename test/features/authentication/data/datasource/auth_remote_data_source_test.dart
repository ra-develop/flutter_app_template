import 'package:app_template/core/errors/exceptions/app_exception.dart';
import 'package:app_template/core/services/response.dart';
import 'package:app_template/core/services/storage/remote/network_service.dart';
import 'package:app_template/features/authentication/data/datasource/auth_remote_data_source.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/dummy_data.dart';
import 'auth_remote_data_source_test.mapper.g.dart';

void main() {
  initializeJsonMapper();
  late MockNetworkService mockNetworkService;
  late LoginUserRemoteDataSource loginUserRemoteDataSource;
  setUpAll(
    () {
      mockNetworkService = MockNetworkService();
      loginUserRemoteDataSource = LoginUserRemoteDataSource(mockNetworkService);
    },
  );
  group(
    'Authentication Remote DataSource Test\n',
    () {
      test(
        'login user returns UserModel on success',
        () async {
          // arrange
          when(() => mockNetworkService.post(any(), data: any(named: 'data')))
              .thenAnswer(
            (_) async => Right<AppException, Response>(
              Response(statusCode: 200, data: JsonMapper.toJson(ktestUser)),
            ),
          );
          // act
          final response =
              await loginUserRemoteDataSource.loginUser(user: ktestUser);

          // assert
          expect(response.isRight(), true);
        },
      );
      test(
        'login user returns AppException on failure',
        () async {
          when(
            () => mockNetworkService.post(any(), data: any(named: 'data')),
          ).thenAnswer(
            (_) async => Left(ktestAppException),
          );

          final response =
              await loginUserRemoteDataSource.loginUser(user: ktestUser);

          expect(response.isLeft(), true);
        },
      );
      test(
        'login user returns AppException on exceptions',
        () async {
          when(
            () => mockNetworkService.post(any(), data: any(named: 'data')),
          ).thenThrow(
            (_) => Exception(),
          );

          final response =
              await loginUserRemoteDataSource.loginUser(user: ktestUser);

          expect(response.isLeft(), true);
        },
      );
    },
  );
}

class MockNetworkService extends Mock implements NetworkService {}
