import 'package:ase/data/models/pagination_model.dart';
import 'package:ase/data/models/request_detail_model.dart';
import 'package:ase/data/models/request_model.dart';

class OrderPaginationModel extends PaginationModel<OrderModel> {
  OrderPaginationModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (item) => OrderModel.fromJson(item));
}

class OrderModel {
  String? code;
  Address? address;
  String? orderStatus;
  String? deliveryTypeName;
  int? totalWeight;
  String? price;
  List<AdditionServices>? additionServices;
  String? totalServicesPrice;
  String? paidBy;
  Deadlines? deadlines;
  bool? issueConfirmed;

  OrderModel(
      {this.code,
      this.address,
      this.orderStatus,
      this.deliveryTypeName,
      this.totalWeight,
      this.price,
      this.additionServices,
      this.totalServicesPrice,
      this.paidBy,
      this.deadlines,
      this.issueConfirmed});

  OrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    orderStatus = json['order_status'];
    deliveryTypeName = json['delivery_type_name'];
    totalWeight = json['total_weight'];
    price = json['price'];
    if (json['addition_services'] != null) {
      additionServices = <AdditionServices>[];
      json['addition_services'].forEach((v) {
        additionServices!.add(AdditionServices.fromJson(v));
      });
    }
    totalServicesPrice = json['total_services_price'];
    paidBy = json['paid_by'];
    deadlines = json['deadlines'] != null
        ? Deadlines.fromJson(json['deadlines'])
        : null;
    issueConfirmed = json['issue_confirmed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['order_status'] = orderStatus;
    data['delivery_type_name'] = deliveryTypeName;
    data['total_weight'] = totalWeight;
    data['price'] = price;
    if (additionServices != null) {
      data['addition_services'] =
          additionServices!.map((v) => v.toJson()).toList();
    }
    data['total_services_price'] = totalServicesPrice;
    data['paid_by'] = paidBy;
    if (deadlines != null) {
      data['deadlines'] = deadlines!.toJson();
    }
    data['issue_confirmed'] = issueConfirmed;
    return data;
  }
}

class Deadlines {
  String? departureTime;
  String? arrivalTime;

  Deadlines({this.departureTime, this.arrivalTime});

  Deadlines.fromJson(Map<String, dynamic> json) {
    departureTime = json['departure_time'];
    arrivalTime = json['arrival_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departure_time'] = departureTime;
    data['arrival_time'] = arrivalTime;
    return data;
  }
}
