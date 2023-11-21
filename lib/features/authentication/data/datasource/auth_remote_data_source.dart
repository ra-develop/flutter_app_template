import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions/app_exception.dart';
import '../../../../core/services/auth_service/user_cache_service/data/models/user/user_model.dart';
import '../../../../core/services/storage/remote/network_service.dart';

abstract class LoginUserDataSource {
  Future<Either<AppException, User>> loginUser({required User user});
}

class LoginUserRemoteDataSource implements LoginUserDataSource {
  final NetworkService networkService;

  LoginUserRemoteDataSource(this.networkService);

  @override
  Future<Either<AppException, User>> loginUser({required User user}) async {
    try {
      final eitherType = await networkService.post(
        '/auth/login',
        data: JsonMapper.toMap(user),
      );
      return eitherType.fold(
        (exception) {
          return Left(exception);
        },
        (response) {
          final user = JsonMapper.deserialize<User>(response.data);
          if (user != null) {
            // update the token for requests
            networkService.updateHeader(
              {'Authorization': user.token},
            );
            return Right(user);
          } else {
            return Left(
              AppException(
                message: 'Unknown error occurred',
                statusCode: 1,
                identifier: 'LoginUserRemoteDataSource.loginUser',
              ),
            );
          }
        },
      );
    } catch (e) {
      return Left(
        AppException(
          message: 'Unknown error occurred',
          statusCode: 1,
          identifier: '${e.toString()}\nLoginUserRemoteDataSource.loginUser',
        ),
      );
    }
  }
}
