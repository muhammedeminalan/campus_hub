import 'package:campus_hub/core/models/course_model.dart';
import 'package:campus_hub/core/models/period_model.dart';

/// Ders listesini seçili döneme göre filtreleyen use case.
///
/// Filtreleme mantığı [CoursesState] içinde computed getter olarak değil,
/// burada toplanır; testte izole edilebilir.
final class FilterCoursesByPeriodUseCase {
  const FilterCoursesByPeriodUseCase();

  /// [period] null ise tüm [courses] döner (filtre uygulanmaz).
  List<CourseModel> call(List<CourseModel> courses, PeriodModel? period) {
    if (period == null) return courses;
    return courses.where((c) => c.periodId == period.id).toList();
  }
}
