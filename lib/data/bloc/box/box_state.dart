part of 'box_cubit.dart';

sealed class BoxState extends Equatable {
  const BoxState();

  @override
  List<Object> get props => [];
}

final class BoxInitial extends BoxState {}

final class BoxLoading extends BoxState {}

final class BoxLoaded extends BoxState {
  final BoxPaginationModel box;

  const BoxLoaded(this.box);

  @override
  List<Object> get props => [box];
}

final class BoxError extends BoxState {
  final String message;

  const BoxError(this.message);

  @override
  List<Object> get props => [message];
}
