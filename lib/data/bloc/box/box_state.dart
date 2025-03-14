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
  final bool isRefresh;
  final CourierOrderStatus status;
  const BoxLoaded(this.box, this.status, {this.isRefresh = false});

  @override
  List<Object> get props => [box, isRefresh, status];
}

final class BoxError extends BoxState {
  final String message;

  const BoxError(this.message);

  @override
  List<Object> get props => [message];
}
