import 'package:ase/data/models/order_detail_model.dart';
import 'package:ase/data/repo/order_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_detail_state.dart';

class OrderDetailCubit extends Cubit<OrderDetailState> {
  OrderDetailCubit() : super(OrderDetailInitial());
  final _repo = OrderRepo();

  Future<void> getOrderDetail(String number) async {
    emit(OrderDetailLoading());
    try {
      final orderDetail = await _repo.getOrderDetail(number);
      emit(OrderDetailSuccess(orderDetail));
    } catch (e) {
      emit(OrderDetailError(e.toString()));
    }
  }
}
