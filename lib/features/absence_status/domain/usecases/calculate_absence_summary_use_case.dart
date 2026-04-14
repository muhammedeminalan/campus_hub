import 'package:campus_hub/features/absence_status/data/model/absence_course_model.dart';
import 'package:equatable/equatable.dart';

/// Devamsızlık ekranı üst metriklerini hesaplar.
/// Neden: sayısal özet mantığı Cubit/UI'dan ayrılıp testlenebilir olsun.
final class AbsenceSummary extends Equatable {
  const AbsenceSummary({
    required this.totalCourses,
    required this.totalCourseHours,
    required this.totalAbsentHours,
    required this.totalAllowedHours,
    required this.totalRemainingHours,
    required this.riskyCourseCount,
    required this.exceededCourseCount,
  });

  final int totalCourses;
  final int totalCourseHours;
  final int totalAbsentHours;
  final int totalAllowedHours;
  final int totalRemainingHours;
  final int riskyCourseCount;
  final int exceededCourseCount;

  @override
  List<Object?> get props => [
    totalCourses,
    totalCourseHours,
    totalAbsentHours,
    totalAllowedHours,
    totalRemainingHours,
    riskyCourseCount,
    exceededCourseCount,
  ];
}

final class CalculateAbsenceSummaryUseCase {
  const CalculateAbsenceSummaryUseCase();

  AbsenceSummary call(List<AbsenceCourseModel> courses) {
    final totalCourses = courses.length;
    final totalCourseHours = courses.fold<int>(
      0,
      (sum, course) => sum + course.totalCourseHours,
    );
    final totalAbsentHours = courses.fold<int>(
      0,
      (sum, course) => sum + course.absentHours,
    );
    final totalAllowedHours = courses.fold<int>(
      0,
      (sum, course) => sum + course.maxAllowedAbsenceHours,
    );
    final totalRemainingHours = (totalAllowedHours - totalAbsentHours).clamp(
      0,
      1 << 30,
    );

    final riskyCourseCount = courses.where((course) => course.isRisky).length;
    final exceededCourseCount = courses
        .where((course) => course.isExceeded)
        .length;

    return AbsenceSummary(
      totalCourses: totalCourses,
      totalCourseHours: totalCourseHours,
      totalAbsentHours: totalAbsentHours,
      totalAllowedHours: totalAllowedHours,
      totalRemainingHours: totalRemainingHours,
      riskyCourseCount: riskyCourseCount,
      exceededCourseCount: exceededCourseCount,
    );
  }
}
