import 'package:dartz/dartz.dart';

import '../../../../core/domain/models/user/user_model.dart';
import '../../../../core/errors/exceptions/app_exception.dart';

abstract class AuthenticationRepository {
  Future<Either<AppException, User>> loginUser({required User user});
}
