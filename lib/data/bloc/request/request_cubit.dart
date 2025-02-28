// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/request_model.dart';
import 'package:ase/data/repo/order_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'request_state.dart';

class RequestCubit extends Cubit<RequestState> {
  RequestCubit(
    this.repo,
  ) : super(RequestInitial());

  final IOrderRepo repo;

  Future<void> getRequests(int page, {bool isRefresh = false}) async {
    emit(RequestLoading());
    try {
      await repo.getRequests(page).then((value) {
        emit(RequestLoaded(value, isRefresh: isRefresh));
      });
    } catch (e) {
      emit(RequestError(error: e.toString()));
    }
  }
}
