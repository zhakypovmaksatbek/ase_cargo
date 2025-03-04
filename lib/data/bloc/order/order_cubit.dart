// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/order_model.dart';
import 'package:ase/data/repo/order_repo.dart';
import 'package:ase/presentation/pages/order/options/order_options.dart';
import 'package:ase/presentation/pages/profile/views/order/options/order_options.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit(
    this.repo,
  ) : super(OrderInitial());
  final IOrderRepo repo;
  Future<void> getOrder(int page,
      {ShipmentOption? option = ShipmentOption.sender,
      OrderStatus? status,
      bool? isRefresh}) async {
    emit(OrderLoading());
    try {
      final response =
          await repo.getOrders(page, option: option!, status: status);
      emit(OrderLoaded(response, isRefresh: isRefresh));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
