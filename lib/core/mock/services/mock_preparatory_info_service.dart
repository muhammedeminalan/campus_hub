import 'package:campus_hub/core/mock/base_mock_service.dart';
import 'package:campus_hub/core/mock/fixtures/preparatory_info_fixture.dart';
import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';
import 'package:campus_hub/features/preparatory_info/domain/i_preparatory_info_service.dart';

/// [IPreparatoryInfoService] mock implementasyonu.
/// Neden: gerçek API hazır olana kadar cubit/view akışı bozulmadan sürsün.
class MockPreparatoryInfoService extends BaseMockService<PreparatoryInfoModel>
    implements IPreparatoryInfoService {
  MockPreparatoryInfoService()
    : super(
        items: const [PreparatoryInfoFixture.info],
        idOf: (item) => item.id,
      );

  @override
  Future<PreparatoryInfoModel?> getCurrent() async {
    return items.firstOrNull;
  }
}
