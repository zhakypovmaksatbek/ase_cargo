import 'package:ase/data/models/shipment_model.dart';
import 'package:ase/data/repo/form_repo.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shipment_state.dart';

class ShipmentCubit extends Cubit<ShipmentState> {
  ShipmentCubit() : super(ShipmentInitial());
  final _repo = FormRepo();

  Future<void> getShipmentOptions(ShipmentOption userRole) async {
    emit(ShipmentOptionsLoading());
    try {
      final options = await _repo.getShipmentOptions(userRole);
      emit(ShipmentOptionsLoaded(options: options));
    } catch (e) {
      emit(ShipmentOptionsError());
    }
  }
}
