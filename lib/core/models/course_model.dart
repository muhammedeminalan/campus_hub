/// Ders bilgisini taşıyan model.
///
/// [periodId] → [PeriodModel.id] ile eşleşir; dönem filtrelemesinde kullanılır.
/// [grade]    → Henüz belirlenmemişse "--" geçilir.
class CourseModel {
  final String id;
  final String title;
  final String grade;
  final String classInfo;
  final String instructor;
  final int credit;
  final int akts;
  final String periodId;

  const CourseModel({
    required this.id,
    required this.title,
    required this.grade,
    required this.classInfo,
    required this.instructor,
    required this.credit,
    required this.akts,
    required this.periodId,
  });
}
