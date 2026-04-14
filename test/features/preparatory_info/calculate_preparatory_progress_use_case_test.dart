import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';
import 'package:campus_hub/features/preparatory_info/domain/usecases/calculate_preparatory_progress_use_case.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const useCase = CalculatePreparatoryProgressUseCase();

  const info = PreparatoryInfoModel(
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
      PreparatoryModuleModel(
        id: 'm3',
        title: 'Speaking',
        instructor: 'Zeynep Akın',
        attendanceRate: 88,
        isCompleted: true,
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
      PreparatoryExamModel(
        id: 'e2',
        title: 'Quiz 2',
        dateLabel: '22 Nisan 2026',
        score: 48,
        isPassed: false,
      ),
    ],
  );

  group('CalculatePreparatoryProgressUseCase', () {
    test('modül ve sınav özetini doğru hesaplamalı', () {
      final summary = useCase(info);

      expect(summary.totalModules, 3);
      expect(summary.completedModules, 2);
      expect(summary.moduleCompletionPercent, 67);
      expect(summary.totalExams, 2);
      expect(summary.passedExams, 1);
    });

    test('boş listelerde yüzdeyi 0 döndürmeli', () {
      const emptyInfo = PreparatoryInfoModel(
        id: 'prep-empty',
        studentNo: '0',
        level: '-',
        currentClass: '-',
        advisor: '-',
        exemptionStatus: '-',
        remainingAbsence: 0,
        maxAbsence: 0,
        modules: [],
        exams: [],
      );

      final summary = useCase(emptyInfo);

      expect(summary.totalModules, 0);
      expect(summary.completedModules, 0);
      expect(summary.moduleCompletionPercent, 0);
      expect(summary.totalExams, 0);
      expect(summary.passedExams, 0);
    });
  });
}
