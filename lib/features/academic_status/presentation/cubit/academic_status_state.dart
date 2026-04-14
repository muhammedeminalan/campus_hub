part of 'academic_status_cubit.dart';

sealed class AcademicStatusState extends Equatable {
  const AcademicStatusState();

  @override
  List<Object?> get props => [];
}

final class AcademicStatusInitial extends AcademicStatusState {
  const AcademicStatusInitial();
}

final class AcademicStatusLoading extends AcademicStatusState {
  const AcademicStatusLoading();
}

final class AcademicStatusLoaded extends AcademicStatusState {
  const AcademicStatusLoaded({required this.status, required this.summary});

  final AcademicStatusModel status;
  final AcademicStatusSummary summary;

  @override
  List<Object?> get props => [status, summary];
}

final class AcademicStatusError extends AcademicStatusState {
  const AcademicStatusError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}
