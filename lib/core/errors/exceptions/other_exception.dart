import 'app_exception.dart';

class OtherException implements AppException {
  @override
  // TODO: implement identifier
  String? get identifier => throw UnimplementedError();

  @override
  // TODO: implement message
  String? get message => throw UnimplementedError();

  @override
  // TODO: implement statusCode
  int? get statusCode => throw UnimplementedError();
}
