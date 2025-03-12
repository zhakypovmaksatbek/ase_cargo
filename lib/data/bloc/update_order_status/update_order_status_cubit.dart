import 'package:ase/data/models/signature_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_order_status_state.dart';

class UpdateOrderStatusCubit extends Cubit<UpdateOrderStatusState> {
  UpdateOrderStatusCubit() : super(UpdateOrderStatusInitial());
  final repo = CourierRepo();
  Future<void> doneOrder(String orderCode, SignatureModel signature) async {
    emit(UpdateOrderStatusLoading());
    try {
      await repo.doneOrder(orderCode, signature);
      emit(UpdateOrderStatusSuccess());
    } catch (e) {
      emit(UpdateOrderStatusError(e.toString()));
    }
  }

  Future<void> cancelOrder(String orderCode, String reason) async {
    emit(UpdateOrderStatusLoading());
    try {
      await repo.cancelOrder(orderCode, reason);
      emit(UpdateOrderStatusSuccess());
    } catch (e) {
      emit(UpdateOrderStatusError(e.toString()));
    }
  }
}
