import 'package:bloc_test/bloc_test.dart';
import 'package:campus_hub/core/contracts/courses/i_course_service.dart';
import 'package:campus_hub/core/models/course_model.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:campus_hub/features/courses/domain/usecases/filter_courses_by_period_use_case.dart';
import 'package:campus_hub/features/courses/presentation/cubit/courses_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCourseService extends Mock implements ICourseService {}

void main() {
  late _MockCourseService mockService;
  late CoursesCubit cubit;

  final tPeriods = [
    const PeriodModel(id: 'p1', name: '2023-2024 Güz'),
    const PeriodModel(id: 'p2', name: '2023-2024 Bahar'),
  ];

  final tCourses = [
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

  setUp(() {
    mockService = _MockCourseService();
    cubit = CoursesCubit(
      service: mockService,
      filterUseCase: const FilterCoursesByPeriodUseCase(),
    );
  });

  tearDown(() => cubit.close());

  group('CoursesCubit', () {
    blocTest<CoursesCubit, CoursesState>(
      'loadData başarılıysa [CoursesLoading, CoursesLoaded] emit etmeli',
      build: () {
        when(() => mockService.getPeriods()).thenAnswer((_) async => tPeriods);
        when(() => mockService.getAll()).thenAnswer((_) async => tCourses);
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [
        const CoursesLoading(),
        CoursesLoaded(
          periods: tPeriods,
          courses: tCourses,
          filteredCourses: tCourses,
        ),
      ],
    );

    blocTest<CoursesCubit, CoursesState>(
      'loadData hata fırlatırsa [CoursesLoading, CoursesError] emit etmeli',
      build: () {
        when(() => mockService.getPeriods()).thenThrow(Exception('network'));
        when(() => mockService.getAll()).thenThrow(Exception('network'));
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const CoursesLoading(), isA<CoursesError>()],
    );

    blocTest<CoursesCubit, CoursesState>(
      'selectPeriod ile filteredCourses guncellenmeli',
      build: () {
        when(() => mockService.getPeriods()).thenAnswer((_) async => tPeriods);
        when(() => mockService.getAll()).thenAnswer((_) async => tCourses);
        return cubit;
      },
      act: (c) async {
        await c.loadData();
        c.selectPeriod(tPeriods[0]); // p1
      },
      expect: () => [
        const CoursesLoading(),
        CoursesLoaded(
          periods: tPeriods,
          courses: tCourses,
          filteredCourses: tCourses,
        ),
        CoursesLoaded(
          periods: tPeriods,
          courses: tCourses,
          filteredCourses: [tCourses[0]], // sadece p1'e ait
          selectedPeriod: tPeriods[0],
        ),
      ],
    );
  });
}
