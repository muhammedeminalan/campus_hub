import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';

/// Demo ortamında kullanılan hazırlık bilgisi örnek verisi.
/// Neden: backend olmadan gerçekçi bir hazırlık ekranı gösterebilmek.
abstract final class PreparatoryInfoFixture {
  static const PreparatoryInfoModel info = PreparatoryInfoModel(
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
