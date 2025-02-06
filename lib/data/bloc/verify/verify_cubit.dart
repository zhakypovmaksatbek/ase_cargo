import 'package:ase/data/models/verify_model.dart';
import 'package:ase/data/repo/user_repo.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(VerifyInitial());
  final _repo = UserRepo();
  Future<void> verify(VerifyModel model) async {
    emit(VerifyLoading());
    try {
      final result = await _repo.verify(model);
      emit(VerifySuccess(result));
    } on DioException catch (e) {
      emit(VerifyError(VerifyErrorModel.fromJson(e.response?.data)));
    }
  }

  void clearError() {
    if (state is VerifyError) {
      final newError = VerifyErrorModel(
        code: null,
        detail: null,
      );
      emit(VerifyInitial());
      emit(VerifyError(newError));
    }
  }
}
