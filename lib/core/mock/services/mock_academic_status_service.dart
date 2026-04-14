import 'package:campus_hub/core/mock/base_mock_service.dart';
import 'package:campus_hub/core/mock/fixtures/academic_status_fixture.dart';
import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';
import 'package:campus_hub/features/academic_status/domain/i_academic_status_service.dart';

/// [IAcademicStatusService] mock implementasyonu.
/// Neden: gerçek API yokken Cubit/View akışını aynı sözleşmeyle sürdürmek.
class MockAcademicStatusService extends BaseMockService<AcademicStatusModel>
    implements IAcademicStatusService {
  MockAcademicStatusService()
    : super(
        items: const [AcademicStatusFixture.status],
        idOf: (item) => item.id,
      );

  @override
  Future<AcademicStatusModel?> getCurrent() async {
    return items.firstOrNull;
  }
}
