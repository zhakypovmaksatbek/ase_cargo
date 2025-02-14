class RegisterModel {
  String? phone;
  String? password;
  String? firstName;
  String? lastName;
  String? email;

  RegisterModel(
      {this.phone, this.password, this.firstName, this.lastName, this.email});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    password = json['password'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['password'] = password;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    return data;
  }
}

class RegisterResponseModel {
  String? verifyToken;
  String? testCode;

  RegisterResponseModel({this.verifyToken, this.testCode});

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    verifyToken = json['verify_token'];
    testCode = json['test_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verify_token'] = verifyToken;
    data['test_code'] = testCode;
    return data;
  }
}

class RegisterErrorModel {
  List<String>? phone;
  List<String>? password;
  List<String>? firstName;
  List<String>? lastName;
  List<String>? email;
  String? detail;

  RegisterErrorModel({
    this.phone,
    this.password,
    this.firstName,
    this.lastName,
    this.email,
    this.detail,
  });

  factory RegisterErrorModel.fromJson(Map<String, dynamic> json) {
    return RegisterErrorModel(
      phone:
          (json['phone'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      password: (json['password'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      firstName: (json['first_name'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      lastName: (json['last_name'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      email:
          (json['email'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      detail: json['detail'] as String?,
    );
  }
}
