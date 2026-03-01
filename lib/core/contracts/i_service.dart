/// Tüm veri servislerinin uyması gereken generic temel sözleşme.
///
/// [T] → servisin çalıştığı model tipi (ör. [CourseModel], [ExamModel]).
///
/// Her feature servisi bu interface'i doğrudan ya da
/// kendi genişletilmiş interface'i üzerinden implement eder:
/// ```dart
/// // Doğrudan:
/// class FirebaseCourseService implements IService<CourseModel> { ... }
///
/// // Genişletilmiş:
/// abstract interface class ICourseService extends IService<CourseModel> { ... }
/// class FirebaseCourseService implements ICourseService { ... }
/// ```
abstract interface class IService<T> {
  /// Tüm kayıtları döner.
  Future<List<T>> getAll();

  /// Verilen [id]'ye sahip kaydı döner; bulunamazsa `null`.
  Future<T?> getById(String id);
}
