part of 'search_box_cubit.dart';

sealed class SearchBoxState extends Equatable {
  const SearchBoxState();

  @override
  List<Object> get props => [];
}

final class SearchBoxInitial extends SearchBoxState {}

final class SearchBoxLoading extends SearchBoxState {}

final class SearchBoxLoaded extends SearchBoxState {
  final BoxModel box;
  const SearchBoxLoaded({required this.box});
}

final class SearchBoxError extends SearchBoxState {
  final String message;
  const SearchBoxError({required this.message});
}
