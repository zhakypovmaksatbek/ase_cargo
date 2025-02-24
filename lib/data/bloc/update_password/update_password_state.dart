part of 'update_password_cubit.dart';

sealed class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

final class UpdatePasswordInitial extends UpdatePasswordState {}

final class UpdatePasswordSuccess extends UpdatePasswordState {}

final class UpdatePasswordError extends UpdatePasswordState {
  final ChangePasswordResponseModel errorMessage;

  const UpdatePasswordError({required this.errorMessage});
}

final class UpdatePasswordLoading extends UpdatePasswordState {}

class ChangePasswordResponseModel {
  String? detail;
  List<String>? newPassword;

  ChangePasswordResponseModel({this.detail, this.newPassword});

  ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    newPassword = json['new_password']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['detail'] = detail;
    data['new_password'] = newPassword;
    return data;
  }
}
