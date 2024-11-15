import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/app_exception.dart';
import '../../../../core/services/storage/local/storage_service.dart';
import '../../../../environment/config/config.dart';
import '../models/user/user_model.dart';

abstract class UserDataSource {
  String get storageKey;

  Future<Either<AppException, User>> fetchUser();

  Future<bool> saveUser({required User user});

  Future<bool> deleteUser();

  Future<bool> hasUser();
}

class UserLocalDatasource extends UserDataSource {
  UserLocalDatasource(this.storageService);

  final StorageService storageService;

  @override
  String get storageKey => Config.USER_LOCAL_STORAGE_KEY;

  @override
  Future<Either<AppException, User>> fetchUser() async {
    final data = await storageService.get(storageKey);

    final user = JsonMapper.deserialize<User>(data);

    if (data == null || user == null) {
      return Left(
        AppException(
          identifier: 'UserLocalDatasource',
          statusCode: 404,
          message: 'User not found',
        ),
      );
    }
    return Right(user);

    // if (data == null) {
    //   return Left(
    //     AppException(
    //       identifier: 'UserLocalDatasource',
    //       statusCode: 404,
    //       message: 'User not found',
    //     ),
    //   );
    // }
    // final userJson = jsonDecode(data.toString());

    // return Right(User.fromJson(userJson));
  }

  @override
  Future<bool> saveUser({required User user}) async {
    return await storageService.set(storageKey, JsonMapper.serialize(user));

    // return await storageService.set(storageKey, jsonEncode(user.toJson()));
  }

  @override
  Future<bool> deleteUser() async {
    return await storageService.remove(storageKey);
  }

  @override
  Future<bool> hasUser() async {
    return await storageService.has(storageKey);
  }
}
