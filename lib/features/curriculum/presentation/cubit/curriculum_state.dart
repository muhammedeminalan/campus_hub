part of 'curriculum_cubit.dart';

sealed class CurriculumState extends Equatable {
  const CurriculumState();

  @override
  List<Object?> get props => [];
}

final class CurriculumInitial extends CurriculumState {
  const CurriculumInitial();
}

final class CurriculumLoading extends CurriculumState {
  const CurriculumLoading();
}

final class CurriculumLoaded extends CurriculumState {
  static const _noChange = Object();

  final List<int> classLevels;
  final List<int> semesters;
  final List<CurriculumModel> allCurriculums;
  final List<CurriculumModel> filteredCurriculums;
  final int? selectedClassLevel;
  final int? selectedSemester;

  const CurriculumLoaded({
    required this.classLevels,
    required this.semesters,
    required this.allCurriculums,
    required this.filteredCurriculums,
    this.selectedClassLevel,
    this.selectedSemester,
  });

  CurriculumLoaded copyWith({
    List<int>? semesters,
    List<CurriculumModel>? filteredCurriculums,
    Object? selectedClassLevel = _noChange,
    Object? selectedSemester = _noChange,
  }) {
    return CurriculumLoaded(
      classLevels: classLevels,
      semesters: semesters ?? this.semesters,
      allCurriculums: allCurriculums,
      filteredCurriculums: filteredCurriculums ?? this.filteredCurriculums,
      selectedClassLevel: selectedClassLevel == _noChange
          ? this.selectedClassLevel
          : selectedClassLevel as int?,
      selectedSemester: selectedSemester == _noChange
          ? this.selectedSemester
          : selectedSemester as int?,
    );
  }

  @override
  List<Object?> get props => [
    classLevels,
    semesters,
    allCurriculums,
    filteredCurriculums,
    selectedClassLevel,
    selectedSemester,
  ];
}

final class CurriculumError extends CurriculumState {
  final String? message;

  const CurriculumError({this.message});

  @override
  List<Object?> get props => [message];
}
