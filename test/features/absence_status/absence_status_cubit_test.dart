import 'package:bloc_test/bloc_test.dart';
import 'package:campus_hub/features/absence_status/data/model/absence_course_model.dart';
import 'package:campus_hub/features/absence_status/domain/i_absence_service.dart';
import 'package:campus_hub/features/absence_status/domain/usecases/calculate_absence_summary_use_case.dart';
import 'package:campus_hub/features/absence_status/presentation/cubit/absence_status_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAbsenceService extends Mock implements IAbsenceService {}

void main() {
  late _MockAbsenceService mockService;
  late AbsenceStatusCubit cubit;

  const tCourses = [
    AbsenceCourseModel(
      id: '1',
      courseTitle: 'Veri Yapıları',
      totalCourseHours: 56,
      absentHours: 8,
      maxAllowedAbsenceHours: 14,
    ),
    AbsenceCourseModel(
      id: '2',
      courseTitle: 'İşletim Sistemleri',
      totalCourseHours: 42,
      absentHours: 10,
      maxAllowedAbsenceHours: 12,
    ),
  ];

  setUp(() {
    mockService = _MockAbsenceService();
    cubit = AbsenceStatusCubit(
      service: mockService,
      summaryUseCase: const CalculateAbsenceSummaryUseCase(),
    );
  });

  tearDown(() => cubit.close());

  group('AbsenceStatusCubit', () {
    blocTest<AbsenceStatusCubit, AbsenceStatusState>(
      'loadData başarılıysa [Loading, Loaded] emit etmeli',
      build: () {
        when(() => mockService.getAll()).thenAnswer((_) async => tCourses);
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const AbsenceStatusLoading(), isA<AbsenceStatusLoaded>()],
    );

    blocTest<AbsenceStatusCubit, AbsenceStatusState>(
      'loadData hata fırlatırsa [Loading, Error] emit etmeli',
      build: () {
        when(() => mockService.getAll()).thenThrow(Exception('network'));
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const AbsenceStatusLoading(), isA<AbsenceStatusError>()],
    );

    blocTest<AbsenceStatusCubit, AbsenceStatusState>(
      'loadData sonrası summary hesaplanmalı',
      build: () {
        when(() => mockService.getAll()).thenAnswer((_) async => tCourses);
        return cubit;
      },
      act: (c) => c.loadData(),
      verify: (c) {
        final state = c.state as AbsenceStatusLoaded;
        expect(state.summary.totalCourses, 2);
        expect(state.summary.totalCourseHours, 98);
        expect(state.summary.totalRemainingHours, 8);
      },
    );
  });
}
