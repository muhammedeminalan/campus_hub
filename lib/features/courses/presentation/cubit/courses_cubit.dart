import 'package:campus_hub/core/contracts/courses/i_course_service.dart';
import 'package:campus_hub/core/models/course_model.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final ICourseService _service;

  CoursesCubit({required ICourseService service})
      : _service = service,
        super(const CoursesInitial());

  /// Dönem ve ders verilerini yükler.
  /// Firebase'e geçince sadece [ICourseService] implementasyonunu değiştir.
  Future<void> loadData() async {
    emit(const CoursesLoading());
    try {
      final periods = await _service.getPeriods();
      final courses = await _service.getAll();
      emit(CoursesLoaded(periods: periods, courses: courses));
    } catch (_) {
      emit(const CoursesError());
    }
  }

  /// Seçili dönemi günceller; filtrelenmiş dersler otomatik hesaplanır.
  void selectPeriod(PeriodModel period) {
    final current = state;
    if (current is CoursesLoaded) {
      emit(current.copyWith(selectedPeriod: period));
    }
  }
}
