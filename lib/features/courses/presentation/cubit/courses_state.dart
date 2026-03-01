part of 'courses_cubit.dart';

sealed class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object?> get props => [];
}

final class CoursesInitial extends CoursesState {
  const CoursesInitial();
}

final class CoursesLoading extends CoursesState {
  const CoursesLoading();
}

final class CoursesLoaded extends CoursesState {
  final List<PeriodModel> periods;
  final List<CourseModel> courses;
  final List<CourseModel> filteredCourses;
  final PeriodModel? selectedPeriod;

  const CoursesLoaded({
    required this.periods,
    required this.courses,
    required this.filteredCourses,
    this.selectedPeriod,
  });

  CoursesLoaded copyWith({
    PeriodModel? selectedPeriod,
    List<CourseModel>? filteredCourses,
  }) {
    return CoursesLoaded(
      periods: periods,
      courses: courses,
      filteredCourses: filteredCourses ?? this.filteredCourses,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }

  @override
  List<Object?> get props => [
    periods,
    courses,
    filteredCourses,
    selectedPeriod,
  ];
}

final class CoursesError extends CoursesState {
  final String? message;

  const CoursesError({this.message});

  @override
  List<Object?> get props => [message];
}
