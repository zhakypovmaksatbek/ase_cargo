part of 'take_order_cubit.dart';

sealed class TakeOrderState extends Equatable {
  const TakeOrderState();

  @override
  List<Object> get props => [];
}

final class TakeOrderInitial extends TakeOrderState {}

final class TakeOrderLoading extends TakeOrderState {
  final String boxCode;

  const TakeOrderLoading({required this.boxCode});
}

final class TakeOrderLoaded extends TakeOrderState {}

final class TakeOrderError extends TakeOrderState {
  final String message;

  const TakeOrderError({required this.message});
}
