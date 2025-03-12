part of 'order_history_cubit.dart';

sealed class OrderHistoryState extends Equatable {
  const OrderHistoryState();

  @override
  List<Object> get props => [];
}

final class OrderHistoryInitial extends OrderHistoryState {}

final class OrderHistoryLoading extends OrderHistoryState {}

final class OrderHistoryLoaded extends OrderHistoryState {
  final BoxPaginationModel data;
  const OrderHistoryLoaded(this.data);
}

final class OrderHistoryError extends OrderHistoryState {
  final String message;
  const OrderHistoryError(this.message);
}
