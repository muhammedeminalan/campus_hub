# CampusHub

**CampusHub**, üniversite öğrenci bilgi sistemi (ÖBS/ÜBS) mantığında çalışan bir **Flutter** mobil uygulama projesidir.  
Uygulama yalnızca **Android** ve **iOS** platformlarını hedefler.

---

## Özellikler

- Rol tabanlı giriş (Öğrenci / Akademisyen)
- Firebase Authentication ile kimlik doğrulama
- Ders listesi ve dönem filtreleme
- Sınav sonuçları görüntüleme
- Hızlı menü (Quick Menu) ile öğrenci hizmetlerine erişim
- Akademik takvim görüntüleme
- Öğrenci kartı bilgileri

---

## Mimari

Proje **Clean Architecture** prensiplerine göre yapılandırılmıştır.

```
lib/
├── config/
│   ├── init/            # AppBlocObserver, injection_container (GetIt DI)
│   ├── providers/       # Global BlocProvider tanımları
│   └── theme/           # Uygulama teması
├── core/
│   ├── cache/           # SharedPrefsService
│   ├── constants/       # Uygulama sabitleri
│   ├── contracts/       # Soyut arayüzler (AuthBase, ITokenProvider, ISecureStorage, IService…)
│   ├── mock/            # Mock servisler ve fixture verileri
│   ├── models/          # Paylaşılan veri modelleri
│   ├── services/        # Servis implementasyonları (Firebase, Dio, SecureStorage)
│   └── ui/              # Paylaşılan UI bileşenleri
└── features/
    ├── auth/            # Giriş UI, LoginBloc, SignInUseCase, SignOutUseCase
    ├── bottom_navigation/
    ├── courses/         # CoursesC ubit, FilterCoursesByPeriodUseCase
    ├── exam_results/
    ├── home/            # HomeCubit, IStudentService, AcademicCalendarModel
    └── quick_menu/      # QuickMenuRoute enum, QuickMenuNavigator
```

### Katmanlar

| Katman | Sorumluluk |
|---|---|
| **Domain / UseCase** | İş kuralları (`SignInUseCase`, `SignOutUseCase`, `FilterCoursesByPeriodUseCase`) |
| **Data / Services** | Firebase, Dio, SecureStorage implementasyonları |
| **Presentation** | BLoC / Cubit + Widget |

---

## Kullanılan Teknolojiler

| Alan | Paket |
|---|---|
| State Management | `flutter_bloc ^9.1.1` |
| Dependency Injection | `get_it ^9.2.0` |
| Networking | `dio ^5.9.1` |
| Authentication | `firebase_auth ^6.1.4` |
| Database | `cloud_firestore ^6.1.2` |
| Storage | `firebase_storage ^13.0.6` |
| Local Storage | `shared_preferences ^2.5.4` |
| Secure Storage | `flutter_secure_storage ^9.2.4` |
| Utilities | `wonky_core_utils ^0.2.1` |

---

## Güvenlik

- API isteklerinde Bearer token `DioService` interceptor'ı üzerinden otomatik eklenir
- Firebase ID token, `ITokenProvider` arayüzü aracılığıyla sağlanır
- Hassas veriler `flutter_secure_storage` ile şifrelenmiş olarak saklanır  
  (Android: EncryptedSharedPreferences, iOS: Keychain)
- `LogInterceptor` request body / header kaydını devre dışı bırakır (şifre sızıntısı önleme)
- 401 yanıtında auth interceptor otomatik `signOut` tetikler

---

## Başlarken

### Gereksinimler

- Flutter SDK `^3.11.0`
- Firebase projesi (Android: `google-services.json`, iOS: `GoogleService-Info.plist`)

### Kurulum

```bash
# Bağımlılıkları yükle
flutter pub get

# Uygulamayı çalıştır
flutter run
```

---

## Testler

```bash
# Tüm testleri çalıştır
flutter test

# Sadece feature testleri
flutter test test/features/

# Statik analiz
flutter analyze
```

Test kapsamı:

| Dosya | İçerik |
|---|---|
| `login_bloc_test.dart` | `LoginBloc` — 4 senaryo |
| `sign_in_use_case_test.dart` | `SignInUseCase` — validasyon + delegasyon |
| `filter_courses_use_case_test.dart` | `FilterCoursesByPeriodUseCase` — pure logic |
| `courses_cubit_test.dart` | `CoursesCubit` — 3 senaryo |

---

## Hedef Platformlar

- Android (minSdk 21+)
- iOS (12.0+)
