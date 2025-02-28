part of 'request_cubit.dart';

sealed class RequestState extends Equatable {
  const RequestState();

  @override
  List<Object> get props => [];
}

final class RequestInitial extends RequestState {}

final class RequestLoading extends RequestState {}

final class RequestLoaded extends RequestState {
  final RequestPaginationModel model;
  final bool isRefresh;
  const RequestLoaded(this.model, {this.isRefresh = false});
}

final class RequestError extends RequestState {
  final String error;

  const RequestError({required this.error});
}
