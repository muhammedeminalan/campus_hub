import 'package:campus_hub/features/academic_status/data/model/academic_status_model.dart';
import 'package:campus_hub/features/academic_status/domain/i_academic_status_service.dart';
import 'package:campus_hub/features/academic_status/domain/usecases/calculate_academic_status_summary_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'academic_status_state.dart';

class AcademicStatusCubit extends Cubit<AcademicStatusState> {
  AcademicStatusCubit({
    required IAcademicStatusService service,
    CalculateAcademicStatusSummaryUseCase? calculateUseCase,
  }) : _service = service,
       _calculateUseCase =
           calculateUseCase ?? const CalculateAcademicStatusSummaryUseCase(),
       super(const AcademicStatusInitial());

  final IAcademicStatusService _service;
  final CalculateAcademicStatusSummaryUseCase _calculateUseCase;

  /// Akademik durum verisini yükler ve özet metrikleri hesaplar.
  /// Neden: ekranın tüm parçaları tek state güncellemesiyle senkron kalsın.
  Future<void> loadData() async {
    emit(const AcademicStatusLoading());

    try {
      final status = await _service.getCurrent();

      if (status == null) {
        emit(
          const AcademicStatusError(
            message: 'Akademik durum verisi bulunamadı.',
          ),
        );
        return;
      }

      final summary = _calculateUseCase(status);
      emit(AcademicStatusLoaded(status: status, summary: summary));
    } catch (e, st) {
      debugPrint('AcademicStatusCubit.loadData hatası: $e\n$st');
      emit(AcademicStatusError(message: e.toString()));
    }
  }
}
