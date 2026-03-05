import 'package:campus_hub/core/contracts/i_service.dart';

/// [IService]'in mock implementasyonları için generic temel sınıf.
///
/// [getAll] ve [getById] boilerplate'ini tek seferde çözer;
/// feature-specific mock'lar sadece domain metodlarını override eder.
///
/// Kullanım:
/// ```dart
/// class MockCourseService extends BaseMockService<CourseModel>
///     implements ICourseService {
///   MockCourseService()
///       : super(items: CourseModel.mockList, idOf: (c) => c.id);
///   // sadece getPeriods ve getCoursesByPeriod override edilir
/// }
/// ```
abstract class BaseMockService<T> implements IService<T> {
  const BaseMockService({required this.items, required this.idOf});

  final List<T> items;
  final String Function(T) idOf;

  @override
  Future<List<T>> getAll() async => List.unmodifiable(items);

  @override
  Future<T?> getById(String id) async =>
      items.where((e) => idOf(e) == id).firstOrNull;
}
