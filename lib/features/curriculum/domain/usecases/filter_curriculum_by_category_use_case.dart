import 'package:campus_hub/features/curriculum/data/model/curriculum_model.dart';

/// Müfredatı sınıf ve dönem bilgisine göre filtreler.
///
/// Bu use case'i ayrı tutma sebebi filtre davranışını UI'dan ayırarak
/// test edilebilir ve API geçişinde tekrar kullanılabilir hale getirmektir.
class FilterCurriculumByCategoryUseCase {
  const FilterCurriculumByCategoryUseCase();

  List<CurriculumModel> call(
    List<CurriculumModel> allCurriculums, {
    required int? classLevel,
    required int? semester,
  }) {
    final filtered = allCurriculums.where((curriculum) {
      final matchesClass =
          classLevel == null || curriculum.classLevel == classLevel;
      final matchesSemester =
          semester == null || curriculum.semester == semester;
      return matchesClass && matchesSemester;
    }).toList();

    filtered.sort((a, b) => a.courseCode.compareTo(b.courseCode));
    return filtered;
  }
}
