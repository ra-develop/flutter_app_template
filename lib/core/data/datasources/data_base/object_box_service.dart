import 'package:app_template/core/data/datasources/data_base/object_box.dart';
import 'package:app_template/core/services/storage/data_base/data_base_service.dart';

import '../../../../objectbox.g.dart';

class ObjectBoxService implements DataBaseService {
  @override
  bool get hasInitialized => _objectBox != null;

  ObjectBox? _objectBox;
  late Store _store;

  @override
  Future<bool> init() async {
    try {
      _objectBox = await ObjectBox.create();
      if (_objectBox != null) {
        _store = _objectBox!.store;
        return Future.value(true);
      } else {
        // TODO implement the app exception handler generation
        return Future.value(false);
      }
    } catch (e) {
      // TODO implement the app exception handler of an error
      return Future.value(false);
    }
  }

  @override
  Box<T> getObjects<T>() {
    return _store.box<T>();
  }

  @override
  R txRead<R>(R Function() transaction) {
    return _store.runInTransaction(TxMode.read, transaction);
  }

  @override
  R txWrite<R>(R Function() transaction) {
    return _store.runInTransaction(TxMode.write, transaction);
  }

  @override
  Future<R> txReadAsync<R, P>(
      R Function(Store store, P param) callback, P param) async {
    return await _store.runInTransactionAsync(TxMode.read, callback, param);
  }

  @override
  Future<R> txWriteAsync<R, P>(
      R Function(Store store, P param) callback, P param) async {
    return await _store.runInTransactionAsync(TxMode.write, callback, param);
  }
}
