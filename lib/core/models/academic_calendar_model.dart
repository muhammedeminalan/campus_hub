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
