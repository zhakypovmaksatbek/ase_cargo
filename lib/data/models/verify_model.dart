class VerifyModel {
  String? phone;
  String? code;
  String? verifyToken;

  VerifyModel({this.phone, this.code, this.verifyToken});

  VerifyModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    code = json['code'];
    verifyToken = json['verify_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phone'] = phone;
    data['code'] = code;
    data['verify_token'] = verifyToken;
    return data;
  }
}

class VerifyErrorModel {
  List<String>? code;

  String? detail;

  VerifyErrorModel({
    this.code,
    this.detail,
  });

  factory VerifyErrorModel.fromJson(Map<String, dynamic> json) {
    return VerifyErrorModel(
      code: (json['code'] as List<dynamic>?)?.map((e) => e.toString()).toList(),
      detail: json['detail'] as String?,
    );
  }
}
