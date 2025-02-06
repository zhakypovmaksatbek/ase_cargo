class ResetPasswordModel {
  String? newPassword;
  String? oldPassword;

  ResetPasswordModel({this.newPassword, this.oldPassword});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    newPassword = json['new_password'];
    oldPassword = json['old_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['new_password'] = newPassword;
    data['old_password'] = oldPassword;
    return data;
  }
}
