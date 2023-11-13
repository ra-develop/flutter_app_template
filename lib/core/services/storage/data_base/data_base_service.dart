import '../../../../objectbox.g.dart';

/// Data Base service interface
abstract class DataBaseService {
  Future<bool> init();

  bool get hasInitialized;

  Box<T> getObjects<T>();

  R txRead<R>(R Function() transaction);

  R txWrite<R>(R Function() transaction);

  Future<R> txReadAsync<R, P>(
      R Function(Store store, P param) callback, P param);

  Future<R> txWriteAsync<R, P>(
      R Function(Store store, P param) callback, P param);
}
