import 'package:campus_hub/core/contracts/i_service.dart';
import 'package:campus_hub/core/models/course_model.dart';
import 'package:campus_hub/core/models/period_model.dart';

/// Ders servisine özgü sözleşme.
///
/// [IService]'den [CourseModel] üzerinde temel CRUD operasyonlarını miras alır,
/// dönem ve filtreleme metodlarını ekler.
///
/// Implementasyon örnekleri:
/// ```dart
/// class MockCourseService implements ICourseService { ... }
/// class FirebaseCourseService implements ICourseService { ... }
/// class RealtimeCourseService implements ICourseService { ... }
/// ```
abstract interface class ICourseService extends IService<CourseModel> {
  /// Tüm dönemleri döner.
  Future<List<PeriodModel>> getPeriods();

  /// Belirtilen döneme ait dersleri döner.
  Future<List<CourseModel>> getCoursesByPeriod(String periodId);
}
