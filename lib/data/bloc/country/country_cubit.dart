// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ase/data/models/country_model.dart';
import 'package:ase/data/repo/form_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'country_state.dart';

class CountryCubit extends Cubit<CountryState> {
  CountryCubit(
    this.repo,
  ) : super(CountryInitial());
  final IFormRepo repo;
  Future<void> getCountries() async {
    emit(CountryLoading());
    try {
      final response = await repo.getCountries();
      emit(CountrySuccess(response));
    } catch (e) {
      emit(CountryError(e.toString()));
    }
  }
}
