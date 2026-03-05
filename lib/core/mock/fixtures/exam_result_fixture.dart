import 'package:campus_hub/core/models/exam_result_model.dart';

/// Geliştirme / demo aşamasında kullanılan sınav sonucu örnek verileri.
///
/// Gerçek API entegrasyonunda bu dosya kaldırılır veya test fixture'ına
/// taşınır. [IExamResultService] mock implementasyonu bu class'a referans verir.
abstract final class ExamResultFixture {
  static const List<ExamResultModel> results = [
    // ── 2023-2024 Güz (periodId: '3') ────────────────────────────────────
    ExamResultModel(
      id: '1',
      courseTitle: 'Yazılım Mühendisliği',
      examType: 'Vize',
      score: 72,
      letterGrade: 'BB',
      credit: 3,
      periodId: '3',
    ),
    ExamResultModel(
      id: '2',
      courseTitle: 'Yazılım Mühendisliği',
      examType: 'Final',
      score: 80,
      letterGrade: 'BB',
      credit: 3,
      periodId: '3',
    ),
    ExamResultModel(
      id: '3',
      courseTitle: 'Veri Tabanı Yönetimi',
      examType: 'Vize',
      score: 90,
      letterGrade: 'AA',
      credit: 4,
      periodId: '3',
    ),
    ExamResultModel(
      id: '4',
      courseTitle: 'Veri Tabanı Yönetimi',
      examType: 'Final',
      score: 95,
      letterGrade: 'AA',
      credit: 4,
      periodId: '3',
    ),
    ExamResultModel(
      id: '5',
      courseTitle: 'Nesneye Yönelik Programlama',
      examType: 'Vize',
      score: 58,
      letterGrade: 'CB',
      credit: 3,
      periodId: '3',
    ),
    ExamResultModel(
      id: '6',
      courseTitle: 'Nesneye Yönelik Programlama',
      examType: 'Final',
      score: 65,
      letterGrade: 'CB',
      credit: 3,
      periodId: '3',
    ),
    // ── 2023-2024 Bahar (periodId: '4') ──────────────────────────────────
    ExamResultModel(
      id: '7',
      courseTitle: 'Algoritma ve Veri Yapıları',
      examType: 'Vize',
      score: 78,
      letterGrade: 'BA',
      credit: 4,
      periodId: '4',
    ),
    ExamResultModel(
      id: '8',
      courseTitle: 'Algoritma ve Veri Yapıları',
      examType: 'Final',
      score: 83,
      letterGrade: 'BA',
      credit: 4,
      periodId: '4',
    ),
    // ── 2024-2025 Güz (periodId: '5') ────────────────────────────────────
    ExamResultModel(
      id: '9',
      courseTitle: 'İşletim Sistemleri',
      examType: 'Vize',
      score: 40,
      letterGrade: 'FF',
      credit: 3,
      periodId: '5',
    ),
    ExamResultModel(
      id: '10',
      courseTitle: 'İşletim Sistemleri',
      examType: 'Final',
      score: 30,
      letterGrade: 'FF',
      credit: 3,
      periodId: '5',
    ),
    ExamResultModel(
      id: '11',
      courseTitle: 'Bilgisayar Ağları',
      examType: 'Vize',
      score: 62,
      letterGrade: 'CC',
      credit: 3,
      periodId: '5',
    ),
    ExamResultModel(
      id: '12',
      courseTitle: 'Bilgisayar Ağları',
      examType: 'Final',
      score: 85,
      letterGrade: 'BB',
      credit: 3,
      periodId: '5',
    ),
  ];
}
