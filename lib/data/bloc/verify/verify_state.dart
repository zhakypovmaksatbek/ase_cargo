part of 'verify_cubit.dart';

sealed class VerifyState extends Equatable {
  const VerifyState();

  @override
  List<Object> get props => [];
}

final class VerifyInitial extends VerifyState {}

final class VerifyLoading extends VerifyState {}

final class VerifySuccess extends VerifyState {
  final VerifyModel model;
  const VerifySuccess(this.model);
}

final class VerifyError extends VerifyState {
  final VerifyErrorModel message;
  const VerifyError(this.message);
}
