part of 'exam_results_cubit.dart';

sealed class ExamResultsState extends Equatable {
  const ExamResultsState();

  @override
  List<Object?> get props => [];
}

final class ExamResultsInitial extends ExamResultsState {
  const ExamResultsInitial();
}

final class ExamResultsLoading extends ExamResultsState {
  const ExamResultsLoading();
}

final class ExamResultsLoaded extends ExamResultsState {
  final List<PeriodModel> periods;
  final List<ExamResultModel> allResults;
  final PeriodModel? selectedPeriod;
  final Map<String, List<ExamResultModel>> grouped;

  const ExamResultsLoaded({
    required this.periods,
    required this.allResults,
    required this.grouped,
    this.selectedPeriod,
  });

  ExamResultsLoaded copyWith({
    PeriodModel? selectedPeriod,
    Map<String, List<ExamResultModel>>? grouped,
  }) {
    return ExamResultsLoaded(
      periods: periods,
      allResults: allResults,
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      grouped: grouped ?? this.grouped,
    );
  }

  @override
  List<Object?> get props => [periods, allResults, selectedPeriod, grouped];
}

final class ExamResultsError extends ExamResultsState {
  final String? message;

  const ExamResultsError({this.message});

  @override
  List<Object?> get props => [message];
}
