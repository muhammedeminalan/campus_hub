# 📦 Core — Servisler, Cache, Sabitler & Auth

> **CampusHub** projesinin temel altyapı katmanı.
> Ağ istekleri, yerel önbellekleme, uygulama sabitleri ve kimlik doğrulama modelleri burada yönetilir.

---

## 📑 İçindekiler

1. [Dosya Yapısı](#-dosya-yapısı)
2. [Cache — SharedPrefsService](#-cache--sharedprefsservice)
   - [Başlatma](#başlatma)
   - [Metodlar](#metodlar)
   - [Kullanım Örnekleri](#kullanım-örnekleri)
3. [Services — Network](#-services--network)
   - [DioService](#dioservice)
     - [Yapılandırma](#yapılandırma)
     - [HTTP Metodları](#http-metodları)
     - [Kullanım Örnekleri](#dioservice-kullanım-örnekleri)
   - [NetworkExceptions](#networkexceptions)
     - [Exception Sınıfları](#exception-sınıfları)
     - [Hata Yakalama](#hata-yakalama)
4. [Constants — AppStrings](#-constants--appstrings)
   - [Kategoriler](#kategoriler)
   - [Kullanım](#appstrings-kullanım)
5. [Auth — UserRole](#-auth--userrole)
   - [Kullanım](#userrole-kullanım)

---

## 📁 Dosya Yapısı

```
lib/core/
├── auth/
│   └── user_role.dart              # Kullanıcı rolü enum (student, academic)
├── cache/
│   └── shared_prefs_service.dart   # SharedPreferences wrapper (Singleton)
├── constants/
│   └── app_strings.dart            # Uygulama geneli sabit metinler
├── services/
│   └── network/
│       ├── dio_service.dart        # Dio HTTP client wrapper (Singleton)
│       └── network_exceptions.dart # Özel ağ hata sınıfları
└── utils/                          # → Ayrı README.md mevcut
```

---

## 💾 Cache — SharedPrefsService

> **Dosya:** `cache/shared_prefs_service.dart`

Yeni `SharedPreferencesWithCache` API'sini kullanan modern singleton wrapper.
Basit key-value depolama işlemlerini merkezi bir noktadan yönetir.

### Başlatma

```dart
// Uygulama başlangıcında (app_init.dart içinde)
await SharedPrefsService.instance.init();

// GetIt ile kayıt
sl.registerSingleton<SharedPrefsService>(SharedPrefsService.instance);
```

### Metodlar

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

### Kullanım Örnekleri

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

---

## 🌐 Services — Network

### DioService

> **Dosya:** `services/network/dio_service.dart`

Tüm HTTP isteklerini yöneten Dio tabanlı singleton servis.
Otomatik timeout, logging ve hata yönetimi içerir.

#### Yapılandırma

| Ayar | Değer |
|------|-------|
| Content-Type | `application/json` |
| Accept | `application/json` |
| Connect Timeout | 15 saniye |
| Receive Timeout | 15 saniye |
| Logging | Request/Response body & header |

#### HTTP Metodları

| Metod | İmza | Açıklama |
|-------|------|----------|
| `get` | `Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters})` | GET isteği gönderir |
| `post` | `Future<dynamic> post(String url, {dynamic data})` | POST isteği gönderir |
| `put` | `Future<dynamic> put(String url, {dynamic data})` | PUT isteği gönderir |
| `delete` | `Future<dynamic> delete(String url, {dynamic data})` | DELETE isteği gönderir |

> **Not:** Tüm metodlar full URL alır. Başarısız isteklerde uygun `NetworkException` fırlatılır.

#### DioService Kullanım Örnekleri

```dart
final dio = DioService();

// GET — Duyuruları çek
try {
  final data = await dio.get(
    'https://api.campushub.com/announcements',
    queryParameters: {'page': 1, 'limit': 20},
  );
  print(data);
} on NetworkException catch (e) {
  print('Hata: $e');
}

// POST — Yeni duyuru oluştur
try {
  final result = await dio.post(
    'https://api.campushub.com/announcements',
    data: {
      'title': 'Sınav Tarihleri',
      'content': 'Final sınavları 15 Ocak\'ta başlayacak.',
    },
  );
  print(result);
} on NotFoundException catch (e) {
  print('404: $e');
} on UnauthorizedException catch (e) {
  print('401: $e');
}

// PUT — Güncelle
await dio.put(
  'https://api.campushub.com/announcements/42',
  data: {'title': 'Güncellenmiş Başlık'},
);

// DELETE — Sil
await dio.delete('https://api.campushub.com/announcements/42');
```

---

### NetworkExceptions

> **Dosya:** `services/network/network_exceptions.dart`

Ağ hatalarını kategorize eden özel exception hiyerarşisi.
Tüm sınıflar `NetworkException` base class'ından türer ve `Exception` interface'ini implement eder.

#### Exception Sınıfları

| Sınıf | Varsayılan Mesaj | HTTP Kodu | Açıklama |
|-------|-----------------|-----------|----------|
| `NetworkException` | — | — | **Base class.** Tüm ağ hatalarının üst sınıfı |
| `BadRequestException` | `"Bad Request"` | 400 | Geçersiz istek |
| `UnauthorizedException` | `"Unauthorized"` | 401 | Yetkilendirme hatası |
| `NotFoundException` | `"Not Found"` | 404 | Kaynak bulunamadı |
| `InternalServerErrorException` | `"Internal Server Error"` | 500 / 502 / 503 | Sunucu hatası |
| `DeadlineExceededException` | `"Request Timed Out"` | — | Timeout aşımı |
| `UnknownException` | `"Unknown Error"` | Diğer | Bilinmeyen hata |

#### Hata Yakalama

```dart
try {
  final data = await DioService().get('https://api.campushub.com/users/me');
} on UnauthorizedException {
  // → Login sayfasına yönlendir
} on NotFoundException {
  // → "Kullanıcı bulunamadı" göster
} on DeadlineExceededException {
  // → "Bağlantı zaman aşımına uğradı" göster
} on InternalServerErrorException {
  // → "Sunucu hatası, lütfen tekrar deneyin" göster
} on NetworkException catch (e) {
  // → Genel ağ hatası: e.message
}
```

**DioService iç akışı:**

```
HTTP İsteği
   │
   ├─ Başarılı (200/201) → response.data döner
   │
   ├─ HTTP Hata Kodu → _handleResponse()
   │   ├── 400 → BadRequestException
   │   ├── 401 → UnauthorizedException
   │   ├── 404 → NotFoundException
   │   ├── 500/502/503 → InternalServerErrorException
   │   └── Diğer → UnknownException
   │
   └─ DioException → _handleDioError()
       ├── Timeout → DeadlineExceededException
       ├── Cancel → NetworkException("Request Cancelled")
       └── Diğer → UnknownException
```

---

## 📝 Constants — AppStrings

> **Dosya:** `constants/app_strings.dart`

Uygulama genelinde kullanılan sabit metinleri merkezi bir sınıfta toplar.
`final class` ve private constructor ile instance oluşturulması engellenir.

> **Not:** İleride çoklu dil (l10n) desteği eklendiğinde bu sınıftaki değerler localization sistemine taşınabilir.

### Kategoriler

| Kategori | Sabitler |
|----------|---------|
| **App** | `appName` |
| **Common** | `ok`, `cancel`, `save`, `delete`, `update`, `retry`, `close` |
| **Auth** | `loginTitle`, `email`, `password`, `login`, `logout`, `forgotPassword` |
| **Validation** | `requiredField`, `invalidEmail`, `minPassword6` |
| **Dashboard** | `dashboard`, `announcements`, `courses`, `grades`, `profile` |
| **Errors** | `genericError`, `noInternet` |

### AppStrings Kullanım

```dart
// AppBar başlığı
AppBar(title: Text(AppStrings.appName))

// Buton metni
ElevatedButton(
  onPressed: () {},
  child: Text(AppStrings.login),
)

// Hata mesajı
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(content: Text(AppStrings.noInternet)),
);

// Form validasyonu
TextFormField(
  decoration: InputDecoration(labelText: AppStrings.email),
  validator: (v) => v!.isEmpty ? AppStrings.requiredField : null,
)
```

---

## 🔐 Auth — UserRole

> **Dosya:** `auth/user_role.dart`

Kullanıcı rollerini tanımlayan enum. Rol tabanlı yönlendirme (`RoleGatePage`) ve yetkilendirme kararlarında kullanılır.

| Değer | Açıklama |
|-------|----------|
| `student` | Öğrenci rolü → `/student` rotasına yönlendirilir |
| `academic` | Akademisyen rolü → `/academic` rotasına yönlendirilir |

### UserRole Kullanım

```dart
// Rol kontrolü
if (user.role == UserRole.student) {
  Navigator.pushNamed(context, '/student');
} else {
  Navigator.pushNamed(context, '/academic');
}

// Switch ile kullanım
switch (role) {
  case UserRole.student:
    return StudentHomePage();
  case UserRole.academic:
    return AcademicHomePage();
}
```

---

## 🔗 Bağımlılık Grafiği

```
main.dart
  └── AppInit.init()
        ├── SharedPrefsService.instance.init()  ← Cache
        ├── GetIt (injection_container.dart)
        │     ├── SharedPrefsService  (singleton)
        │     ├── Dio / DioService    (singleton)
        │     ├── AuthRepository      (lazy singleton)
        │     ├── LoginBloc           (factory)
        │     └── AuthBloc            (factory)
        └── MultiBlocProvider
              ├── LoginBloc  → AuthRepository → DioService
              └── AuthBloc   → SharedPrefsService (rol saklama)
```

---

## 📦 Paket Bağımlılıkları

| Paket | Versiyon | Kullanıldığı Yer |
|-------|----------|-----------------|
| `shared_preferences` | ^2.5.4 | `SharedPrefsService` |
| `dio` | ^5.9.1 | `DioService` |
| `get_it` | ^9.2.0 | Tüm servis kayıtları |
| `flutter_bloc` | ^9.1.1 | Auth blokları |

---

> 📘 **Utils (Extensions & Widgets)** dokümantasyonu için → [`utils/README.md`](utils/README.md)
