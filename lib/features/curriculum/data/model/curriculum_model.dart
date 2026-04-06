/// Müfredat ders kaydını temsil eden model.
///
/// [classLevel] ve [semester] alanları kategori filtrelemesinde kullanılır.
class CurriculumModel {
  final String id;
  final String courseCode;
  final String courseName;
  final int classLevel;
  final int semester;
  final int credit;
  final int akts;
  final bool isCompulsory;

  const CurriculumModel({
    required this.id,
    required this.courseCode,
    required this.courseName,
    required this.classLevel,
    required this.semester,
    required this.credit,
    required this.akts,
    required this.isCompulsory,
  });
}
