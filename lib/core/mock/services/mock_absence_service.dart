import 'package:campus_hub/core/mock/base_mock_service.dart';
import 'package:campus_hub/core/mock/fixtures/absence_fixture.dart';
import 'package:campus_hub/features/absence_status/data/model/absence_course_model.dart';
import 'package:campus_hub/features/absence_status/domain/i_absence_service.dart';

/// [IAbsenceService] mock implementasyonu.
/// Neden: backend yokken Cubit/View aynı sözleşmeyle çalışsın.
class MockAbsenceService extends BaseMockService<AbsenceCourseModel>
    implements IAbsenceService {
  MockAbsenceService()
    : super(items: AbsenceFixture.courses, idOf: (course) => course.id);
}
