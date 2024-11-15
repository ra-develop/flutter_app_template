import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/app_exception.dart';
import '../../data/models/user/user_model.dart';

abstract class UserRepository {
  Future<Either<AppException, User>> fetchUser();

  Future<bool> saveUser({required User user});

  Future<bool> deleteUser();

  Future<bool> hasUser();
}
