/// Akademik takvim etkinliğini taşıyan saf veri modeli.
///
/// UI formatlama metodları [AcademicCalendarDisplayX] extension'ında,
/// örnek veriler [AcademicCalendarFixture] fixture sınıfındadır.
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

  // UI formatlama: academic_calendar_display_x.dart extension'ına taşındı
  // Mock veri:     core/mock/fixtures/academic_calendar_fixture.dart'a taşındı
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

