import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';
import 'package:campus_hub/features/academic_status/domain/usecases/calculate_academic_status_summary_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = CalculateAcademicStatusSummaryUseCase();

  const status = AcademicStatusModel(
    id: 'academic-1',
    studentNo: '2402131041',
    classLevel: '3. Sınıf',
    advisor: 'Dr. Öğr. Üyesi Elif Kara',
    targetGraduationCredit: 240,
    courses: [
      AcademicCourseModel(
        id: 'course-1',
        courseTitle: 'Veri Yapıları',
        termLabel: '2025-2026 Güz',
        credit: 4,
        letterGrade: 'BA',
        averageScore: 84,
      ),
      AcademicCourseModel(
        id: 'course-2',
        courseTitle: 'İşletim Sistemleri',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'DC',
        averageScore: 63,
      ),
      AcademicCourseModel(
        id: 'course-3',
        courseTitle: 'Bilgisayar Ağları',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'FF',
        averageScore: 42,
      ),
      AcademicCourseModel(
        id: 'course-4',
        courseTitle: 'Yazılım Testi',
        termLabel: '2025-2026 Güz',
        credit: 2,
        letterGrade: 'BB',
        averageScore: 78,
      ),
    ],
  );

  group('CalculateAcademicStatusSummaryUseCase', () {
    test('kredi ve ders sayısı özetini doğru hesaplamalı', () {
      final summary = useCase(status);

      expect(summary.totalCourses, 4);
      expect(summary.passedCourses, 3);
      expect(summary.failedCourses, 1);
      expect(summary.riskyCourses, 1);
      expect(summary.totalCredits, 12);
      expect(summary.completedCredits, 9);
      expect(summary.remainingCredits, 231);
    });

    test('ağırlıklı ortalama ve başarı yüzdesini doğru hesaplamalı', () {
      final summary = useCase(status);

      expect(summary.gano, closeTo(2.04, 0.001));
      expect(summary.successRatePercent, 75);
    });

    test('boş ders listesinde güvenli sıfır değer dönmeli', () {
      const emptyStatus = AcademicStatusModel(
        id: 'academic-empty',
        studentNo: '0',
        classLevel: '-',
        advisor: '-',
        targetGraduationCredit: 240,
        courses: [],
      );

      final summary = useCase(emptyStatus);

      expect(summary.totalCourses, 0);
      expect(summary.passedCourses, 0);
      expect(summary.failedCourses, 0);
      expect(summary.riskyCourses, 0);
      expect(summary.totalCredits, 0);
      expect(summary.completedCredits, 0);
      expect(summary.remainingCredits, 240);
      expect(summary.gano, 0);
      expect(summary.successRatePercent, 0);
    });
  });
}
