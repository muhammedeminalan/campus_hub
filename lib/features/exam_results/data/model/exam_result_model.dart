/// Bir sınav girişini temsil eden model.
///
/// [periodId] → [PeriodModel.id] ile eşleşir; dönem filtrelemesinde kullanılır.
/// [score]    → Henüz girilmemişse -1 geçilir; UI "--" gösterir.
class ExamResultModel {
  final String id;
  final String courseTitle; // Ders adı
  final String examType; // Vize · Final · Bütünleme
  final double score; // Ham puan (0–100), -1 = henüz yok
  final String letterGrade; // AA, BB, FF ... "--" (belirsiz)
  final int credit; // Ders kredisi
  final String periodId; // Hangi döneme ait

  const ExamResultModel({
    required this.id,
    required this.courseTitle,
    required this.examType,
    required this.score,
    required this.letterGrade,
    required this.credit,
    required this.periodId,
  });

  /// Geliştirme / demo aşamasında kullanılan örnek sınav listesi.
  /// Gerçek API entegrasyonunda bu getter kaldırılır.
  static List<ExamResultModel> get mockList => const [
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
      score: 35,
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
