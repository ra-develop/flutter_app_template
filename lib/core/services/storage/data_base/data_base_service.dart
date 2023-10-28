/// Data Base service interface
abstract class DataBaseService {
  Future<bool> init();

  bool get hasInitialized;
}
