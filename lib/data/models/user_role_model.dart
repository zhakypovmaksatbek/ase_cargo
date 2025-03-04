class UserRoleModel {
  int? userId;
  List<String>? roles;

  UserRoleModel({this.userId, this.roles});

  UserRoleModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roles = json['roles'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['roles'] = roles;
    return data;
  }
}
