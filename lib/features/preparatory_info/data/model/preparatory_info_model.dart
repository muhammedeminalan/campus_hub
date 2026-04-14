import 'package:equatable/equatable.dart';

/// Hazırlık modül satırı modeli.
/// Neden: ekran kartlarının tek tip veri sözleşmesiyle beslenmesi.
final class PreparatoryModuleModel extends Equatable {
  const PreparatoryModuleModel({
    required this.id,
    required this.title,
    required this.instructor,
    required this.attendanceRate,
    required this.isCompleted,
  });

  final String id;
  final String title;
  final String instructor;
  final int attendanceRate;
  final bool isCompleted;

  @override
  List<Object?> get props => [
    id,
    title,
    instructor,
    attendanceRate,
    isCompleted,
  ];
}

/// Hazırlık sınav satırı modeli.
/// Neden: sonuç kartı ve özet metrikleri aynı kaynaktan üretmek.
final class PreparatoryExamModel extends Equatable {
  const PreparatoryExamModel({
    required this.id,
    required this.title,
    required this.dateLabel,
    required this.score,
    required this.isPassed,
  });

  final String id;
  final String title;
  final String dateLabel;
  final int score;
  final bool isPassed;

  @override
  List<Object?> get props => [id, title, dateLabel, score, isPassed];
}

/// Öğrencinin hazırlık sürecini temsil eden root model.
/// Neden: cubit tek payload ile hem özeti hem listeleri üretebilsin.
final class PreparatoryInfoModel extends Equatable {
  const PreparatoryInfoModel({
    required this.id,
    required this.studentNo,
    required this.level,
    required this.currentClass,
    required this.advisor,
    required this.exemptionStatus,
    required this.remainingAbsence,
    required this.maxAbsence,
    required this.modules,
    required this.exams,
  });

  final String id;
  final String studentNo;
  final String level;
  final String currentClass;
  final String advisor;
  final String exemptionStatus;
  final int remainingAbsence;
  final int maxAbsence;
  final List<PreparatoryModuleModel> modules;
  final List<PreparatoryExamModel> exams;

  @override
  List<Object?> get props => [
    id,
    studentNo,
    level,
    currentClass,
    advisor,
    exemptionStatus,
    remainingAbsence,
    maxAbsence,
    modules,
    exams,
  ];
}
