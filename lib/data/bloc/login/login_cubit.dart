
import 'package:ase/data/models/login_model.dart';
import 'package:ase/data/repo/user_repo.dart';
import 'package:dio/dio.dart';
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
      emit(LoginError(e.response?.data['detail'] ?? ""));
    }
  }
}
