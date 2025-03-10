class TokenModel {
  String? refresh;
  String? access;
  int? expiresIn;

  TokenModel({this.refresh, this.access, this.expiresIn = 36});

  TokenModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['refresh'] = refresh;
    data['access'] = access;
    return data;
  }
}
