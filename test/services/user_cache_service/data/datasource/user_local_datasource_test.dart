import 'package:app_template/core/services/auth_service/user_cache_service/data/datasource/user_local_datasource.dart';
import 'package:app_template/core/services/storage/local/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../fixtures/data/user_map.dart';
import '../../../../fixtures/dummy_data.dart';
import 'user_local_datasource_test.mapper.g.dart';

void main() {
  initializeJsonMapper();
  late StorageService storageService;
  late UserDataSource userDataSource;
  setUpAll(() {
    storageService = MockStorageService();
    userDataSource = UserLocalDatasource(storageService);
  });
  test(
    'Should return valid User model when user was found',
    () async {
      // arrange
      when(
        () => storageService.get(any()),
      ).thenAnswer(
        (invocation) async => ktestUserJson,
      );
      // act
      final data = await userDataSource.fetchUser();

      //assert
      expect(data.isRight(), true);
    },
  );
  test(
    'Should return AppException when user was not found',
    () async {
      // arrange

      when(
        () => storageService.get(any()),
      ).thenAnswer(
        (invocation) async => null,
      );

      // act
      final data = await userDataSource.fetchUser();

      //assert

      expect(data.isLeft(), true);
    },
  );
  test(
    'Should return true when user is saved',
    () async {
      // arrange

      when(
        () => storageService.set(any(), any()),
      ).thenAnswer(
        (invocation) async => true,
      );

      // act
      final data = await userDataSource.saveUser(user: ktestUser);

      //assert

      expect(data, true);
    },
  );
  test(
    'Should return false when user is not saved',
    () async {
      // arrange

      when(
        () => storageService.set(any(), any()),
      ).thenAnswer(
        (invocation) async => false,
      );

      // act
      final data = await userDataSource.saveUser(user: ktestUser);

      //assert

      expect(data, false);
    },
  );
  test(
    'Should return true when user is deleted',
    () async {
      // arrange

      when(
        () => storageService.remove(any()),
      ).thenAnswer(
        (invocation) async => true,
      );

      // act
      final data = await userDataSource.deleteUser();

      //assert

      expect(data, true);
    },
  );
  test(
    'Should return false when user is not deleted',
    () async {
      // arrange

      when(
        () => storageService.remove(any()),
      ).thenAnswer(
        (invocation) async => false,
      );

      // act
      final data = await userDataSource.deleteUser();

      //assert

      expect(data, false);
    },
  );
  test(
    'Should check if user is saved',
    () async {
      // arrange

      when(
        () => storageService.has(any()),
      ).thenAnswer(
        (invocation) async => false,
      );

      // act
      final data = await userDataSource.hasUser();

      //assert

      expect(data, false);

      when(
        () => storageService.has(any()),
      ).thenAnswer(
        (invocation) async => true,
      );

      // act
      final data2 = await userDataSource.hasUser();

      //assert

      expect(data2, true);
    },
  );
}

class MockStorageService extends Mock implements StorageService {}
