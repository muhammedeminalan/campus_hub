import 'package:campus_hub/features/exam_results/domain/i_exam_result_service.dart';
import 'package:campus_hub/core/models/period_model.dart';
import 'package:campus_hub/core/models/exam_result_model.dart';
import 'package:campus_hub/features/exam_results/domain/usecases/group_exam_results_by_course_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'exam_results_state.dart';

class ExamResultsCubit extends Cubit<ExamResultsState> {
  final IExamResultService _service;
  final GroupExamResultsByCourseUseCase _groupUseCase;

  ExamResultsCubit({
    required IExamResultService service,
    GroupExamResultsByCourseUseCase? groupUseCase,
  }) : _service = service,
       _groupUseCase = groupUseCase ?? const GroupExamResultsByCourseUseCase(),
       super(const ExamResultsInitial());

  /// Dönem ve sınav sonucu verilerini yükler.
  /// Varsayılan seçili dönem: verisi olan en son dönem.
  Future<void> loadData() async {
    emit(const ExamResultsLoading());

    try {
      final (periods, allResults) = await (
        _service.getPeriods(),
        _service.getAll(),
      ).wait;

      final defaultPeriod = _resolveDefaultPeriod(periods, allResults);
      final periodResults = _filterByPeriod(allResults, defaultPeriod);
      final grouped = _groupUseCase(periodResults);

      emit(
        ExamResultsLoaded(
          periods: periods,
          allResults: allResults,
          selectedPeriod: defaultPeriod,
          grouped: grouped,
        ),
      );
    } catch (e, st) {
      debugPrint('ExamResultsCubit.loadData hatası: $e\n$st');
      emit(ExamResultsError(message: e.toString()));
    }
  }

  /// Seçili dönemi günceller ve sonuçları yeniden gruplandırır.
  void selectPeriod(PeriodModel period) {
    final current = state;
    if (current is! ExamResultsLoaded) return;

    final periodResults = _filterByPeriod(current.allResults, period);
    final grouped = _groupUseCase(periodResults);
    emit(current.copyWith(selectedPeriod: period, grouped: grouped));
  }

  // ── Private helpers ──────────────────────────────────────────────────────

  /// Verisi olan en son dönemi döner; yoksa listenin son elemanını alır.
  PeriodModel? _resolveDefaultPeriod(
    List<PeriodModel> periods,
    List<ExamResultModel> allResults,
  ) {
    if (periods.isEmpty) return null;
    return periods.lastWhere(
      (p) => allResults.any((r) => r.periodId == p.id),
      orElse: () => periods.last,
    );
  }

  List<ExamResultModel> _filterByPeriod(
    List<ExamResultModel> allResults,
    PeriodModel? period,
  ) {
    if (period == null) return [];
    return allResults.where((r) => r.periodId == period.id).toList();
  }
}
