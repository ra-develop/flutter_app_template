// extension
import 'package:dartz/dartz.dart';

import '../../services/response.dart';
import 'app_exception.dart';

extension HttpExceptionExtension on AppException {
  Left<AppException, Response> get toLeft => Left<AppException, Response>(this);
}
