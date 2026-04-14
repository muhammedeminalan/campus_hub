import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';
import 'package:campus_hub/features/preparatory_info/domain/i_preparatory_info_service.dart';
import 'package:campus_hub/features/preparatory_info/domain/usecases/calculate_preparatory_progress_use_case.dart';
import 'package:campus_hub/features/preparatory_info/presentation/cubit/preparatory_info_cubit.dart';
import 'package:campus_hub/features/preparatory_info/presentation/view/preparatory_info_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakePreparatoryInfoService implements IPreparatoryInfoService {
  @override
  Future<List<PreparatoryInfoModel>> getAll() async => [info];

  @override
  Future<PreparatoryInfoModel?> getById(String id) async =>
      id == info.id ? info : null;

  @override
  Future<PreparatoryInfoModel?> getCurrent() async => info;

  static const info = PreparatoryInfoModel(
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
        id: 'module-1',
        title: 'Reading',
        instructor: 'Selin Kaya',
        attendanceRate: 92,
        isCompleted: true,
      ),
      PreparatoryModuleModel(
        id: 'module-2',
        title: 'Writing',
        instructor: 'Mehmet Acar',
        attendanceRate: 78,
        isCompleted: false,
      ),
      PreparatoryModuleModel(
        id: 'module-3',
        title: 'Listening',
        instructor: 'Gizem Yılmaz',
        attendanceRate: 85,
        isCompleted: true,
      ),
      PreparatoryModuleModel(
        id: 'module-4',
        title: 'Speaking',
        instructor: 'Zeynep Akın',
        attendanceRate: 81,
        isCompleted: false,
      ),
    ],
    exams: [
      PreparatoryExamModel(
        id: 'exam-1',
        title: 'Quiz 1',
        dateLabel: '12 Nisan 2026',
        score: 72,
        isPassed: true,
      ),
      PreparatoryExamModel(
        id: 'exam-2',
        title: 'Quiz 2',
        dateLabel: '22 Nisan 2026',
        score: 48,
        isPassed: false,
      ),
      PreparatoryExamModel(
        id: 'exam-3',
        title: 'Midterm',
        dateLabel: '05 Mayıs 2026',
        score: 68,
        isPassed: true,
      ),
    ],
  );
}

void main() {
  setUp(() async {
    await sl.reset();
    sl.registerLazySingleton<IPreparatoryInfoService>(
      () => _FakePreparatoryInfoService(),
    );
    sl.registerLazySingleton<CalculatePreparatoryProgressUseCase>(
      () => const CalculatePreparatoryProgressUseCase(),
    );
    sl.registerFactory<PreparatoryInfoCubit>(
      () => PreparatoryInfoCubit(
        service: sl<IPreparatoryInfoService>(),
        calculateUseCase: sl<CalculatePreparatoryProgressUseCase>(),
      ),
    );
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('küçük ekranda overflow hatası üretmemeli', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 640));

    await tester.pumpWidget(const MaterialApp(home: PreparatoryInfoView()));
    await tester.pumpAndSettle();

    final exception = tester.takeException();
    expect(exception, isNull);
  });
}
