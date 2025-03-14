import 'package:ase/core/app_manager.dart';
import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/router/app_router.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'box_state.dart';

class BoxCubit extends Cubit<BoxState> {
  BoxCubit() : super(BoxInitial());

  final _courierRepo = CourierRepo();
  final _router = getIt<AppRouter>();
  Future<void> getBox(CourierOrderStatus status,
      {bool isRefresh = false}) async {
    emit(BoxLoading());
    try {
      final box = await _courierRepo.getBox(status);
      emit(BoxLoaded(box, status, isRefresh: isRefresh));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        emit(BoxError(LocaleKeys.exception_no_internet.tr()));
        return;
      } else if (e.response?.statusCode == 401) {
        emit(BoxError(LocaleKeys.exception_unknown_error.tr()));
        await AppManager.instance.clearTokens();

        _router.replaceAll([LoginRoute()]);
        return;
      } else if (e.response != null && e.response?.data != null) {
        String errorMessage;
        if (e.response?.data is Map && e.response?.data['detail'] is String) {
          errorMessage = e.response?.data['detail'];
        } else {
          errorMessage =
              LocaleKeys.exception_something_went_wrong_try_again.tr();
        }
        emit(BoxError(errorMessage));
      }
    }
  }
}
