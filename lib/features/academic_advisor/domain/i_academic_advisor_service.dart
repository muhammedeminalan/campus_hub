import 'package:campus_hub/core/contracts/i_service.dart';
import 'package:campus_hub/features/academic_advisor/data/model/advisor_model.dart';

/// Akademik danışman servisinin soyut arayüzü.
///
/// [BaseMockService] [getAll] ve [getById] boilerplate'ini karşılar;
/// somut implementasyonlar yalnızca [getAdvisor] metodunu override eder.
///
/// Firebase'e geçince injection_container'da:
/// `MockAcademicAdvisorService() → FirebaseAcademicAdvisorService()`
abstract interface class IAcademicAdvisorService
    implements IService<AdvisorModel> {
  /// Giriş yapmış öğrencinin akademik danışmanını döner.
  /// Danışman ataması yoksa `null` döner.
  Future<AdvisorModel?> getAdvisor();
}
