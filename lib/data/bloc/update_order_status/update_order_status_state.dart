part of 'update_order_status_cubit.dart';

sealed class UpdateOrderStatusState extends Equatable {
  const UpdateOrderStatusState();

  @override
  List<Object> get props => [];
}

final class UpdateOrderStatusInitial extends UpdateOrderStatusState {}

final class UpdateOrderStatusLoading extends UpdateOrderStatusState {}

final class UpdateOrderStatusSuccess extends UpdateOrderStatusState {}

final class UpdateOrderStatusError extends UpdateOrderStatusState {
  final String message;
  const UpdateOrderStatusError(this.message);
  @override
  List<Object> get props => [message];
}
