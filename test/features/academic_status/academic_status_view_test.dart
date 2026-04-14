import 'package:campus_hub/config/init/injection_container.dart';
import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';
import 'package:campus_hub/features/academic_status/domain/i_academic_status_service.dart';
import 'package:campus_hub/features/academic_status/domain/usecases/calculate_academic_status_summary_use_case.dart';
import 'package:campus_hub/features/academic_status/presentation/cubit/academic_status_cubit.dart';
import 'package:campus_hub/features/academic_status/presentation/view/academic_status_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAcademicStatusService implements IAcademicStatusService {
  @override
  Future<List<AcademicStatusModel>> getAll() async => [status];

  @override
  Future<AcademicStatusModel?> getById(String id) async =>
      id == status.id ? status : null;

  @override
  Future<AcademicStatusModel?> getCurrent() async => status;

  static const status = AcademicStatusModel(
    id: 'academic-1',
    studentNo: '2402131041',
    classLevel: '3. Sınıf',
    advisor: 'Dr. Öğr. Üyesi Elif Kara',
    targetGraduationCredit: 240,
    courses: [
      AcademicCourseModel(
        id: 'ac-1',
        courseTitle: 'Veri Yapıları',
        termLabel: '2025-2026 Güz',
        credit: 4,
        letterGrade: 'BA',
        averageScore: 84,
      ),
      AcademicCourseModel(
        id: 'ac-2',
        courseTitle: 'İşletim Sistemleri',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'DC',
        averageScore: 63,
      ),
      AcademicCourseModel(
        id: 'ac-3',
        courseTitle: 'Bilgisayar Ağları',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'FF',
        averageScore: 42,
      ),
      AcademicCourseModel(
        id: 'ac-4',
        courseTitle: 'Mobil Uygulama Geliştirme',
        termLabel: '2025-2026 Güz',
        credit: 3,
        letterGrade: 'BB',
        averageScore: 76,
      ),
    ],
  );
}

void main() {
  setUp(() async {
    await sl.reset();
    sl.registerLazySingleton<IAcademicStatusService>(
      () => _FakeAcademicStatusService(),
    );
    sl.registerLazySingleton<CalculateAcademicStatusSummaryUseCase>(
      () => const CalculateAcademicStatusSummaryUseCase(),
    );
    sl.registerFactory<AcademicStatusCubit>(
      () => AcademicStatusCubit(
        service: sl<IAcademicStatusService>(),
        calculateUseCase: sl<CalculateAcademicStatusSummaryUseCase>(),
      ),
    );
  });

  tearDown(() async {
    await sl.reset();
  });

  testWidgets('küçük ekranda overflow hatası üretmemeli', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 640));

    await tester.pumpWidget(const MaterialApp(home: AcademicStatusView()));
    await tester.pumpAndSettle();

    final exception = tester.takeException();
    expect(exception, isNull);
  });
}
