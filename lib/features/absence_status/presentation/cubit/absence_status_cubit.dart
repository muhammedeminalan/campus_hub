import 'package:campus_hub/features/absence_status/data/model/absence_course_model.dart';
import 'package:campus_hub/features/absence_status/domain/i_absence_service.dart';
import 'package:campus_hub/features/absence_status/domain/usecases/calculate_absence_summary_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'absence_status_state.dart';

class AbsenceStatusCubit extends Cubit<AbsenceStatusState> {
  AbsenceStatusCubit({
    required IAbsenceService service,
    CalculateAbsenceSummaryUseCase? summaryUseCase,
  }) : _service = service,
       _summaryUseCase =
           summaryUseCase ?? const CalculateAbsenceSummaryUseCase(),
       super(const AbsenceStatusInitial());

  final IAbsenceService _service;
  final CalculateAbsenceSummaryUseCase _summaryUseCase;

  /// Devamsızlık verisini yükler ve özet metrikleri hesaplar.
  /// Neden: ekranın tüm alanları tek state güncellemesinde senkron dursun.
  Future<void> loadData() async {
    emit(const AbsenceStatusLoading());

    try {
      final courses = await _service.getAll();
      final summary = _summaryUseCase(courses);

      emit(AbsenceStatusLoaded(courses: courses, summary: summary));
    } catch (e, st) {
      debugPrint('AbsenceStatusCubit.loadData hatası: $e\n$st');
      emit(AbsenceStatusError(message: e.toString()));
    }
  }
}
