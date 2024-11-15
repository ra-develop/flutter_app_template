import 'package:app_template/core/data/datasources/data_base/object_box_service.dart';
import 'package:app_template/features/authentication/data/models/user/user_model.dart';
import 'package:app_template/objectbox.g.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../fixtures/data/user_map.dart';

void main() {
  late ObjectBoxService dataBaseService;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            (MethodCall methodCall) async {
      return './test';
    });
  });

  setUpAll(() {
    dataBaseService = ObjectBoxService();
  });

  test('When the service is not initialized the hasInitialized should be FALSE',
      () {
    expect(dataBaseService.hasInitialized, false);
  });

  test('When the service is initialized the hasInitialized should be TRUE',
      () async {
    final isInitiated = await dataBaseService.init();
    expect(isInitiated, true);
  });

  test('Create object  User in the "store" of ObjectBox', () async {
    if (!dataBaseService.hasInitialized) {
      await dataBaseService.init();
    }
    final userBox = dataBaseService.getObjects<User>();
    expect(userBox.isEmpty(), true);
  });

  test('Read transaction test', () async {
    if (!dataBaseService.hasInitialized) {
      await dataBaseService.init();
    }
    final userBox = dataBaseService.getObjects<User>();

    final users = <User>[];
    for (var i = 0; i < 5; i++) {
      final newUser = testUser.copyWith(id: testUser.id + i);
      users.add(newUser);
    }
    final userBoxIndexes = userBox.putMany(users);

    final readUsers = dataBaseService.txRead(() {
      final users = <User>[];
      final getAllUsers = userBox.getAll();
      final countUsers = userBox.count();
      for (var index in userBoxIndexes) {
        final user = userBox.get(index);
        if (user != null) {
          users.add(user);
        }
      }
      return users;
    });

    expect(users, readUsers);

    userBox.removeAll();
  });

  test('Read async transaction test', () async {
    if (!dataBaseService.hasInitialized) {
      await dataBaseService.init();
    }
    final userBox = dataBaseService.getObjects<User>();

    final users = <User>[];
    for (var i = 0; i < 5; i++) {
      final newUser = testUser.copyWith(id: testUser.id + i);
      users.add(newUser);
    }
    final userBoxIndexes = userBox.putMany(users);

    List<User>? callback(Store store, List<int> indexes) {
      final userBox = store.box<User>();
      final users = <User>[];
      final getAllUsers = userBox.getAll();
      final countUsers = userBox.count();
      for (var index in indexes) {
        final user = userBox.get(index);
        if (user != null) {
          users.add(user);
        }
      }
      return getAllUsers;
    }

    final getUsers =
        await dataBaseService.txReadAsync(callback, userBoxIndexes);
    expect(users, getUsers);

    userBox.removeAll();
  });

  test('Write transaction test', () async {
    if (!dataBaseService.hasInitialized) {
      await dataBaseService.init();
    }
    final userBox = dataBaseService.getObjects<User>();

    final users = <User>[];
    for (var i = 0; i < 5; i++) {
      final newUser = testUser.copyWith(id: testUser.id + i);
      users.add(newUser);
    }

    final wroteUsers = dataBaseService.txWrite(() {
      final getAllUsers0 = userBox.getAll();
      final userBoxIndexes = <int>[];
      for (var user in users) {
        userBoxIndexes.add(userBox.put(user));
      }
      return userBox.getMany(userBoxIndexes);
    });

    expect(wroteUsers, users);

    userBox.removeAll();
  });

  test('Write async transaction test', () async {
    if (!dataBaseService.hasInitialized) {
      await dataBaseService.init();
    }
    final userBox = dataBaseService.getObjects<User>();

    final users = <User>[];
    for (var i = 0; i < 5; i++) {
      final newUser = testUser.copyWith(id: testUser.id + i);
      users.add(newUser);
    }
    final userBoxIndexes = userBox.putMany(users);

    List<User>? callback(Store store, List<int> indexes) {
      final userBox = store.box<User>();
      final users = <User>[];
      final getAllUsers = userBox.getAll();
      final countUsers = userBox.count();
      for (var index in indexes) {
        final user = userBox.get(index);
        if (user != null) {
          users.add(user);
        }
      }
      userBox.removeMany(indexes);
      return getAllUsers;
    }

    final getUsers =
        await dataBaseService.txWriteAsync(callback, userBoxIndexes);
    expect(users, getUsers);

    userBox.removeAll();
  });
}
