part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserSuccess extends UserState {
  final UserModel user;
  const UserSuccess(this.user);
}

final class UserError extends UserState {
  final String message;
  const UserError(this.message);
}

final class UserLoading extends UserState {}

final class UserUnauthorized extends UserState {}
