# 💾 Cache — SharedPrefsService

> **Dosya:** `shared_prefs_service.dart`

Yeni `SharedPreferencesWithCache` API'sini kullanan modern singleton wrapper.
Basit key-value depolama işlemlerini merkezi bir noktadan yönetir.

---

## Başlatma

```dart
// Uygulama başlangıcında (app_init.dart içinde)
await SharedPrefsService.instance.init();

// GetIt ile kayıt
sl.registerSingleton<SharedPrefsService>(SharedPrefsService.instance);
```

## Metodlar

| Metod | İmza | Açıklama |
|-------|------|----------|
| `init` | `Future<void> init()` | `SharedPreferencesWithCache` bağlantısını kurar. **Uygulama başlangıcında çağrılmalı.** |
| `getBool` | `bool getBool(String key, {bool defaultValue = false})` | Bool değer okur, yoksa `defaultValue` döner |
| `setBool` | `Future<void> setBool(String key, bool value)` | Bool değer yazar |
| `getString` | `String getString(String key, {String defaultValue = ''})` | String değer okur, yoksa `defaultValue` döner |
| `setString` | `Future<void> setString(String key, String value)` | String değer yazar |
| `getInt` | `int getInt(String key, {int defaultValue = 0})` | Int değer okur, yoksa `defaultValue` döner |
| `setInt` | `Future<void> setInt(String key, int value)` | Int değer yazar |
| `remove` | `Future<void> remove(String key)` | Belirli bir key'i siler |
| `clear` | `Future<void> clear()` | Tüm SharedPreferences verilerini temizler |

## Kullanım Örnekleri

```dart
final prefs = sl<SharedPrefsService>();

// Tema tercihi kaydetme
await prefs.setBool('isDarkMode', true);
final isDark = prefs.getBool('isDarkMode'); // true

// Token saklama
await prefs.setString('authToken', 'eyJhbGciOi...');
final token = prefs.getString('authToken');

// Giriş sayısı
await prefs.setInt('loginCount', 5);
final count = prefs.getInt('loginCount'); // 5

// Belirli key silme
await prefs.remove('authToken');

// Tüm cache temizleme (logout senaryosu)
await prefs.clear();
```

## Paket Bağımlılığı

| Paket | Versiyon |
|-------|----------|
| `shared_preferences` | ^2.5.4 |
