import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';

/// Demo akademik durum kaydı.
/// Neden: backend olmadan akademik durum ekranı gerçekçi davranabilsin.
abstract final class AcademicStatusFixture {
  static const AcademicStatusModel status = AcademicStatusModel(
    id: 'academic-1',
    studentNo: '2402131041',
    classLevel: '3. Sınıf',
    advisor: 'Dr. Öğr. Üyesi Elif Kara',
    targetGraduationCredit: 240,
    courses: [
      AcademicCourseModel(
        id: 'ac-1',
        courseTitle: 'Veri Yapıları',
        termLabel: '2025-2026 Güz',
        credit: 4,
        letterGrade: 'BA',
        averageScore: 84,
      ),
      AcademicCourseModel(
        id: 'ac-2',
        courseTitle: 'İşletim Sistemleri',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'DC',
        averageScore: 63,
      ),
      AcademicCourseModel(
        id: 'ac-3',
        courseTitle: 'Bilgisayar Ağları',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'FF',
        averageScore: 42,
      ),
      AcademicCourseModel(
        id: 'ac-4',
        courseTitle: 'Mobil Uygulama Geliştirme',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'BB',
        averageScore: 76,
      ),
      AcademicCourseModel(
        id: 'ac-5',
        courseTitle: 'Yazılım Mühendisliği',
        termLabel: '2025-2026 Güz',
        credit: 4,
        letterGrade: 'CB',
        averageScore: 71,
      ),
    ],
  );
}
