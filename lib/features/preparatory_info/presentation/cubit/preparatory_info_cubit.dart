import 'package:campus_hub/features/preparatory_info/domain/i_preparatory_info_service.dart';
import 'package:campus_hub/features/preparatory_info/domain/usecases/calculate_preparatory_progress_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/preparatory_info_model.dart';

part 'preparatory_info_state.dart';

class PreparatoryInfoCubit extends Cubit<PreparatoryInfoState> {
  PreparatoryInfoCubit({
    required IPreparatoryInfoService service,
    CalculatePreparatoryProgressUseCase? calculateUseCase,
  }) : _service = service,
       _calculateUseCase =
           calculateUseCase ?? const CalculatePreparatoryProgressUseCase(),
       super(const PreparatoryInfoInitial());

  final IPreparatoryInfoService _service;
  final CalculatePreparatoryProgressUseCase _calculateUseCase;

  /// Hazırlık bilgisi verisini yükler.
  /// Neden: özet ve liste alanları tek state üzerinden senkron beslensin.
  Future<void> loadData() async {
    emit(const PreparatoryInfoLoading());

    try {
      final info = await _service.getCurrent();

      if (info == null) {
        emit(
          const PreparatoryInfoError(message: 'Hazırlık bilgisi bulunamadı.'),
        );
        return;
      }

      final summary = _calculateUseCase(info);
      emit(PreparatoryInfoLoaded(info: info, summary: summary));
    } catch (e, st) {
      debugPrint('PreparatoryInfoCubit.loadData hatası: $e\n$st');
      emit(PreparatoryInfoError(message: e.toString()));
    }
  }
}
