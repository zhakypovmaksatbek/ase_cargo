import 'package:ase/data/models/register_model.dart';
import 'package:ase/data/models/verify_model.dart';
import 'package:ase/data/repo/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'resent_code_state.dart';

class ResentCodeCubit extends Cubit<ResentCodeState> {
  ResentCodeCubit() : super(ResentCodeInitial());

  final _repo = UserRepo();

  Future<void> resentCode(String phone) async {
    emit(ResentCodeLoading());
    final response = await _repo.resentCode(phone);
    emit(ResentCodeSuccess(response));
  }
}
