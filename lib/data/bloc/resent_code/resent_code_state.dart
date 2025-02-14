part of 'resent_code_cubit.dart';

sealed class ResentCodeState extends Equatable {
  const ResentCodeState();

  @override
  List<Object> get props => [];
}

final class ResentCodeInitial extends ResentCodeState {}

final class ResentCodeLoading extends ResentCodeState {}

final class ResentCodeSuccess extends ResentCodeState {
  final RegisterResponseModel model;

  const ResentCodeSuccess(this.model);

  @override
  List<Object> get props => [model];
}

final class ResentCodeError extends ResentCodeState {
  final VerifyErrorModel error;

  const ResentCodeError(this.error);

  @override
  List<Object> get props => [error];
}
