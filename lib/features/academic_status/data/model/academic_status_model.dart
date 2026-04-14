import 'package:equatable/equatable.dart';

/// Ders bazlı akademik performans kaydı.
/// Neden: ders satırı hesapları ve kart UI'sı tek modelden beslensin.
final class AcademicCourseModel extends Equatable {
  const AcademicCourseModel({
    required this.id,
    required this.courseTitle,
    required this.termLabel,
    required this.credit,
    required this.letterGrade,
    required this.averageScore,
  });

  final String id;
  final String courseTitle;
  final String termLabel;
  final int credit;
  final String letterGrade;
  final int averageScore;

  bool get isFailed {
    final normalized = letterGrade.trim().toUpperCase();
    return normalized == 'FF' || normalized == 'FD';
  }

  bool get isRisky {
    if (isFailed) return false;

    final normalized = letterGrade.trim().toUpperCase();
    return normalized == 'DC' || normalized == 'DD';
  }

  bool get isPassed => !isFailed;

  double get gradePoint {
    final normalized = letterGrade.trim().toUpperCase();

    return switch (normalized) {
      'AA' => 4.0,
      'BA' => 3.5,
      'BB' => 3.0,
      'CB' => 2.5,
      'CC' => 2.0,
      'DC' => 1.5,
      'DD' => 1.0,
      'FD' => 0.5,
      'FF' => 0.0,
      _ => 0.0,
    };
  }

  double get weightedPoint => gradePoint * credit;

  double get scoreRatio {
    final value = averageScore / 100;
    return value.clamp(0.0, 1.0).toDouble();
  }

  @override
  List<Object?> get props => [
    id,
    courseTitle,
    termLabel,
    credit,
    letterGrade,
    averageScore,
  ];
}

/// Öğrencinin akademik durum ekranını besleyen root model.
/// Neden: özet kartı ve ders listesi aynı payload ile senkron çalışsın.
final class AcademicStatusModel extends Equatable {
  const AcademicStatusModel({
    required this.id,
    required this.studentNo,
    required this.classLevel,
    required this.advisor,
    required this.targetGraduationCredit,
    required this.courses,
  });

  final String id;
  final String studentNo;
  final String classLevel;
  final String advisor;
  final int targetGraduationCredit;
  final List<AcademicCourseModel> courses;

  @override
  List<Object?> get props => [
    id,
    studentNo,
    classLevel,
    advisor,
    targetGraduationCredit,
    courses,
  ];
}
