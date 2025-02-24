import 'package:ase/data/repo/user_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit() : super(UpdatePasswordInitial());

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    emit(UpdatePasswordLoading());
    try {
      await UserRepo().updatePassword(oldPassword, newPassword);
      emit(UpdatePasswordSuccess());
    } on DioException catch (e) {
      emit(UpdatePasswordError(
          errorMessage:
              ChangePasswordResponseModel.fromJson(e.response?.data)));
    }
  }
}
