import 'package:ase/data/models/banner_model.dart';
import 'package:ase/data/repo/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit() : super(BannerInitial());

  Future<void> getHomeData() async {
    emit(BannerLoading());
    try {
      await _repo.getHomeData().then((value) {
        emit(BannerLoaded(data: value));
      });
    } catch (e) {
      emit(BannerError(errorMessage: e.toString()));
    }
  }

  final ProductRepo _repo = ProductRepo();
}
