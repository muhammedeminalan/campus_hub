import 'package:campus_hub/core/contracts/i_service.dart';
import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';

/// Akademik durum servis sözleşmesi.
/// Neden: mock ve gerçek data source geçişi UI katmanına yansımasın.
abstract interface class IAcademicStatusService
    implements IService<AcademicStatusModel> {
  /// Oturumdaki öğrencinin güncel akademik durum kaydını döner.
  Future<AcademicStatusModel?> getCurrent();
}
