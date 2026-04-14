import 'package:campus_hub/features/absence_status/data/model/absence_course_model.dart';
import 'package:campus_hub/features/absence_status/domain/usecases/calculate_absence_summary_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = CalculateAbsenceSummaryUseCase();

  const courses = [
    AbsenceCourseModel(
      id: '1',
      courseTitle: 'Veri Yapıları',
      totalCourseHours: 56,
      absentHours: 8,
      maxAllowedAbsenceHours: 14,
    ),
    AbsenceCourseModel(
      id: '2',
      courseTitle: 'İşletim Sistemleri',
      totalCourseHours: 42,
      absentHours: 10,
      maxAllowedAbsenceHours: 12,
    ),
    AbsenceCourseModel(
      id: '3',
      courseTitle: 'Bilgisayar Ağları',
      totalCourseHours: 48,
      absentHours: 13,
      maxAllowedAbsenceHours: 12,
    ),
  ];

  group('CalculateAbsenceSummaryUseCase', () {
    test('toplam değerleri doğru hesaplamalı', () {
      final summary = useCase(courses);

      expect(summary.totalCourses, 3);
      expect(summary.totalCourseHours, 146);
      expect(summary.totalAbsentHours, 31);
      expect(summary.totalAllowedHours, 38);
      expect(summary.totalRemainingHours, 7);
    });

    test('riskli ve limit aşımı sayılarını doğru hesaplamalı', () {
      final summary = useCase(courses);

      expect(summary.riskyCourseCount, 1); // kalan 2 saat
      expect(summary.exceededCourseCount, 1); // kalan < 0
    });

    test('boş listede sıfır değer döndürmeli', () {
      final summary = useCase(const []);

      expect(summary.totalCourses, 0);
      expect(summary.totalCourseHours, 0);
      expect(summary.totalAbsentHours, 0);
      expect(summary.totalAllowedHours, 0);
      expect(summary.totalRemainingHours, 0);
      expect(summary.riskyCourseCount, 0);
      expect(summary.exceededCourseCount, 0);
    });
  });
}
