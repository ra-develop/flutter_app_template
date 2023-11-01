import 'dart:async';

import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/storage/local/storage_service.dart';

class SharedPrefsService implements StorageService {
  SharedPreferences? sharedPreferences;

  @override
  Future<bool> init() async {
    try {
      sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences != null) {
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
  bool get hasInitialized => sharedPreferences != null;

  @override
  Future<Object?> get(String key) async {
    // sharedPreferences = await initCompleter.future;
    return sharedPreferences?.get(key);
  }

  @override
  Future<void> clear() async {
    // sharedPreferences = await initCompleter.future;
    await sharedPreferences?.clear();
  }

  @override
  Future<bool> has(String key) async {
    // sharedPreferences = await initCompleter.future;
    return sharedPreferences?.containsKey(key) ?? false;
  }

  @override
  Future<bool> remove(String key) async {
    // sharedPreferences = await initCompleter.future;
    return await sharedPreferences?.remove(key) ?? false;
  }

  @override
  Future<bool> set(String key, Object data) async {
    // sharedPreferences = await initCompleter.future;
    if (sharedPreferences != null) {
      switch (data.runtimeType) {
        case bool:
          return await sharedPreferences!.setBool(key, data as bool);
        case String:
          return await sharedPreferences!.setString(key, data as String);
        case int:
          return await sharedPreferences!.setInt(key, data as int);
        case double:
          return await sharedPreferences!.setDouble(key, data as double);
        default:
          try {
            final jsonString = JsonMapper.serialize(data);
            return await sharedPreferences!.setString(key, jsonString);
          } catch (e) {
            final dataString = data.toString();
            return await sharedPreferences!.setString(key, dataString);
          }
      }
    }
    return Future.value(false);
  }
}
