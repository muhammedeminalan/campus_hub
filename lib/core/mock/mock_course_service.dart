import 'package:campus_hub/core/contracts/courses/i_course_service.dart';
import 'package:campus_hub/core/models/course_model.dart';
import 'package:campus_hub/core/models/period_model.dart';

/// [ICourseService] mock implementasyonu.
///
/// Gerçek API/DB hazır olduğunda view'daki şu satırı değiştir:
/// ```dart
/// final ICourseService _service = MockCourseService();
/// ```
class MockCourseService implements ICourseService {
  @override
  Future<List<CourseModel>> getAll() async => CourseModel.mockList;

  @override
  Future<CourseModel?> getById(String id) async =>
      CourseModel.mockList.where((c) => c.id == id).firstOrNull;

  @override
  Future<List<PeriodModel>> getPeriods() async => PeriodModel.mockList;

  @override
  Future<List<CourseModel>> getCoursesByPeriod(String periodId) async =>
      CourseModel.mockList.where((c) => c.periodId == periodId).toList();
}
