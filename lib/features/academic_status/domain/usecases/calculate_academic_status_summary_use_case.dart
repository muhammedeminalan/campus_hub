import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';
import 'package:equatable/equatable.dart';

/// Akademik durum özet metriklerini taşıyan immutable değer nesnesi.
/// Neden: Cubit ve UI aynı hesap sonuçlarını güvenli şekilde paylaşsın.
final class AcademicStatusSummary extends Equatable {
  const AcademicStatusSummary({
    required this.totalCourses,
    required this.passedCourses,
    required this.failedCourses,
    required this.riskyCourses,
    required this.totalCredits,
    required this.completedCredits,
    required this.remainingCredits,
    required this.gano,
    required this.successRatePercent,
  });

  final int totalCourses;
  final int passedCourses;
  final int failedCourses;
  final int riskyCourses;
  final int totalCredits;
  final int completedCredits;
  final int remainingCredits;
  final double gano;
  final int successRatePercent;

  @override
  List<Object?> get props => [
    totalCourses,
    passedCourses,
    failedCourses,
    riskyCourses,
    totalCredits,
    completedCredits,
    remainingCredits,
    gano,
    successRatePercent,
  ];
}

final class CalculateAcademicStatusSummaryUseCase {
  const CalculateAcademicStatusSummaryUseCase();

  AcademicStatusSummary call(AcademicStatusModel status) {
    final courses = status.courses;
    final totalCourses = courses.length;
    final passedCourses = courses.where((course) => course.isPassed).length;
    final failedCourses = courses.where((course) => course.isFailed).length;
    final riskyCourses = courses.where((course) => course.isRisky).length;

    final totalCredits = courses.fold<int>(
      0,
      (sum, course) => sum + course.credit,
    );
    final completedCredits = courses
        .where((course) => course.isPassed)
        .fold<int>(0, (sum, course) => sum + course.credit);
    final remainingCredits = (status.targetGraduationCredit - completedCredits)
        .clamp(0, 1 << 30);

    final weightedGradeTotal = courses.fold<double>(
      0,
      (sum, course) => sum + course.weightedPoint,
    );
    final gano = totalCredits == 0
        ? 0.0
        : _roundToTwo(weightedGradeTotal / totalCredits);

    final successRatePercent = totalCourses == 0
        ? 0
        : ((passedCourses / totalCourses) * 100).round();

    return AcademicStatusSummary(
      totalCourses: totalCourses,
      passedCourses: passedCourses,
      failedCourses: failedCourses,
      riskyCourses: riskyCourses,
      totalCredits: totalCredits,
      completedCredits: completedCredits,
      remainingCredits: remainingCredits,
      gano: gano,
      successRatePercent: successRatePercent,
    );
  }

  double _roundToTwo(double value) {
    return (value * 100).round() / 100;
  }
}
