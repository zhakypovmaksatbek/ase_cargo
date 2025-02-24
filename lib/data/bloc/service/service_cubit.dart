import 'package:ase/data/models/service_model.dart';
import 'package:ase/data/repo/product_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'service_state.dart';

class ServiceCubit extends Cubit<ServiceState> {
  ServiceCubit() : super(ServiceInitial());
  final ProductRepo serviceRepo = ProductRepo();
  Future<void> getService(int page) async {
    emit(ServiceLoading());
    try {
      final services = await serviceRepo.getServices(page);
      emit(ServiceSuccess(services));
    } catch (e) {
      emit(ServiceError(e.toString()));
    }
  }
}
