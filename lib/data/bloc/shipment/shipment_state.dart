part of 'shipment_cubit.dart';

sealed class ShipmentState extends Equatable {
  const ShipmentState();

  @override
  List<Object> get props => [];
}

final class ShipmentInitial extends ShipmentState {}

final class ShipmentOptionsLoaded extends ShipmentState {
  final List<ShipmentModel> options;
  const ShipmentOptionsLoaded({required this.options});
}

final class ShipmentOptionsError extends ShipmentState {}

final class ShipmentOptionsLoading extends ShipmentState {}
