import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsService {
  SharedPrefsService._();

  static final SharedPrefsService instance = SharedPrefsService._();

  SharedPreferencesWithCache? _prefs;

  bool get isInitialized => _prefs != null;

  Future<void> init() async {
    _prefs = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    );
  }

  SharedPreferencesWithCache get _safePrefs {
    if (_prefs == null) {
      throw StateError(
        'SharedPrefsService.init() çağrılmadan önce veri okunamaz/yazılamaz.',
      );
    }
    return _prefs!;
  }

  /// Bool değer oku
  /// [key] -> okunacak anahtar
  /// [defaultValue] -> key yoksa dönecek varsayılan değer
  bool getBool(String key, {bool defaultValue = false}) =>
      _safePrefs.getBool(key) ?? defaultValue;

  /// Bool değer yaz
  Future<void> setBool(String key, bool value) async =>
      await _safePrefs.setBool(key, value);

  /// String değer oku
  String getString(String key, {String defaultValue = ''}) =>
      _safePrefs.getString(key) ?? defaultValue;

  /// String değer yaz
  Future<void> setString(String key, String value) async =>
      await _safePrefs.setString(key, value);

  /// Int değer oku
  int getInt(String key, {int defaultValue = 0}) =>
      _safePrefs.getInt(key) ?? defaultValue;

  /// Int değer yaz
  Future<void> setInt(String key, int value) async =>
      await _safePrefs.setInt(key, value);

  /// Belirli bir key'i sil
  Future<void> remove(String key) async => await _safePrefs.remove(key);

  /// Tüm SharedPreferences verilerini temizle
  Future<void> clear() async => await _safePrefs.clear();
}
