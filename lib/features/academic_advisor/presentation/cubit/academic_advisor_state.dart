part of 'academic_advisor_cubit.dart';

sealed class AcademicAdvisorState extends Equatable {
  const AcademicAdvisorState();

  @override
  List<Object?> get props => [];
}

final class AcademicAdvisorInitial extends AcademicAdvisorState {
  const AcademicAdvisorInitial();
}

final class AcademicAdvisorLoading extends AcademicAdvisorState {
  const AcademicAdvisorLoading();
}

final class AcademicAdvisorLoaded extends AcademicAdvisorState {
  final AdvisorModel advisor;

  const AcademicAdvisorLoaded({required this.advisor});

  @override
  List<Object?> get props => [advisor];
}

final class AcademicAdvisorError extends AcademicAdvisorState {
  final String? message;

  const AcademicAdvisorError({this.message});

  @override
  List<Object?> get props => [message];
}
