import 'package:campus_hub/core/models/course_model.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:campus_hub/features/courses/domain/usecases/filter_courses_by_period_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = FilterCoursesByPeriodUseCase();

  final allCourses = [
    const CourseModel(
      id: '1',
      title: 'Yazılım Müh.',
      grade: 'BB',
      classInfo: 'c1',
      instructor: 'Dr. A',
      credit: 3,
      akts: 5,
      periodId: 'p1',
    ),
    const CourseModel(
      id: '2',
      title: 'Veri Tabanı',
      grade: 'AA',
      classInfo: 'c2',
      instructor: 'Dr. B',
      credit: 4,
      akts: 6,
      periodId: 'p2',
    ),
  ];

  group('FilterCoursesByPeriodUseCase', () {
    test('null period → tüm dersler döner', () {
      expect(useCase(allCourses, null), allCourses);
    });

    test('eşleşen period → yalnızca o dönemin dersleri döner', () {
      const p1 = PeriodModel(id: 'p1', name: '2023-2024 Güz');
      final result = useCase(allCourses, p1);
      expect(result.length, 1);
      expect(result.first.periodId, 'p1');
    });

    test('eşleşmeyen period → boş liste döner', () {
      const p9 = PeriodModel(id: 'p9', name: 'Olmayan Dönem');
      expect(useCase(allCourses, p9), isEmpty);
    });
  });
}
