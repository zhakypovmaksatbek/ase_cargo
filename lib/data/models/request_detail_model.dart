import 'package:ase/data/models/request_model.dart';

class RequestDetailModel {
  int? id;
  Address? address;
  String? status;
  String? shipmentOptionName;
  String? shipmentOptionPrice;
  int? totalWeight;
  String? price;
  bool? userCanPay;
  List<AdditionServices>? additionServices;
  String? totalServicesPrice;
  Sender? sender;
  Sender? recipient;
  String? packagesType;

  List<DetailPackages>? packages;

  RequestDetailModel(
      {this.id,
      this.address,
      this.status,
      this.shipmentOptionName,
      this.shipmentOptionPrice,
      this.totalWeight,
      this.price,
      this.userCanPay,
      this.additionServices,
      this.totalServicesPrice,
      this.sender,
      this.recipient,
      this.packages,
      this.packagesType});

  RequestDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    status = json['status'];
    shipmentOptionName = json['shipment_option_name'];
    shipmentOptionPrice = json['shipment_option_price'];
    totalWeight = json['total_weight'];
    price = json['price'];
    packagesType = json['packages_type'];
    userCanPay = json['user_can_pay'];
    if (json['addition_services'] != null) {
      additionServices = <AdditionServices>[];
      json['addition_services'].forEach((v) {
        additionServices!.add(AdditionServices.fromJson(v));
      });
    }
    totalServicesPrice = json['total_services_price'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    recipient =
        json['recipient'] != null ? Sender.fromJson(json['recipient']) : null;
    if (json['packages'] != null) {
      packages = <DetailPackages>[];
      json['packages'].forEach((v) {
        packages!.add(DetailPackages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['status'] = status;
    data['shipment_option_name'] = shipmentOptionName;
    data['shipment_option_price'] = shipmentOptionPrice;
    data['total_weight'] = totalWeight;
    data['price'] = price;
    data['user_can_pay'] = userCanPay;
    if (additionServices != null) {
      data['addition_services'] =
          additionServices!.map((v) => v.toJson()).toList();
    }
    data['total_services_price'] = totalServicesPrice;
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (recipient != null) {
      data['recipient'] = recipient!.toJson();
    }
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdditionServices {
  int? pk;
  String? name;
  String? price;

  AdditionServices({this.pk, this.name, this.price});

  AdditionServices.fromJson(Map<String, dynamic> json) {
    pk = json['pk'];
    name = json['name'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pk'] = pk;
    data['name'] = name;
    data['price'] = price;
    return data;
  }
}

class Sender {
  String? name;
  String? city;

  Sender({this.name, this.city});

  Sender.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['city'] = city;
    return data;
  }
}

class DetailPackages {
  int? id;
  String? weight;
  String? name;
  String? description;
  String? price;
  String? width;
  String? height;
  String? length;

  DetailPackages(
      {this.id,
      this.weight,
      this.name,
      this.description,
      this.price,
      this.width,
      this.height,
      this.length});

  DetailPackages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    data['id'] = id;
    data['weight'] = weight;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['width'] = width;
    data['height'] = height;
    data['length'] = length;
    return data;
  }
}
