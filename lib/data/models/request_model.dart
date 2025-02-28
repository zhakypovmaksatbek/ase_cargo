import 'package:ase/data/models/pagination_model.dart';
import 'package:ase/data/models/request_detail_model.dart';

class RequestPaginationModel extends PaginationModel<RequestModel> {
  RequestPaginationModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (item) => RequestModel.fromJson(item));
}

class RequestModel {
  int? id;
  Address? address;
  String? status;
  String? deliveryTypeName;
  int? totalWeight;
  String? price;
  bool? userCanPay;
  List<AdditionServices>? additionServices;
  String? totalServicesPrice;

  RequestModel(
      {this.id,
      this.address,
      this.status,
      this.deliveryTypeName,
      this.totalWeight,
      this.price,
      this.userCanPay,
      this.additionServices,
      this.totalServicesPrice});

  RequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    status = json['status'];
    deliveryTypeName = json['shipment_option_name'];
    totalWeight = json['total_weight'];
    price = json['price'];
    userCanPay = json['user_can_pay'];
    if (json['addition_services'] != null) {
      additionServices = <AdditionServices>[];
      json['addition_services'].forEach((v) {
        additionServices!.add(AdditionServices.fromJson(v));
      });
    }
    totalServicesPrice = json['total_services_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['status'] = status;
    data['delivery_type_name'] = deliveryTypeName;
    data['total_weight'] = totalWeight;
    data['price'] = price;
    data['user_can_pay'] = userCanPay;
    if (additionServices != null) {
      data['addition_services'] =
          additionServices!.map((v) => v.toJson()).toList();
    }
    data['total_services_price'] = totalServicesPrice;
    return data;
  }
}

class Address {
  String? country;
  String? city;
  String? region;
  String? zipcode;
  String? addressLine;

  Address(
      {this.country, this.city, this.region, this.zipcode, this.addressLine});

  Address.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    city = json['city'];
    region = json['region'];
    zipcode = json['zipcode'];
    addressLine = json['address_line'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['country'] = country;
    data['city'] = city;
    data['region'] = region;
    data['zipcode'] = zipcode;
    data['address_line'] = addressLine;
    return data;
  }
}
