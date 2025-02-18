class UserModel {
  String? avatar;
  String? email;
  String? phone;
  String? fullName;

  UserModel({this.avatar, this.email, this.phone, this.fullName});

  UserModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['email'] = email;
    data['phone'] = phone;
    data['full_name'] = fullName;
    return data;
  }
}
