import 'package:app_template/core/errors/exceptions/app_exception.dart';
import 'package:app_template/core/services/response.dart';
import 'package:app_template/features/authentication/data/models/user/user_model.dart';

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
