part of 'request_detail_cubit.dart';

sealed class RequestDetailState extends Equatable {
  const RequestDetailState();

  @override
  List<Object> get props => [];
}

final class RequestDetailInitial extends RequestDetailState {}

final class RequestDetailLoaded extends RequestDetailState {
  final RequestDetailModel requestDetail;
  const RequestDetailLoaded(this.requestDetail);
}

final class RequestDetailError extends RequestDetailState {
  final String error;

  const RequestDetailError({required this.error});
}

final class RequestDetailLoading extends RequestDetailState {}
