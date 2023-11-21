import 'package:app_template/core/errors/exceptions/app_exception.dart';
import 'package:app_template/core/services/auth_service/user_cache_service/data/models/user/user_model.dart';
import 'package:app_template/core/services/response.dart';

import 'data/user_map.dart';

final AppException ktestAppException =
    AppException(message: '', statusCode: 0, identifier: '');

final User ktestUser = testUser;

// final User ktestUserFromMap = testUser;

// final User ktestUser = User.fromJson(const {});
//
// final User ktestUserFromMap = User.fromJson(ktestUserMap);

final Response ktestUserResponse =
    Response(statusMessage: 'message', statusCode: 1, data: {});
