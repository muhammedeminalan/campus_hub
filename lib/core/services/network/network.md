# 🌐 Services — Network

---

## DioService

> **Dosya:** `dio_service.dart`

Tüm HTTP isteklerini yöneten Dio tabanlı singleton servis.
Otomatik timeout, logging ve hata yönetimi içerir.

### Yapılandırma

| Ayar | Değer |
|------|-------|
| Content-Type | `application/json` |
| Accept | `application/json` |
| Connect Timeout | 15 saniye |
| Receive Timeout | 15 saniye |
| Logging | Request/Response body & header |

### HTTP Metodları

| Metod | İmza | Açıklama |
|-------|------|----------|
| `get` | `Future<dynamic> get(String url, {Map<String, dynamic>? queryParameters})` | GET isteği gönderir |
| `post` | `Future<dynamic> post(String url, {dynamic data})` | POST isteği gönderir |
| `put` | `Future<dynamic> put(String url, {dynamic data})` | PUT isteği gönderir |
| `delete` | `Future<dynamic> delete(String url, {dynamic data})` | DELETE isteği gönderir |

> **Not:** Tüm metodlar full URL alır. Başarısız isteklerde uygun `NetworkException` fırlatılır.

### Kullanım Örnekleri

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

## NetworkExceptions

> **Dosya:** `network_exceptions.dart`

Ağ hatalarını kategorize eden özel exception hiyerarşisi.
Tüm sınıflar `NetworkException` base class'ından türer ve `Exception` interface'ini implement eder.

### Exception Sınıfları

| Sınıf | Varsayılan Mesaj | HTTP Kodu | Açıklama |
|-------|-----------------|-----------|----------|
| `NetworkException` | — | — | **Base class.** Tüm ağ hatalarının üst sınıfı |
| `BadRequestException` | `"Bad Request"` | 400 | Geçersiz istek |
| `UnauthorizedException` | `"Unauthorized"` | 401 | Yetkilendirme hatası |
| `NotFoundException` | `"Not Found"` | 404 | Kaynak bulunamadı |
| `InternalServerErrorException` | `"Internal Server Error"` | 500 / 502 / 503 | Sunucu hatası |
| `DeadlineExceededException` | `"Request Timed Out"` | — | Timeout aşımı |
| `UnknownException` | `"Unknown Error"` | Diğer | Bilinmeyen hata |

### Hata Yakalama

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

### İç Akış

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

## Paket Bağımlılığı

| Paket | Versiyon |
|-------|----------|
| `dio` | ^5.9.1 |
