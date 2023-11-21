import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/app_exception.dart';
import '../../../../core/services/auth_service/user_cache_service/data/models/user/user_model.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_remote_data_source.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final LoginUserDataSource dataSource;

  AuthenticationRepositoryImpl(this.dataSource);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) {
    return dataSource.loginUser(user: user);
  }
}
