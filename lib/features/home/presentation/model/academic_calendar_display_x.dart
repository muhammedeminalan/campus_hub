import 'package:campus_hub/features/home/domain/academic_calendar_model.dart';

/// [AcademicCalendarModel] için UI'a özgü formatlama metodları.
///
/// Model sınıfı saf veri taşırken bu extension
/// presentation katmanına ait string dönüşümlerini içerir.
extension AcademicCalendarDisplayX on AcademicCalendarModel {
  /// CalendarEventCard için gün - "02"
  String get day => startDate.day.toString().padLeft(2, '0');

  /// CalendarEventCard için ay adı - "Şubat"
  String get monthName => _monthNames[startDate.month - 1];

  /// Tek gün: "02 Şubat", aralık: "02 Şubat - 25 Şubat"
  String get dateRange {
    if (!isRange) return _formatDate(startDate);
    return '${_formatDate(startDate)} - ${_formatDate(endDate!)}';
  }

  String _formatDate(DateTime date) =>
      '${date.day.toString().padLeft(2, '0')} ${_monthNames[date.month - 1]}';

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
}
