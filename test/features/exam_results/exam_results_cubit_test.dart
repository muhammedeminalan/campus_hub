import 'package:bloc_test/bloc_test.dart';
import 'package:campus_hub/core/models/exam_result_model.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:campus_hub/features/exam_results/domain/i_exam_result_service.dart';
import 'package:campus_hub/features/exam_results/domain/usecases/group_exam_results_by_course_use_case.dart';
import 'package:campus_hub/features/exam_results/presentation/cubit/exam_results_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockExamResultService extends Mock implements IExamResultService {}

void main() {
  late _MockExamResultService mockService;
  late ExamResultsCubit cubit;

  final tPeriods = [
    const PeriodModel(id: 'p1', name: '2023-2024 Güz'),
    const PeriodModel(id: 'p2', name: '2023-2024 Bahar'),
  ];

  final tResults = [
    const ExamResultModel(
      id: '1',
      courseTitle: 'Yazılım Müh.',
      examType: 'Vize',
      score: 72,
      letterGrade: 'BB',
      credit: 3,
      periodId: 'p1',
    ),
    const ExamResultModel(
      id: '2',
      courseTitle: 'Yazılım Müh.',
      examType: 'Final',
      score: 80,
      letterGrade: 'BB',
      credit: 3,
      periodId: 'p1',
    ),
    const ExamResultModel(
      id: '3',
      courseTitle: 'Veri Tabanı',
      examType: 'Vize',
      score: 90,
      letterGrade: 'AA',
      credit: 4,
      periodId: 'p2',
    ),
  ];

  setUp(() {
    mockService = _MockExamResultService();
    cubit = ExamResultsCubit(
      service: mockService,
      groupUseCase: const GroupExamResultsByCourseUseCase(),
    );
  });

  tearDown(() => cubit.close());

  group('ExamResultsCubit', () {
    blocTest<ExamResultsCubit, ExamResultsState>(
      'loadData başarılıysa [ExamResultsLoading, ExamResultsLoaded] emit etmeli',
      build: () {
        when(() => mockService.getPeriods()).thenAnswer((_) async => tPeriods);
        when(() => mockService.getAll()).thenAnswer((_) async => tResults);
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const ExamResultsLoading(), isA<ExamResultsLoaded>()],
    );

    blocTest<ExamResultsCubit, ExamResultsState>(
      'loadData hata fırlatırsa [ExamResultsLoading, ExamResultsError] emit etmeli',
      build: () {
        when(() => mockService.getPeriods()).thenThrow(Exception('network'));
        when(() => mockService.getAll()).thenThrow(Exception('network'));
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [const ExamResultsLoading(), isA<ExamResultsError>()],
    );

    blocTest<ExamResultsCubit, ExamResultsState>(
      'selectPeriod ile grouped ve selectedPeriod güncellenmeli',
      build: () {
        when(() => mockService.getPeriods()).thenAnswer((_) async => tPeriods);
        when(() => mockService.getAll()).thenAnswer((_) async => tResults);
        return cubit;
      },
      act: (c) async {
        await c.loadData();
        c.selectPeriod(tPeriods[1]); // p2
      },
      expect: () => [
        const ExamResultsLoading(),
        isA<ExamResultsLoaded>(),
        isA<ExamResultsLoaded>().having(
          (s) => s.selectedPeriod?.id,
          'selectedPeriod.id',
          'p2',
        ),
      ],
    );

    blocTest<ExamResultsCubit, ExamResultsState>(
      'selectPeriod seçilen dönemin sonuçlarını doğru gruplandırmalı',
      build: () {
        when(() => mockService.getPeriods()).thenAnswer((_) async => tPeriods);
        when(() => mockService.getAll()).thenAnswer((_) async => tResults);
        return cubit;
      },
      act: (c) async {
        await c.loadData();
        c.selectPeriod(tPeriods[1]); // p2 → sadece Veri Tabanı
      },
      verify: (c) {
        final state = c.state as ExamResultsLoaded;
        expect(state.grouped.keys, contains('Veri Tabanı'));
        expect(state.grouped.keys, isNot(contains('Yazılım Müh.')));
      },
    );
  });
}
