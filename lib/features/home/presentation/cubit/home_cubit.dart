import 'package:campus_hub/core/contracts/student/i_student_service.dart';
import 'package:campus_hub/features/home/data/model/student_card_model.dart';
import 'package:campus_hub/features/home/presentation/model/academic_calendar_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final IStudentService _service;

  HomeCubit({required IStudentService service})
    : _service = service,
      super(const HomeInitial());

  Future<void> loadHomeData() async {
    emit(const HomeLoading());
    try {
      final results = await Future.wait([
        _service.getStudentCard(),
        _service.getCalendarEvents(),
      ]);
      emit(
        HomeLoaded(
          studentCard: results[0] as StudentCardModel,
          calendarEvents: results[1] as List<AcademicCalendarModel>,
        ),
      );
    } catch (e, st) {
      debugPrint('HomeCubit.loadHomeData hatası: $e\n$st');
      emit(HomeError(message: e.toString()));
    }
  }
}
