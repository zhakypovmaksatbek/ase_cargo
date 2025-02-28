import 'package:ase/data/models/request_detail_model.dart';
import 'package:ase/data/repo/order_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_detail_state.dart';

class RequestDetailCubit extends Cubit<RequestDetailState> {
  RequestDetailCubit() : super(RequestDetailInitial());

  final OrderRepo _orderRepo = OrderRepo();

  Future<void> getDetail(int id) async {
    emit(RequestDetailLoading());
    try {
      final response = await _orderRepo.getRequestDetail(id);
      emit(RequestDetailLoaded(response));
    } on DioException catch (e) {
      emit(RequestDetailError(
          error: e.response?.data['detail'] ??
              LocaleKeys.exception_something_went_wrong_try_again.tr()));
    }
  }
}
