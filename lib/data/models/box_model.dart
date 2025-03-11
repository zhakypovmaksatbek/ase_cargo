import 'package:ase/data/models/pagination_model.dart';
import 'package:ase/data/models/request_detail_model.dart';

class BoxPaginationModel extends PaginationModel<BoxModel> {
  BoxPaginationModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (item) => BoxModel.fromJson(item));
}

class BoxModel {
  String? code;
  String? address;
  String? zipcode;
  String? addedAt;
  Sender? sender;
  Sender? recipient;

  BoxModel(
      {this.code,
      this.address,
      this.zipcode,
      this.addedAt,
      this.sender,
      this.recipient});

  BoxModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    address = json['address'];
    zipcode = json['zipcode'];
    addedAt = json['added_at'];
    sender = json['sender'] != null ? Sender.fromJson(json['sender']) : null;
    recipient =
        json['recipient'] != null ? Sender.fromJson(json['recipient']) : null;
  }
}
