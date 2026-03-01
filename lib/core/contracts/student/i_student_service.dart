import 'package:campus_hub/features/home/data/model/student_card_model.dart';
import 'package:campus_hub/features/home/presentation/model/academic_calendar_model.dart';

/// Öğrenci ana sayfa verilerinin sağlandığı servis sözleşmesi.
///
/// Implementasyon örnekleri:
/// ```dart
/// class MockStudentService implements IStudentService { ... }
/// class FirebaseStudentService implements IStudentService { ... }
/// ```
abstract interface class IStudentService {
  /// Oturum açmış öğrencinin kart bilgilerini döner.
  Future<StudentCardModel> getStudentCard();

  /// Güncel akademik takvim etkinliklerini döner.
  Future<List<AcademicCalendarModel>> getCalendarEvents();
}
