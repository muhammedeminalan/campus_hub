import 'package:bloc_test/bloc_test.dart';
import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';
import 'package:campus_hub/features/preparatory_info/domain/i_preparatory_info_service.dart';
import 'package:campus_hub/features/preparatory_info/domain/usecases/calculate_preparatory_progress_use_case.dart';
import 'package:campus_hub/features/preparatory_info/presentation/cubit/preparatory_info_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockPreparatoryInfoService extends Mock
    implements IPreparatoryInfoService {}

void main() {
  late _MockPreparatoryInfoService mockService;
  late PreparatoryInfoCubit cubit;

  const tInfo = PreparatoryInfoModel(
    id: 'prep-1',
    studentNo: '2402131041',
    level: 'B1',
    currentClass: 'Hazırlık - Şube A',
    advisor: 'Öğr. Gör. Selin Kaya',
    exemptionStatus: 'Devam Zorunlu',
    remainingAbsence: 6,
    maxAbsence: 20,
    modules: [
      PreparatoryModuleModel(
        id: 'm1',
        title: 'Reading',
        instructor: 'Selin Kaya',
        attendanceRate: 92,
        isCompleted: true,
      ),
      PreparatoryModuleModel(
        id: 'm2',
        title: 'Writing',
        instructor: 'Mehmet Acar',
        attendanceRate: 78,
        isCompleted: false,
      ),
    ],
    exams: [
      PreparatoryExamModel(
        id: 'e1',
        title: 'Quiz 1',
        dateLabel: '12 Nisan 2026',
        score: 72,
        isPassed: true,
      ),
    ],
  );

  setUp(() {
    mockService = _MockPreparatoryInfoService();
    cubit = PreparatoryInfoCubit(
      service: mockService,
      calculateUseCase: const CalculatePreparatoryProgressUseCase(),
    );
  });

  tearDown(() => cubit.close());

  group('PreparatoryInfoCubit', () {
    blocTest<PreparatoryInfoCubit, PreparatoryInfoState>(
      'loadData başarılıysa [Loading, Loaded] emit etmeli',
      build: () {
        when(() => mockService.getCurrent()).thenAnswer((_) async => tInfo);
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [
        const PreparatoryInfoLoading(),
        isA<PreparatoryInfoLoaded>(),
      ],
    );

    blocTest<PreparatoryInfoCubit, PreparatoryInfoState>(
      'loadData null dönerse [Loading, Error] emit etmeli',
      build: () {
        when(() => mockService.getCurrent()).thenAnswer((_) async => null);
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [
        const PreparatoryInfoLoading(),
        isA<PreparatoryInfoError>(),
      ],
    );

    blocTest<PreparatoryInfoCubit, PreparatoryInfoState>(
      'loadData hata fırlatırsa [Loading, Error] emit etmeli',
      build: () {
        when(() => mockService.getCurrent()).thenThrow(Exception('network'));
        return cubit;
      },
      act: (c) => c.loadData(),
      expect: () => [
        const PreparatoryInfoLoading(),
        isA<PreparatoryInfoError>(),
      ],
    );

    blocTest<PreparatoryInfoCubit, PreparatoryInfoState>(
      'loadData sonrası özet değerleri hesaplanmalı',
      build: () {
        when(() => mockService.getCurrent()).thenAnswer((_) async => tInfo);
        return cubit;
      },
      act: (c) => c.loadData(),
      verify: (c) {
        final state = c.state as PreparatoryInfoLoaded;
        expect(state.summary.totalModules, 2);
        expect(state.summary.completedModules, 1);
        expect(state.summary.moduleCompletionPercent, 50);
      },
    );
  });
}
