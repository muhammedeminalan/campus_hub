import 'package:campus_hub/core/mock/base_mock_service.dart';
import 'package:campus_hub/core/mock/fixtures/advisor_fixture.dart';
import 'package:campus_hub/features/academic_advisor/data/model/advisor_model.dart';
import 'package:campus_hub/features/academic_advisor/domain/i_academic_advisor_service.dart';

/// [IAcademicAdvisorService] mock implementasyonu.
///
/// [BaseMockService] [getAll] ve [getById] boilerplate'ini karşılar;
/// burada yalnızca [getAdvisor] implement edilir.
///
/// Firebase'e geçince injection_container'da:
/// `MockAcademicAdvisorService() → FirebaseAcademicAdvisorService()`
class MockAcademicAdvisorService extends BaseMockService<AdvisorModel>
    implements IAcademicAdvisorService {
  MockAcademicAdvisorService()
      : super(items: [AdvisorFixture.advisor], idOf: (a) => a.id);

  @override
  Future<AdvisorModel?> getAdvisor() async => AdvisorFixture.advisor;
}
