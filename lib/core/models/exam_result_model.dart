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
}
