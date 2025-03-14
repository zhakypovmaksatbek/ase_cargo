import 'package:ase/data/models/box_model.dart';
import 'package:ase/data/repo/courier_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_box_state.dart';

class SearchBoxCubit extends Cubit<SearchBoxState> {
  final CourierRepo repo = CourierRepo();
  SearchBoxCubit() : super(SearchBoxInitial());

  Future<void> searchOrder(String orderCode) async {
    emit(SearchBoxLoading());
    try {
      final box = await repo.searchOrder(orderCode);
      emit(SearchBoxLoaded(box: box));
    } catch (e) {
      emit(SearchBoxError(message: e.toString()));
    }
  }
}
