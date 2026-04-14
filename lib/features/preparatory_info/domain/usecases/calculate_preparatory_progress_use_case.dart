import 'package:campus_hub/features/preparatory_info/data/model/preparatory_info_model.dart';
import 'package:equatable/equatable.dart';

/// Hazırlık ekranındaki özet metrikleri hesaplar.
/// Neden: hesaplama mantığı view/cubit'ten ayrılıp test edilebilir olsun.
final class PreparatoryProgressSummary extends Equatable {
  const PreparatoryProgressSummary({
    required this.totalModules,
    required this.completedModules,
    required this.moduleCompletionPercent,
    required this.totalExams,
    required this.passedExams,
  });

  final int totalModules;
  final int completedModules;
  final int moduleCompletionPercent;
  final int totalExams;
  final int passedExams;

  @override
  List<Object?> get props => [
    totalModules,
    completedModules,
    moduleCompletionPercent,
    totalExams,
    passedExams,
  ];
}

final class CalculatePreparatoryProgressUseCase {
  const CalculatePreparatoryProgressUseCase();

  PreparatoryProgressSummary call(PreparatoryInfoModel info) {
    final totalModules = info.modules.length;
    final completedModules = info.modules
        .where((module) => module.isCompleted)
        .length;

    final moduleCompletionPercent = totalModules == 0
        ? 0
        : ((completedModules / totalModules) * 100).round();

    final totalExams = info.exams.length;
    final passedExams = info.exams.where((exam) => exam.isPassed).length;

    return PreparatoryProgressSummary(
      totalModules: totalModules,
      completedModules: completedModules,
      moduleCompletionPercent: moduleCompletionPercent,
      totalExams: totalExams,
      passedExams: passedExams,
    );
  }
}
