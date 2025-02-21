import 'package:ase/data/models/user_model.dart';
import 'package:ase/data/repo/user_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(UpdateUserInitial());
  final _repo = UserRepo();

  Future<void> updateProfile(UserModel user,
      {XFile? image, required UserModel originalUser}) async {
    emit(UpdateUserLoading());
    try {
      await _repo
          .updateProfile(user, image: image, originalUser: originalUser)
          .then((value) {
        emit(UpdateUserSuccess());
      });
    } catch (e) {
      emit(UpdateUserError(e.toString()));
    }
  }
}
