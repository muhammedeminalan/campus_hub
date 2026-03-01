import 'package:campus_hub/core/contracts/storage/i_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// [ISecureStorage] implementasyonu.
///
/// Android'de Keystore, iOS'ta Keychain kullanır.
/// SharedPreferences'ın aksine root'lu cihazlarda da şifreli kalır.
final class SecureStorageService implements ISecureStorage {
  SecureStorageService()
    : _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
      );

  final FlutterSecureStorage _storage;

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: key, value: value);

  @override
  Future<String?> read(String key) => _storage.read(key: key);

  @override
  Future<void> delete(String key) => _storage.delete(key: key);

  @override
  Future<void> deleteAll() => _storage.deleteAll();
}
