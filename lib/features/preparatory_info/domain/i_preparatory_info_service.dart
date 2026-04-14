import 'package:campus_hub/core/contracts/i_service.dart';
import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';

/// Hazırlık bilgileri servis sözleşmesi.
/// Neden: mock ve gerçek data source geçişini UI'dan izole etmek.
abstract interface class IPreparatoryInfoService
    implements IService<PreparatoryInfoModel> {
  /// Oturumdaki öğrenciye ait güncel hazırlık bilgisini döner.
  Future<PreparatoryInfoModel?> getCurrent();
}
