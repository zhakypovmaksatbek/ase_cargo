import 'package:ase/core/app_manager.dart';
import 'package:ase/data/models/user_model.dart';
import 'package:ase/data/repo/user_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:ase/main.dart';
import 'package:ase/router/app_router.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  final _repo = UserRepo();
  final _router = getIt<AppRouter>();
  Future<void> getUser() async {
    emit(UserLoading());
    try {
      final response = await _repo.getUser();
      emit(UserSuccess(response));
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        emit(UserError(LocaleKeys.exception_no_internet.tr()));
        return;
      }
      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          await AppManager.instance.setToken(accessToken: '');
          await AppManager.instance.setIsLogin(false);
          emit(UserUnauthorized());
          _router.replaceAll([LoginRoute()]);
          return;
        } else if (e.response != null && e.response?.data != null) {
          String errorMessage;
          if (e.response?.data is Map && e.response?.data['error'] is String) {
            errorMessage = e.response?.data['error'];
          } else {
            errorMessage =
                LocaleKeys.exception_something_went_wrong_try_again.tr();
          }

          emit(UserError(errorMessage));
          return;
        }

        final errorMessage = e.response?.data['error'] ??
            LocaleKeys.exception_something_went_wrong_try_again.tr();
        emit(UserError(errorMessage));
        return;
      }

      emit(UserError(LocaleKeys.exception_unknown_error.tr()));
    } catch (e) {
      emit(UserError(LocaleKeys.exception_unexpected_error.tr()));
    }
  }
}
