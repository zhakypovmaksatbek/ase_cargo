import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'box_state.dart';

class BoxCubit extends Cubit<BoxState> {
  BoxCubit() : super(BoxInitial());

  final _courierRepo = CourierRepo();

  Future<void> getBox(CourierOrderStatus status) async {
    emit(BoxLoading());
    try {
      final box = await _courierRepo.getBox(status);
      emit(BoxLoaded(box));
    } catch (e) {
      emit(BoxError(e.toString()));
    }
  }
}
