import 'package:ase/data/models/register_model.dart';
import 'package:ase/data/repo/user_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final _userRepo = UserRepo();

  Future<void> register(RegisterModel model) async {
    emit(RegisterLoading());
    try {
      final result = await _userRepo.register(model);
      emit(RegisterSuccess(result));
    } on DioException catch (e) {
      emit(RegisterError(RegisterErrorModel.fromJson(e.response?.data)));
    }
  }

  void clearError(String field) {
    if (state is RegisterError) {
      final error = (state as RegisterError).message;

      final newError = RegisterErrorModel(
        phone: field == "phone" ? null : error.phone,
        password: field == "password" ? null : error.password,
        firstName: field == "firstName" ? null : error.firstName,
        lastName: field == "lastName" ? null : error.lastName,
        email: field == "email" ? null : error.email,
        detail: error.detail,
      );

      emit(RegisterInitial());
      emit(RegisterError(newError));
    }
  }
}
