import 'package:ase/data/models/order_model.dart';
import 'package:ase/data/models/request_detail_model.dart';
import 'package:ase/data/models/request_model.dart';

class OrderDetailModel {
  String? code;
  Address? address;
  String? orderStatus;
  String? shipmentOptionName;
  String? shipmentOptionPrice;
  int? totalWeight;
  String? packagesType;
  List<Packages>? packages;
  Sender? sender;
  Sender? recipient;
  List<AdditionServices>? additionServices;
  String? totalServicesPrice;
  String? price;
  String? paidBy;
  Deadlines? deadlines;
  bool? deliveryApproved;
  List<StatusRoad>? statusRoad;

  OrderDetailModel(
      {this.code,
      this.address,
      this.orderStatus,
      this.shipmentOptionName,
      this.shipmentOptionPrice,
      this.totalWeight,
      this.packagesType,
      this.packages,
      this.sender,
      this.recipient,
      this.additionServices,
      this.totalServicesPrice,
      this.price,
      this.paidBy,
      this.deadlines,
      this.deliveryApproved,
      this.statusRoad});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    address =
        json['address'] != null ? Address.fromJson(json['address']) : null;
    orderStatus = json['order_status'];
    shipmentOptionName = json['shipment_option_name'];
    shipmentOptionPrice = json['shipment_option_price'];
    totalWeight = json['total_weight'];
    packagesType = json['packages_type'];
    if (json['packages'] != null) {
      packages = <Packages>[];
      json['packages'].forEach((v) {
        packages!.add(Packages.fromJson(v));
      });
    }
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    recipient =
        json['recipient'] != null ? Sender.fromJson(json['recipient']) : null;
    if (json['addition_services'] != null) {
      additionServices = <AdditionServices>[];
      json['addition_services'].forEach((v) {
        additionServices!.add(AdditionServices.fromJson(v));
      });
    }
    totalServicesPrice = json['total_services_price'];
    price = json['price'];
    paidBy = json['paid_by'];
    deadlines = json['deadlines'] != null
        ? Deadlines.fromJson(json['deadlines'])
        : null;
    deliveryApproved = json['delivery_approved'];
    if (json['status_road'] != null) {
      statusRoad = <StatusRoad>[];
      json['status_road'].forEach((v) {
        statusRoad!.add(StatusRoad.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    data['order_status'] = orderStatus;
    data['shipment_option_name'] = shipmentOptionName;
    data['shipment_option_price'] = shipmentOptionPrice;
    data['total_weight'] = totalWeight;
    data['packages_type'] = packagesType;
    if (packages != null) {
      data['packages'] = packages!.map((v) => v.toJson()).toList();
    }
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (recipient != null) {
      data['recipient'] = recipient!.toJson();
    }
    if (additionServices != null) {
      data['addition_services'] =
          additionServices!.map((v) => v.toJson()).toList();
    }
    data['total_services_price'] = totalServicesPrice;
    data['price'] = price;
    data['paid_by'] = paidBy;
    if (deadlines != null) {
      data['deadlines'] = deadlines!.toJson();
    }
    data['delivery_approved'] = deliveryApproved;
    if (statusRoad != null) {
      data['status_road'] = statusRoad!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packages {
  int? id;
  String? weight;
  String? name;
  String? description;
  String? price;
  String? width;
  String? height;
  String? length;

  Packages(
      {this.id,
      this.weight,
      this.name,
      this.description,
      this.price,
      this.width,
      this.height,
      this.length});

  Packages.fromJson(Map<String, dynamic> json) {
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

class StatusRoad {
  String? status;
  String? state;
  String? time;

  StatusRoad({this.status, this.state, this.time});

  StatusRoad.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    state = json['state'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['state'] = state;
    data['time'] = time;
    return data;
  }
}
