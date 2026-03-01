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
    const CourseModel(
      id: '3',
      title: 'Algoritmalar',
      grade: 'BA',
      classInfo: 'c3',
      instructor: 'Dr. C',
      credit: 4,
      akts: 6,
      periodId: 'p1',
    ),
  ];

  group('FilterCoursesByPeriodUseCase', () {
    test('period null ise tüm dersleri döndürmeli', () {
      final result = useCase(allCourses, null);
      expect(result, allCourses);
    });

    test('belirtilen döneme ait dersleri filtrelemeli', () {
      const p1 = PeriodModel(id: 'p1', name: '2023-2024 Güz');
      final result = useCase(allCourses, p1);
      expect(result.length, 2);
      expect(result.every((c) => c.periodId == 'p1'), isTrue);
    });

    test('eşleşen ders yoksa boş liste döndürmeli', () {
      const p9 = PeriodModel(id: 'p9', name: 'Olmayan Dönem');
      final result = useCase(allCourses, p9);
      expect(result, isEmpty);
    });

    test('boş ders listesi için boş liste döndürmeli', () {
      const p1 = PeriodModel(id: 'p1', name: '2023-2024 Güz');
      final result = useCase([], p1);
      expect(result, isEmpty);
    });
  });
}
