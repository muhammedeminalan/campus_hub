/// Uygulama genelinde kullanılan sabit metinler.
/// Not: İleride çoklu dil (l10n) yapacaksan buradaki metinleri
/// localization sistemine taşırsın. Şimdilik merkezi yönetim için ideal.
final class AppStrings {
  AppStrings._(); // instance oluşturulmasın

  // ── Uygulama ─────────────────────────────────────────────────────────────────
  static const appName = 'CampusHub';

  // ── Roller ───────────────────────────────────────────────────────────────────
  static const student = 'Öğrenci';
  static const teacher = 'Öğretmen';

  // ── Navigasyon ───────────────────────────────────────────────────────────────
  static const home = 'Ana Sayfa';
  static const profile = 'Profil';
  static const settings = 'Ayarlar';
  static const notifications = 'Bildirimler';

  // ── Ortak İşlemler ───────────────────────────────────────────────────────────
  static const welcome = 'Hoşgeldiniz';
  static const ok = 'Tamam';
  static const cancel = 'İptal';
  static const save = 'Kaydet';
  static const delete = 'Sil';
  static const update = 'Güncelle';
  static const retry = 'Tekrar dene';
  static const close = 'Kapat';

  // ── Auth ─────────────────────────────────────────────────────────────────────
  static const loginTitle = 'Giriş Yap';
  static const email = 'E-posta';
  static const password = 'Şifre';
  static const login = 'Giriş';
  static const logout = 'Çıkış Yap';
  static const forgotPassword = 'Şifremi Unuttum';

  // ── Doğrulama ────────────────────────────────────────────────────────────────
  static const requiredField = 'Bu alan zorunludur';
  static const invalidEmail = 'Geçerli bir e-posta gir';
  static const minPassword6 = 'Şifre en az 6 karakter olmalı';

  // ── Hatalar ──────────────────────────────────────────────────────────────────
  static const genericError = 'Bir hata oluştu';
  static const noInternet = 'İnternet bağlantısı yok';

  // ── Form Alanları ─────────────────────────────────────────────────────────────
  static const name = 'Ad';
  static const surname = 'Soyad';
  static const studentNo = 'Öğrenci Numarası';
  static const teacherNumber = 'Öğretmen Numarası';
  static const studentClass = 'Sınıf';
  static const studentDepartment = 'Bölüm';
  static const studentFaculty = 'Fakülte';
  static const studentUniversity = 'Üniversite';
  static const studentPhone = 'Telefon Numarası';
  static const studentEmail = 'E-posta Adresi';
  static const studentPassword = 'Şifre';

  // ── Ana Sayfa İçeriği ─────────────────────────────────────────────────────────
  static const announcements = 'Duyurular';
  static const courses = 'Dersler';
  static const grades = 'Notlar';
  static const studentInfo = 'Öğrenci Bilgileri';
  static const profileSettings = 'Profil Ayarları';
  static const takenCourses = 'Alınan Dersler';
  static const quickMenu = 'Hızlı Menü';
  static const examResults = 'Sınav Sonuçları';

  // ── Profil Kartı – İstatistik Etiketleri ─────────────────────────────────────
  // Not: Sınıf etiketi için AppStrings.studentClass kullanılır.
  static const ano = 'ANO';
  static const agno = 'AGNO';

  // ── Profil Kartı – Mock Veri ──────────────────────────────────────────────────
  static const studentCardName = 'Muhammed Emin Alan';
  static const studentCardNo = '2402131041';
  static const studentCardUniversity = 'Gümüşhane Üniversitesi';
  static const studentCardDepartment = 'Yönetim Bilişim Sistemleri';
  static const studentCardClass = '3';
  static const studentCardFaculty = 'İktisadi ve İdari Bilimler Fakültesi';
  static const studentCardDateTime = '20.10.2024';
  static const studentCardANO = '2.45';
  static const studentCardAGNO = '2.50';
}
