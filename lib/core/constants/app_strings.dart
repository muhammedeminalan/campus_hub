/// Uygulama genelinde kullanılan sabit metinler.
/// Not: İleride çoklu dil (l10n) yapacaksan buradaki metinleri
/// localization sistemine taşırsın. Şimdilik merkezi yönetim için ideal.
final class AppStrings {
  AppStrings._(); // instance oluşturulmasın

  // App
  static const appName = 'CampusHub';
  //role
  static const student = 'Öğrenci';
  static const teacher = 'Öğretmen';
  // Common
  static const ok = 'Tamam';
  static const cancel = 'İptal';
  static const save = 'Kaydet';
  static const delete = 'Sil';
  static const update = 'Güncelle';
  static const retry = 'Tekrar dene';
  static const close = 'Kapat';

  // Auth
  static const loginTitle = 'Giriş Yap';
  static const email = 'E-posta';
  static const password = 'Şifre';
  static const login = 'Giriş';
  static const logout = 'Çıkış Yap';
  static const forgotPassword = 'Şifremi Unuttum';

  // Validation (örnek)
  static const requiredField = 'Bu alan zorunludur';
  static const invalidEmail = 'Geçerli bir e-posta gir';
  static const minPassword6 = 'Şifre en az 6 karakter olmalı';

  // Dashboard
  static const dashboard = 'Ana Sayfa';
  static const announcements = 'Duyurular';
  static const courses = 'Dersler';
  static const grades = 'Notlar';
  static const profile = 'Profil';

  // Errors
  static const genericError = 'Bir hata oluştu';
  static const noInternet = 'İnternet bağlantısı yok';

  // TextField'ler için
  static const name = "Ad";
  static const surname = "Soyad";
  static const studentNo = "Öğrenci Numarası";
  static const studentClass = "Sınıf";
  static const studentDepartment = "Bölüm";
  static const studentFaculty = "Fakülte";
  static const studentUniversity = "Üniversite";
  static const studentPhone = "Telefon Numarası";
  static const studentEmail = "E-posta Adresi";
  static const studentPassword = "Şifre";

  //Strings
  static const welcome = 'Hoşgeldiniz';
  static const home = 'Ana Sayfa';
  static const settings = 'Ayarlar';
  static const studentInfo = 'Öğrenci Bilgileri';
  static const profileSettings = 'Profil Ayarları';
  static const notifications = 'Bildirimler';
  static const studentNumber = "Öğrenci Numarası";
  static const teacherNumber = "Öğretmen Numarası";
}
