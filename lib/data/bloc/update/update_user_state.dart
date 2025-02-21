part of 'update_user_cubit.dart';

sealed class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => [];
}

final class UpdateUserInitial extends UpdateUserState {}

final class UpdateUserLoading extends UpdateUserState {}

final class UpdateUserError extends UpdateUserState {
  final String message;
  const UpdateUserError(this.message);
}

final class UpdateUserSuccess extends UpdateUserState {}
