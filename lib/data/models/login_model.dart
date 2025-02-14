class LoginModel {
  String? phone;
  String? password;

  LoginModel({this.phone, this.password});

  LoginModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    return data;
  }
}

class LoginErrorModel {
  String? detail;
  List<String>? phone;
  List<String>? password;

  LoginErrorModel({this.detail, this.phone, this.password});

  LoginErrorModel.fromJson(Map<String, dynamic> json) {
    detail = json['detail'];
    phone =
        (json['phone'] as List<dynamic>?)?.map((e) => e.toString()).toList();
    password =
        (json['password'] as List<dynamic>?)?.map((e) => e.toString()).toList();
  }
}
