import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'order_history_state.dart';

class OrderHistoryCubit extends Cubit<OrderHistoryState> {
  OrderHistoryCubit() : super(OrderHistoryInitial());
  final ICourierRepo _repo = CourierRepo();
  Future<void> getOrderHistory(int page) async {
    emit(OrderHistoryLoading());
    final result = await _repo.getOrderHistory(page: page);
    emit(OrderHistoryLoaded(result));
  }
}
