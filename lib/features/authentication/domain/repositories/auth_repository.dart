import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/app_exception.dart';
import '../../../../core/services/auth_service/user_cache_service/data/models/user/user_model.dart';

abstract class AuthenticationRepository {
  Future<Either<AppException, User>> loginUser({required User user});
}
