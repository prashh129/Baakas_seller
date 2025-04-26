import 'package:get_storage/get_storage.dart';

class BaakasLocalStorage {
  static const String _defaultBucket = 'baakas_default';
  final GetStorage _storage;

  // Singleton instance
  static BaakasLocalStorage? _instance;

  BaakasLocalStorage._internal(String bucketName)
    : _storage = GetStorage(bucketName);

  /// Create a named constructor to obtain an instance with a specific bucket name
  factory BaakasLocalStorage.instance() {
    _instance ??= BaakasLocalStorage._internal(_defaultBucket);
    return _instance!;
  }

  /// Asynchronous initialization method
  static Future<void> init(String bucketName) async {
    // Initialize GetStorage with the bucket name
    await GetStorage.init(bucketName);
    // Create the instance with the initialized storage
    _instance = BaakasLocalStorage._internal(bucketName);
  }

  /// Generic method to save data
  Future<void> writeData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  /// Generic method to read data
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Clear all data in storage
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
