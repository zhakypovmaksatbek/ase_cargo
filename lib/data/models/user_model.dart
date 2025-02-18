class UserModel {
  String? avatar;
  String? email;
  String? phone;
  String? fullName;
  String? firstName;
  String? lastName;

  UserModel({this.avatar, this.email, this.phone, this.fullName});

  UserModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['email'] = email;
    data['phone'] = phone;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
