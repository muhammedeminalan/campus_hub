final class AcademicCalendarModel {
  final String title;
  final DateTime startDate;
  final DateTime? endDate;
  final AcademicCalendarCategory category;

  const AcademicCalendarModel({
    required this.title,
    required this.startDate,
    required this.category,
    this.endDate,
  });

  bool get isRange => endDate != null;

  // CalendarEventCard için gün — "02"
  String get day => startDate.day.toString().padLeft(2, '0');

  // CalendarEventCard için ay — "Şubat"
  String get monthName => _monthNames[startDate.month - 1];

  // CalendarEventCard için tarih aralığı — tek gün: "02 Şubat", aralık: "02 Şubat - 25 Şubat"
  String get dateRange {
    if (!isRange) return _formatDate(startDate);
    return '${_formatDate(startDate)} - ${_formatDate(endDate!)}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} ${_monthNames[date.month - 1]}';
  }

  static const List<String> _monthNames = [
    'Ocak',
    'Şubat',
    'Mart',
    'Nisan',
    'Mayıs',
    'Haziran',
    'Temmuz',
    'Ağustos',
    'Eylül',
    'Ekim',
    'Kasım',
    'Aralık',
  ];

  // Mock veriler — ileride BLoC/Riverpod'dan gelecek
  static final List<AcademicCalendarModel> calendarEvents = [
    // Eylül — Kayıt & Başlangıç
    AcademicCalendarModel(
      title: 'Güz Dönemi Ders Kayıtları',
      startDate: DateTime(2025, 9, 1),
      endDate: DateTime(2025, 9, 5),
      category: AcademicCalendarCategory.kayit,
    ),
    AcademicCalendarModel(
      title: 'Derslerin Başlangıcı',
      startDate: DateTime(2025, 9, 15),
      endDate: DateTime(2025, 9, 19),
      category: AcademicCalendarCategory.ders,
    ),
    AcademicCalendarModel(
      title: 'Öğrenci Meclisi Seçimleri',
      startDate: DateTime(2025, 9, 25),
      endDate: DateTime(2025, 9, 26),
      category: AcademicCalendarCategory.diger,
    ),

    // Ekim
    AcademicCalendarModel(
      title: 'Kampüs Festivali',
      startDate: DateTime(2025, 10, 5),
      endDate: DateTime(2025, 10, 7),
      category: AcademicCalendarCategory.diger,
    ),
    AcademicCalendarModel(
      title: 'Cumhuriyet Bayramı Tatili',
      startDate: DateTime(2025, 10, 29),
      endDate: DateTime(2025, 10, 31),
      category: AcademicCalendarCategory.tatil,
    ),

    // Kasım
    AcademicCalendarModel(
      title: 'Vize Sınavları',
      startDate: DateTime(2025, 11, 10),
      endDate: DateTime(2025, 11, 21),
      category: AcademicCalendarCategory.sinav,
    ),
    AcademicCalendarModel(
      title: 'Burs Başvuru Son Günü',
      startDate: DateTime(2025, 11, 24),
      endDate: DateTime(2025, 11, 28),
      category: AcademicCalendarCategory.kayit,
    ),

    // Aralık
    AcademicCalendarModel(
      title: 'Güz Dönemi Harç Ödemesi',
      startDate: DateTime(2025, 12, 1),
      endDate: DateTime(2025, 12, 15),
      category: AcademicCalendarCategory.harc,
    ),
    AcademicCalendarModel(
      title: 'Final Sınavları',
      startDate: DateTime(2025, 12, 22),
      endDate: DateTime(2026, 1, 4),
      category: AcademicCalendarCategory.sinav,
    ),

    // Ocak
    AcademicCalendarModel(
      title: 'Güz Dönemi Sonu',
      startDate: DateTime(2026, 1, 9),
      endDate: DateTime(2026, 1, 11),
      category: AcademicCalendarCategory.ders,
    ),
    AcademicCalendarModel(
      title: 'Bahar Dönemi Ders Kayıtları',
      startDate: DateTime(2026, 1, 12),
      endDate: DateTime(2026, 1, 16),
      category: AcademicCalendarCategory.kayit,
    ),

    // Şubat
    AcademicCalendarModel(
      title: 'Bahar Dönemi Başlangıcı',
      startDate: DateTime(2026, 2, 16),
      endDate: DateTime(2026, 2, 20),
      category: AcademicCalendarCategory.ders,
    ),
    AcademicCalendarModel(
      title: 'Öğrenci Harç Ödemesi',
      startDate: DateTime(2026, 2, 2),
      endDate: DateTime(2026, 2, 25),
      category: AcademicCalendarCategory.harc,
    ),

    // Mart
    AcademicCalendarModel(
      title: 'Staj Başvuru Dönemi',
      startDate: DateTime(2026, 3, 2),
      endDate: DateTime(2026, 3, 13),
      category: AcademicCalendarCategory.kayit,
    ),
    AcademicCalendarModel(
      title: 'Bahar Dönemi Vize Sınavları',
      startDate: DateTime(2026, 3, 23),
      endDate: DateTime(2026, 4, 3),
      category: AcademicCalendarCategory.sinav,
    ),

    // Nisan
    AcademicCalendarModel(
      title: 'Bahar Şenliği',
      startDate: DateTime(2026, 4, 20),
      endDate: DateTime(2026, 4, 24),
      category: AcademicCalendarCategory.diger,
    ),

    // Mayıs
    AcademicCalendarModel(
      title: 'Bahar Dönemi Final Sınavları',
      startDate: DateTime(2026, 5, 25),
      endDate: DateTime(2026, 6, 5),
      category: AcademicCalendarCategory.sinav,
    ),

    // Haziran
    AcademicCalendarModel(
      title: 'Mezuniyet Töreni',
      startDate: DateTime(2026, 6, 20),
      endDate: DateTime(2026, 6, 21),
      category: AcademicCalendarCategory.mezuniyet,
    ),
    AcademicCalendarModel(
      title: 'Yaz Okulu Kayıtları',
      startDate: DateTime(2026, 6, 22),
      endDate: DateTime(2026, 6, 26),
      category: AcademicCalendarCategory.kayit,
    ),
  ];
}

enum AcademicCalendarCategory {
  kayit,
  sinav,
  ders,
  harc,
  tatil,
  mezuniyet,
  diger,
}
