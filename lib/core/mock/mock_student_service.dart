import 'package:campus_hub/core/contracts/student/i_student_service.dart';
import 'package:campus_hub/core/mock/fixtures/academic_calendar_fixture.dart';
import 'package:campus_hub/features/home/data/model/student_card_model.dart';
import 'package:campus_hub/features/home/presentation/model/academic_calendar_model.dart';

/// [IStudentService] mock implementasyonu.
///
/// Firebase entegrasyonu tamamlandığında injection_container'da
/// MockStudentService() → FirebaseStudentService() ile değiştirilir.
class MockStudentService implements IStudentService {
  @override
  Future<StudentCardModel> getStudentCard() async => StudentCardModel.mock();

  @override
  Future<List<AcademicCalendarModel>> getCalendarEvents() async =>
      AcademicCalendarFixture.events;
}
