class UserModel {
  String? avatar;
  String? email;
  String? phone;
  String? fullName;
  String? firstName;
  String? lastName;

  UserModel(
      {this.avatar,
      this.email,
      this.phone,
      this.fullName,
      this.firstName,
      this.lastName});

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
    if (email != null) data['email'] = email;
    if (firstName != null) data['first_name'] = firstName;
    if (lastName != null) data['last_name'] = lastName;

    return data;
  }

  bool hasChanges(UserModel other) {
    return firstName != other.firstName ||
        lastName != other.lastName ||
        email != other.email ||
        phone != other.phone;
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toUpdatedJson(UserModel original) {
    Map<String, dynamic> updatedData = {};

    if (firstName != original.firstName) updatedData['first_name'] = firstName;
    if (lastName != original.lastName) updatedData['last_name'] = lastName;
    if (email != original.email) updatedData['email'] = email;

    return updatedData;
  }
}
