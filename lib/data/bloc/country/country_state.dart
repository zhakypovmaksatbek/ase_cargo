part of 'country_cubit.dart';

sealed class CountryState extends Equatable {
  const CountryState();

  @override
  List<Object> get props => [];
}

final class CountryInitial extends CountryState {}

final class CountrySuccess extends CountryState {
  final List<CountryModel> countries;
  const CountrySuccess(this.countries);
}

final class CountryError extends CountryState {
  final String message;
  const CountryError(this.message);
}

final class CountryLoading extends CountryState {}
