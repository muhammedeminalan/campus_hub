part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class HomeLoading extends HomeState {
  const HomeLoading();
}

final class HomeLoaded extends HomeState {
  final StudentCardModel studentCard;
  final List<AcademicCalendarModel> calendarEvents;

  const HomeLoaded({required this.studentCard, required this.calendarEvents});

  @override
  List<Object?> get props => [studentCard, calendarEvents];
}

final class HomeError extends HomeState {
  final String? message;

  const HomeError({this.message});

  @override
  List<Object?> get props => [message];
}
