/// Hassas verilerin (token, session key) şifreli saklandığı
/// depolama katmanı sözleşmesi.
///
/// Implementasyon örnekleri:
/// ```dart
/// class FlutterSecureStorageService implements ISecureStorage { ... }
/// class MockSecureStorage implements ISecureStorage { ... }
/// ```
abstract interface class ISecureStorage {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
}
