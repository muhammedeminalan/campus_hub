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
  static const loadError = 'Veriler yüklenemedi';

  // ── QR ─────────────────────────────────────────────────────────────────────
  static const qrCodeScanner = 'QR Kod Tarama';
  static const qrCodeScannerOpened = 'QR kod tarama açıldı';
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
  static const courses = 'Alınan Dersler';
  static const grades = 'Notlar';
  static const studentInfo = 'Öğrenci Bilgileri';
  static const profileSettings = 'Profil Ayarları';
  static const takenCourses = 'Alınan Dersler';
  static const quickMenu = 'Hızlı Menü';
  static const examResults = 'Sınav Sonuçları';

  // ── Hızlı Menü Öğeleri ───────────────────────────────────────────────────────
  // Not: takenCourses ve examResults yukarıda zaten tanımlı, onlar kullanılır.
  static const attendance = 'Yoklama';
  static const examSchedule = 'Sınav Takvimi';
  static const academicCalendar = 'Akademik Takvim';
  static const termAverages = 'Dönem Ortalamaları';
  static const transcript = 'Transkript';
  static const courseSchedule = 'Ders Programı';
  static const tuitionInfo = 'Harç Bilgileri';
  static const absenceStatus = 'Devamsızlık Durumu';
  static const academicStatus = 'Akademik Durum';
  static const curriculum = 'Müfredat';
  static const todos = 'Yapılacaklar';
  static const academicAdvisor = 'Akademik Danışman';
  static const preparatoryInfo = 'Hazırlık Bilgileri';

  // ── Müfredat ────────────────────────────────────────────────────────────────
  static const curriculumLoadError = 'Müfredat yüklenemedi';
  static const curriculumLoadErrorSub = 'Lütfen tekrar deneyin.';
  static const curriculumClassFilterTitle = 'Sınıf';
  static const curriculumSemesterFilterTitle = 'Dönem';
  static const curriculumFilterSheetTitle = 'Müfredat Filtreleri';
  static const curriculumFilterHelper =
      'Önce sınıfı, sonra dönemi seçerek müfredatı daraltın.';
  static const curriculumSelectedTitle = 'Seçili Müfredat';
  static const curriculumSelectedSub =
      'Filtrelerinize göre güncel ders planı listeleniyor.';
  static const curriculumListTitle = 'Ders Planı';
  static const curriculumSelectedCourseCount = 'Ders';
  static const curriculumTotalCredit = 'Toplam Kredi';
  static const curriculumTotalAkts = 'Toplam AKTS';
  static const curriculumResetFilters = 'Filtreleri Sıfırla';
  static const curriculumApplyFilters = 'Uygula';
  static const curriculumNotFound = 'Müfredat Bulunamadı';
  static const curriculumCompulsory = 'Zorunlu';
  static const curriculumElective = 'Seçmeli';
  static const curriculumCredit = 'Kredi';
  static const curriculumAkts = 'AKTS';

  static String curriculumClassLabel(int classLevel) => '$classLevel. Sınıf';

  static String curriculumSemesterLabel(int semester) => '$semester. Dönem';

  static String curriculumNotFoundSub({
    required int? classLevel,
    required int? semester,
  }) {
    if (classLevel == null || semester == null) {
      return 'Seçili kategoriye ait müfredat kaydı mevcut değil.';
    }

    return '$classLevel. sınıf $semester. dönem için müfredat henüz eklenmedi.';
  }

  // ── Dersler ─────────────────────────────────────────────────────────────────
  static const selectPeriod = 'Dönem Seçiniz';
  static const coursesLoadError = 'Veriler yüklenemedi';
  static const coursesLoadErrorSub = 'Lütfen tekrar deneyin.';
  static const coursesRetry = 'Yeniden Dene';
  static const courseNotFound = 'Ders Bulunamadı';
  static const courseNotFoundSub = 'Seçili döneme ait ders kaydı mevcut değil.';
  static const periodNotFound = 'Dönem Bulunamadı';
  static const periodNotFoundSub = 'Kayıtlı dönem bilgisi mevcut değil.';

  // ── Profil Kartı – İstatistik Etiketleri ─────────────────────────────────────
  // Not: Sınıf etiketi için AppStrings.studentClass kullanılır.
  static const ano = 'ANO';
  static const agno = 'AGNO';

  // ── Sınav türü etiketleri ────────────────────────────────────────────────────
  static const examVize = 'Vize';
  static const examFinal = 'Final';
  static const examButunleme = 'Bütünleme';

  // ── Sınav sonucu boş durum ───────────────────────────────────────────────────
  static const examResultNotFound = 'Sınav Sonucu Bulunamadı';
  static String examResultNotFoundSub(String period) =>
      '$period dönemine ait sınav\nkaydı mevcut değil.';

  // ── Akademik Danışman ────────────────────────────────────────────────────────
  static const academicAdvisorLoadError = 'Danışman bilgisi yüklenemedi';
  static const academicAdvisorLoadErrorSub = 'Lütfen tekrar deneyin.';
  static const contactInfo = 'İletişim Bilgileri';
  static const officeHoursLabel = 'Görüşme Saatleri';

  // ── Yapılacaklar ───────────────────────────────────────────────────────────
  static const todosLoadError = 'Yapılacaklar yüklenemedi';
  static const todosLoadErrorSub = 'Lütfen tekrar deneyin.';
  static const todoSummaryTitle = 'Bugünkü Yapılacaklar';
  static const todoTotal = 'Toplam';
  static const todoPending = 'Bekleyen';
  static const todoCompleted = 'Tamamlanan';
  static const todoOverdue = 'Geciken';
  static const todoFilterTitle = 'Durum Filtresi';
  static const todoFilterAll = 'Tümü';
  static const todoFilterPending = 'Bekleyen';
  static const todoFilterCompleted = 'Tamamlanan';
  static const todoFilterOverdue = 'Geciken';
  static const todoEmptyTitle = 'Gösterilecek görev bulunamadı';
  static const todoEmptySubTitle =
      'Seçili filtreye uygun görev yok. Farklı filtre deneyebilirsin.';
  static const todoPriorityLow = 'Düşük';
  static const todoPriorityMedium = 'Orta';
  static const todoPriorityHigh = 'Yüksek';
  static const todoNoDueDate = 'Tarih yok';
  static const todoDueToday = 'Bugün';
  static const todoDueTomorrow = 'Yarın';
  static const todoMarkAsCompleted = 'Tamamlandı işaretle';
  static const todoMarkAsPending = 'Bekleyen yap';

  static String todoDueInDays(int dayCount) => '$dayCount gün kaldı';

  static String todoOverdueByDays(int dayCount) => '$dayCount gün gecikti';

  // ── Arama ────────────────────────────────────────────────────────────────────
  static const searchHint = 'Menüde ara…';
  static const searchNoResult = 'Sonuç bulunamadı';

  // ── Hızlı Menü Kategorileri ──────────────────────────────────────────────────
  static const categoryAttendance = 'Yoklama & Takvimler';
  static const categoryCoursesExams = 'Dersler & Sınavlar';
  static const categoryAcademic = 'Akademik Bilgiler';
  static const categoryStatus = 'Durum & Müfredat';
  static const categoryOther = 'Diğer';

  // ── Takvim ───────────────────────────────────────────────────────────────────
  static String eventsCountLabel(int count) => '$count etkinlik';

  // ── Navigasyon kısa etiketleri ───────────────────────────────────────────────
  static const navCourses = 'Dersler';

  // ── Sınav Sonuçları Özet Kartı ──────────────────────────────────────────────
  static const summaryTitle = 'Dönem Özeti';
  static const summaryCourseCount = 'Toplam Ders';
  static const summaryPassed = 'Geçti';
  static const summaryFailed = 'Kaldı';
  static const summaryAvgScore = 'Ort. Puan';
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
