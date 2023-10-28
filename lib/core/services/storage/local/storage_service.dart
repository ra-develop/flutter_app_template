/// Storage service interface
abstract class StorageService {
  Future<bool> init();

  bool get hasInitialized;

  Future<bool> remove(String key);

  Future<Object?> get(String key);

  Future<bool> set(String key, Object data);

  Future<void> clear();

  Future<bool> has(String key);
}
