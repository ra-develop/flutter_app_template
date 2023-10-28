import 'package:dartz/dartz.dart';

import '../../../../../domain/models/user/user_model.dart';
import '../../../../../errors/exceptions/app_exception.dart';

abstract class UserRepository {
  Future<Either<AppException, User>> fetchUser();

  Future<bool> saveUser({required User user});

  Future<bool> deleteUser();

  Future<bool> hasUser();
}
