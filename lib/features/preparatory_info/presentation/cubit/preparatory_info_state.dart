part of 'preparatory_info_cubit.dart';

sealed class PreparatoryInfoState extends Equatable {
  const PreparatoryInfoState();

  @override
  List<Object?> get props => [];
}

final class PreparatoryInfoInitial extends PreparatoryInfoState {
  const PreparatoryInfoInitial();
}

final class PreparatoryInfoLoading extends PreparatoryInfoState {
  const PreparatoryInfoLoading();
}

final class PreparatoryInfoLoaded extends PreparatoryInfoState {
  const PreparatoryInfoLoaded({required this.info, required this.summary});

  final PreparatoryInfoModel info;
  final PreparatoryProgressSummary summary;

  @override
  List<Object?> get props => [info, summary];
}

final class PreparatoryInfoError extends PreparatoryInfoState {
  const PreparatoryInfoError({this.message});

  final String? message;

  @override
  List<Object?> get props => [message];
}
