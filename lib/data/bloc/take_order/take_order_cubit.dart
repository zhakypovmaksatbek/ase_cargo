import 'package:ase/data/repo/courier_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'take_order_state.dart';

class TakeOrderCubit extends Cubit<TakeOrderState> {
  TakeOrderCubit() : super(TakeOrderInitial());
  final CourierRepo _courierRepo = CourierRepo();
  Future<void> takeOrder(String boxCode) async {
    emit(TakeOrderLoading(boxCode: boxCode));
    try {
      await _courierRepo.addOrder(boxCode);
      emit(TakeOrderLoaded());
    } catch (e) {
      String errorMessage = "Bir hata oluştu!"; // Varsayılan hata mesajı

      if (e is DioException) {
        // Eğer Dio kullanıyorsan
        final response = e.response;
        if (response != null && response.data is List) {
          errorMessage = response.data[0].toString(); // Gelen hatayı al
        }
      }

      emit(TakeOrderError(message: errorMessage));
    }
  }
}
