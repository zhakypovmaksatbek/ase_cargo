part of 'order_detail_cubit.dart';

sealed class OrderDetailState extends Equatable {
  const OrderDetailState();

  @override
  List<Object> get props => [];
}

final class OrderDetailInitial extends OrderDetailState {}

final class OrderDetailSuccess extends OrderDetailState {
  final OrderDetailModel orderDetail;
  const OrderDetailSuccess(this.orderDetail);
}

final class OrderDetailError extends OrderDetailState {
  final String message;
  const OrderDetailError(this.message);
}

final class OrderDetailLoading extends OrderDetailState {}
