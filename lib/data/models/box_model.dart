import 'package:ase/data/models/pagination_model.dart';
import 'package:ase/data/models/request_detail_model.dart';

class BoxPaginationModel extends PaginationModel<BoxModel> {
  BoxPaginationModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (item) => BoxModel.fromJson(item));
}

class BoxModel {
  Sender? sender;
  Sender? recipient;
  String? code;
  String? action;
  String? address;
  String? zipcode;
  String? price;
  String? createdAt;
  String? reason;

  BoxModel(
      {this.sender,
      this.recipient,
      this.code,
      this.action,
      this.address,
      this.zipcode,
      this.createdAt,
      this.reason,
      this.price});

  BoxModel.fromJson(Map<String, dynamic> json) {
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    recipient =
        json['recipient'] != null ? Sender.fromJson(json['recipient']) : null;
    code = json['code'];
    action = json['action'];
    address = json['address'];
    zipcode = json['zipcode'];
    createdAt = json['created_at'];
    reason = json['reason'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (sender != null) {
      data['sender'] = sender!.toJson();
    }
    if (recipient != null) {
      data['recipient'] = recipient!.toJson();
    }
    data['code'] = code;
    data['action'] = action;
    data['address'] = address;
    data['zipcode'] = zipcode;
    data['created_at'] = createdAt;
    data['reason'] = reason;
    return data;
  }
}
