import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UserModel {
  String? avatar;
  String? email;
  String? fullName;
  String? firstName;
  String? lastName;
  String? phone;

  UserModel(
      {this.avatar,
      this.email,
      this.fullName,
      this.firstName,
      this.lastName,
      this.phone});

  /// JSON'dan model oluşturma
  UserModel.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    email = json['email'];
    fullName = json['full_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
  }

  /// Modeli JSON'a dönüştürme
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (avatar != null) data['avatar'] = avatar;
    if (email != null) data['email'] = email;
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;

    return data;
  }

  /// Değişiklik olup olmadığını kontrol eder
  bool hasChanges(UserModel other) {
    return avatar != other.avatar ||
        firstName != other.firstName ||
        lastName != other.lastName ||
        email != other.email;
  }

  /// Kopya nesne oluşturma (copyWith)
  UserModel copyWith({
    String? avatar,
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return UserModel(
      avatar: avatar ?? this.avatar,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      fullName: (firstName ?? this.firstName) != null &&
              (lastName ?? this.lastName) != null
          ? '${firstName ?? this.firstName} ${lastName ?? this.lastName}'
          : fullName,
    );
  }

  /// Sadece değişen alanları JSON olarak döndürür
  Map<String, dynamic> toUpdatedJson(
      {required UserModel user, required UserModel original}) {
    Map<String, dynamic> updatedData = {};

    if (user.avatar != original.avatar) updatedData['avatar'] = user.avatar;
    if (user.firstName != original.firstName) {
      updatedData['first_name'] = user.firstName;
    }
    if (user.lastName != original.lastName) {
      updatedData['last_name'] = user.lastName;
    }
    if (user.email != original.email) updatedData['email'] = user.email;

    return updatedData;
  }

  Future<FormData> toFormData(
      {XFile? image, required UserModel originalUser}) async {
    Map<String, dynamic> data = {};

    // Eğer avatar değiştiyse ekle
    if (image != null) {
      data['avatar'] = [
        await MultipartFile.fromFile(image.path, filename: image.name)
      ];
    }

    // Sadece değişen alanları ekle
    if (fullName != originalUser.fullName) data['full_name'] = fullName;
    if (email != originalUser.email) data['email'] = email;

    return FormData.fromMap(data);
  }
}
