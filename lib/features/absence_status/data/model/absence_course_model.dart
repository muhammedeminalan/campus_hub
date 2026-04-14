import 'package:equatable/equatable.dart';

/// Ders bazlı devamsızlık modelidir.
/// Neden: tüm hesaplar ve UI tek veri yapısına bağlı olsun.
final class AbsenceCourseModel extends Equatable {
  const AbsenceCourseModel({
    required this.id,
    required this.courseTitle,
    required this.totalCourseHours,
    required this.absentHours,
    required this.maxAllowedAbsenceHours,
  });

  final String id;
  final String courseTitle;
  final int totalCourseHours;
  final int absentHours;
  final int maxAllowedAbsenceHours;

  int get remainingAbsenceHours => maxAllowedAbsenceHours - absentHours;

  bool get isExceeded => remainingAbsenceHours < 0;

  bool get isRisky => !isExceeded && remainingAbsenceHours <= 2;

  double get usedRatio {
    if (maxAllowedAbsenceHours <= 0) return 0;
    final value = absentHours / maxAllowedAbsenceHours;
    return value.clamp(0.0, 1.0).toDouble();
  }

  @override
  List<Object?> get props => [
    id,
    courseTitle,
    totalCourseHours,
    absentHours,
    maxAllowedAbsenceHours,
  ];
}
