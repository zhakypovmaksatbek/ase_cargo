part of 'order_cubit.dart';

sealed class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

final class OrderLoading extends OrderState {}

final class OrderLoaded extends OrderState {
  final OrderPaginationModel model;
  final bool? isRefresh;
  const OrderLoaded(this.model, {this.isRefresh});
}

final class OrderError extends OrderState {
  final String message;
  const OrderError(this.message);
}
