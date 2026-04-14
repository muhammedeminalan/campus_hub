part of 'absence_status_cubit.dart';

sealed class AbsenceStatusState extends Equatable {
  const AbsenceStatusState();

  @override
  List<Object?> get props => [];
}

final class AbsenceStatusInitial extends AbsenceStatusState {
  const AbsenceStatusInitial();
}

final class AbsenceStatusLoading extends AbsenceStatusState {
  const AbsenceStatusLoading();
}

final class AbsenceStatusLoaded extends AbsenceStatusState {
  const AbsenceStatusLoaded({required this.courses, required this.summary});

  final List<AbsenceCourseModel> courses;
  final AbsenceSummary summary;

  @override
  List<Object?> get props => [courses, summary];
}

final class AbsenceStatusError extends AbsenceStatusState {
  const AbsenceStatusError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}
