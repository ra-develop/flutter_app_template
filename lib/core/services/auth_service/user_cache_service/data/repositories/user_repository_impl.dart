import 'package:dartz/dartz.dart';

import '../../../../../errors/exceptions/app_exception.dart';
import '../../domain/repositories/user_cache_repository.dart';
import '../datasource/user_local_datasource.dart';
import '../models/user/user_model.dart';

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this.dataSource);

  final UserDataSource dataSource;

  @override
  Future<bool> deleteUser() {
    return dataSource.deleteUser();
  }

  @override
  Future<Either<AppException, User>> fetchUser() {
    return dataSource.fetchUser();
  }

  @override
  Future<bool> saveUser({required User user}) {
    return dataSource.saveUser(user: user);
  }

  @override
  Future<bool> hasUser() {
    return dataSource.hasUser();
  }
}
