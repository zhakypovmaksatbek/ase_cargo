import 'package:ase/data/models/login_model.dart';
import 'package:ase/data/repo/user_repo.dart';
import 'package:ase/generated/locale_keys.g.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final _userRepo = UserRepo();

  Future<void> login(LoginModel model) async {
    emit(LoginLoading());
    try {
      await _userRepo.login(model);
      emit(LoginSuccess());
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.connectionError) {
        emit(LoginError(
            LoginErrorModel(detail: LocaleKeys.exception_no_internet.tr())));
        return;
      }
      emit(LoginError(LoginErrorModel.fromJson(e.response?.data)));
    }
  }
}
