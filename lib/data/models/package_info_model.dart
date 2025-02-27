// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class PackageInfoModel {
  String? packagesType;
  List<Packages>? packages;

  PackageInfoModel({this.packagesType, this.packages});

  PackageInfoModel.fromJson(Map<String, dynamic> json) {
    packagesType = json['packages_type'];
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packages_type'] = packagesType;
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> documentToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['packages_type'] = packagesType;
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.documentToJson()).toList();
    }
    return data;
  }
}

class Packages {
  String? id;
  double? weight;
  String? name;
  String? description;
  String? price;
  double? width;
  double? height;
  double? length;

  Packages({
    String? id,
    this.name = '',
    this.description = '',
    this.weight = 0,
    this.price = '',
    this.width = 0,
    this.height = 0,
    this.length = 0,
  }) : id = id ?? Uuid().v4();

  Packages.fromJson(Map<String, dynamic> json) {
    weight = json['weight'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    width = json['width'];
    height = json['height'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weight'] = weight;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['width'] = width;
    data['height'] = height;
    data['length'] = length;
    return data;
  }

  Map<String, dynamic> documentToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weight'] = weight;

    return data;
  }

  @override
  String toString() {
    return 'Packages{weight: $weight, name: $name, description: $description, price: $price, width: $width, height: $height}';
  }

  Packages copyWith({
    double? weight,
    String? name,
    String? description,
    String? price,
    double? width,
    double? height,
    double? length,
  }) {
    return Packages(
      weight: weight ?? this.weight,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      width: width ?? this.width,
      height: height ?? this.height,
      length: length ?? this.length,
    );
  }
}

class PackageErrorInfoModel {
  List<String>? packagesType;
  Map<String, PackagesError>? packages;
  PackageErrorInfoModel({this.packagesType, this.packages});

  PackageErrorInfoModel.fromJson(Map<String, dynamic> json) {
    packagesType = List<String>.from(json['packages_type'] ?? []);

    if (json['packages'] != null) {
      packages = {};
      json['packages'].forEach((key, value) {
        packages![key] = PackagesError.fromJson(value);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['packages_type'] = packagesType;

    if (packages != null) {
      data['packages'] = packages!.map((key, value) {
        return MapEntry(key, value.toJson());
      });
    }
    return data;
  }
}

class PackagesError {
  List<String>? weight;
  List<String>? width;
  List<String>? height;
  List<String>? length;

  PackagesError({this.weight, this.width, this.height, this.length});

  PackagesError.fromJson(Map<String, dynamic> json) {
    weight = List<String>.from(json['weight'] ?? []);
    width = List<String>.from(json['width'] ?? []);
    height = List<String>.from(json['height'] ?? []);
    length = List<String>.from(json['length'] ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['weight'] = weight;
    data['width'] = width;
    data['height'] = height;
    return data;
  }
}
