import 'package:campus_hub/core/contracts/courses/i_course_service.dart';
import 'package:campus_hub/core/models/course_model.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:campus_hub/features/courses/domain/usecases/filter_courses_by_period_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final ICourseService _service;
  final FilterCoursesByPeriodUseCase _filterUseCase;

  CoursesCubit({
    required ICourseService service,
    FilterCoursesByPeriodUseCase? filterUseCase,
  }) : _service = service,
       _filterUseCase = filterUseCase ?? const FilterCoursesByPeriodUseCase(),
       super(const CoursesInitial());

  /// Dönem ve ders verilerini yükler.
  Future<void> loadData() async {
    emit(const CoursesLoading());
    try {
      final results = await Future.wait([
        _service.getPeriods(),
        _service.getAll(),
      ]);
      final periods = results[0] as List<PeriodModel>;
      final courses = results[1] as List<CourseModel>;
      emit(
        CoursesLoaded(
          periods: periods,
          courses: courses,
          filteredCourses: courses, // başlangıçta filtre yok
        ),
      );
    } catch (e, st) {
      debugPrint('CoursesCubit.loadData hatası: $e\n$st');
      emit(CoursesError(message: e.toString()));
    }
  }

  /// Seçili dönemi günceller; [FilterCoursesByPeriodUseCase] ile filtreler.
  void selectPeriod(PeriodModel period) {
    final current = state;
    if (current is CoursesLoaded) {
      final filtered = _filterUseCase(current.courses, period);
      emit(current.copyWith(selectedPeriod: period, filteredCourses: filtered));
    }
  }
}
