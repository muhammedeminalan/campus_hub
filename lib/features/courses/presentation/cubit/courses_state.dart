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
  final PeriodModel? selectedPeriod;

  const CoursesLoaded({
    required this.periods,
    required this.courses,
    this.selectedPeriod,
  });

  /// Seçili döneme göre filtrelenmiş dersler.
  /// Dönem seçilmemişse tüm dersler döner.
  List<CourseModel> get filteredCourses {
    if (selectedPeriod == null) return courses;
    return courses.where((c) => c.periodId == selectedPeriod!.id).toList();
  }

  CoursesLoaded copyWith({PeriodModel? selectedPeriod}) {
    return CoursesLoaded(
      periods: periods,
      courses: courses,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
    );
  }

  @override
  List<Object?> get props => [periods, courses, selectedPeriod];
}

final class CoursesError extends CoursesState {
  const CoursesError();
}
