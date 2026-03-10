import 'package:campus_hub/core/mock/base_mock_service.dart';
import 'package:campus_hub/core/mock/fixtures/course_fixture.dart';
import 'package:campus_hub/core/models/course_model.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:campus_hub/features/courses/domain/i_course_service.dart';

/// [ICourseService] mock implementasyonu.
///
/// [BaseMockService] [getAll] ve [getById] boilerplate'ini karşılar;
/// burada yalnızca dönem metodları implement edilir.
///
/// Firebase'e geçince injection_container'da:
/// `MockCourseService() → FirebaseCourseService()`
class MockCourseService extends BaseMockService<CourseModel>
    implements ICourseService {
  MockCourseService() : super(items: CourseFixture.courses, idOf: (c) => c.id);

  @override
  Future<List<PeriodModel>> getPeriods() async => PeriodModel.mockList;

  @override
  Future<List<CourseModel>> getCoursesByPeriod(String periodId) async =>
      items.where((c) => c.periodId == periodId).toList();
}
