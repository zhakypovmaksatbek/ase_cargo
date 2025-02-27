import 'package:ase/data/models/form_detail_model.dart';
import 'package:ase/data/repo/form_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'form_detail_state.dart';

class FormDetailCubit extends Cubit<FormDetailState> {
  FormDetailCubit() : super(FormDetailInitial());
  final _repo = FormRepo();

  Future<void> getFormDetail() async {
    emit(FormDetailLoading());
    try {
      await _repo
          .getFormDetail()
          .then((value) => emit(FormDetailSuccess(value)));
    } catch (e) {
      emit(FormDetailError());
    }
  }
}
