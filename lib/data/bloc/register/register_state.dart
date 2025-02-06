part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResponceModel model;
  const RegisterSuccess(this.model);
}

final class RegisterError extends RegisterState {
  final RegisterErrorModel message;

  const RegisterError(this.message);
}
