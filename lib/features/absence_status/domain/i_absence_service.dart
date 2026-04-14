import 'package:campus_hub/core/contracts/i_service.dart';
import 'package:campus_hub/features/absence_status/data/model/absence_course_model.dart';

/// Devamsızlık verisi sağlayan servis sözleşmesi.
/// Neden: mock ve gerçek servis geçişi presentation katmanını etkilemesin.
abstract interface class IAbsenceService
    implements IService<AbsenceCourseModel> {}
