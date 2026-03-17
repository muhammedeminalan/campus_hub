import 'package:campus_hub/features/academic_advisor/data/model/advisor_model.dart';
import 'package:campus_hub/features/academic_advisor/domain/i_academic_advisor_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'academic_advisor_state.dart';

class AcademicAdvisorCubit extends Cubit<AcademicAdvisorState> {
  final IAcademicAdvisorService _service;

  AcademicAdvisorCubit({required IAcademicAdvisorService service})
      : _service = service,
        super(const AcademicAdvisorInitial());

  /// Öğrencinin akademik danışman bilgisini yükler.
  Future<void> loadAdvisor() async {
    emit(const AcademicAdvisorLoading());

    try {
      final advisor = await _service.getAdvisor();
      if (advisor != null) {
        emit(AcademicAdvisorLoaded(advisor: advisor));
      } else {
        emit(const AcademicAdvisorError());
      }
    } catch (e, st) {
      debugPrint('AcademicAdvisorCubit.loadAdvisor hatası: $e\n$st');
      emit(AcademicAdvisorError(message: e.toString()));
    }
  }
}
