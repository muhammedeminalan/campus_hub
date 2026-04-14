import 'package:bloc_test/bloc_test.dart';
import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';
import 'package:campus_hub/features/academic_status/domain/i_academic_status_service.dart';
import 'package:campus_hub/features/academic_status/domain/usecases/calculate_academic_status_summary_use_case.dart';
import 'package:campus_hub/features/academic_status/presentation/cubit/academic_status_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockAcademicStatusService extends Mock
    implements IAcademicStatusService {}

void main() {
  late _MockAcademicStatusService mockService;
  late AcademicStatusCubit cubit;

  const tStatus = AcademicStatusModel(
    id: 'academic-1',
    studentNo: '2402131041',
    classLevel: '3. Sınıf',
    advisor: 'Dr. Öğr. Üyesi Elif Kara',
    targetGraduationCredit: 240,
    courses: [
      AcademicCourseModel(
        id: 'course-1',
        courseTitle: 'Veri Yapıları',
        termLabel: '2025-2026 Güz',
        credit: 4,
        letterGrade: 'BA',
        averageScore: 84,
      ),
      AcademicCourseModel(
        id: 'course-2',
        courseTitle: 'İşletim Sistemleri',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'DC',
        averageScore: 63,
      ),
      AcademicCourseModel(
        id: 'course-3',
        courseTitle: 'Bilgisayar Ağları',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'FF',
        averageScore: 42,
      ),
    ],
  );

  setUp(() {
    mockService = _MockAcademicStatusService();
    cubit = AcademicStatusCubit(
      service: mockService,
      calculateUseCase: const CalculateAcademicStatusSummaryUseCase(),
    );
  });

  tearDown(() => cubit.close());

  group('AcademicStatusCubit', () {
    blocTest<AcademicStatusCubit, AcademicStatusState>(
      'loadData başarılıysa [Loading, Loaded] emit etmeli',
      build: () {
        when(() => mockService.getCurrent()).thenAnswer((_) async => tStatus);
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [
        const AcademicStatusLoading(),
        isA<AcademicStatusLoaded>(),
      ],
    );

    blocTest<AcademicStatusCubit, AcademicStatusState>(
      'loadData null dönerse [Loading, Error] emit etmeli',
      build: () {
        when(() => mockService.getCurrent()).thenAnswer((_) async => null);
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const AcademicStatusLoading(), isA<AcademicStatusError>()],
    );

    blocTest<AcademicStatusCubit, AcademicStatusState>(
      'loadData hata fırlatırsa [Loading, Error] emit etmeli',
      build: () {
        when(() => mockService.getCurrent()).thenThrow(Exception('network'));
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const AcademicStatusLoading(), isA<AcademicStatusError>()],
    );

    blocTest<AcademicStatusCubit, AcademicStatusState>(
      'loadData sonrası özet değerleri hesaplanmalı',
      build: () {
        when(() => mockService.getCurrent()).thenAnswer((_) async => tStatus);
        return cubit;
      },
      act: (c) => c.loadData(),
      verify: (c) {
        final state = c.state as AcademicStatusLoaded;
        expect(state.summary.totalCourses, 3);
        expect(state.summary.completedCredits, 7);
        expect(state.summary.failedCourses, 1);
      },
    );
  });
}
