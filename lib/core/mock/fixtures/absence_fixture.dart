import 'package:campus_hub/features/absence_status/data/model/absence_course_model.dart';

/// Demo devamsızlık kayıtları.
/// Neden: gerçek servis olmadan ekran davranışı doğrulanabilsin.
abstract final class AbsenceFixture {
  static const List<AbsenceCourseModel> courses = [
    AbsenceCourseModel(
      id: 'abs-1',
      courseTitle: 'Veri Yapıları',
      totalCourseHours: 56,
      absentHours: 8,
      maxAllowedAbsenceHours: 14,
    ),
    AbsenceCourseModel(
      id: 'abs-2',
      courseTitle: 'İşletim Sistemleri',
      totalCourseHours: 42,
      absentHours: 10,
      maxAllowedAbsenceHours: 12,
    ),
    AbsenceCourseModel(
      id: 'abs-3',
      courseTitle: 'Bilgisayar Ağları',
      totalCourseHours: 48,
      absentHours: 13,
      maxAllowedAbsenceHours: 12,
    ),
    AbsenceCourseModel(
      id: 'abs-4',
      courseTitle: 'Yazılım Mühendisliği',
      totalCourseHours: 64,
      absentHours: 4,
      maxAllowedAbsenceHours: 16,
    ),
  ];
}
