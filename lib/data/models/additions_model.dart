// ignore_for_file: public_member_api_docs, sort_constructors_first
class AdditionsModel {
  int? shipmentOption;
  String? comment;
  bool? personalPayment;

  AdditionsModel({this.shipmentOption, this.comment, this.personalPayment});

  AdditionsModel.fromJson(Map<String, dynamic> json) {
    shipmentOption = json['shipment_option'];
    comment = json['comment'];
    personalPayment = json['personal_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shipment_option'] = shipmentOption;
    data['comment'] = comment;
    data['personal_payment'] = personalPayment;
    data['addition_services'] = [];

    return data;
  }

  AdditionsModel copyWith({
    int? shipmentOption,
    String? comment,
    bool? personalPayment,
  }) {
    return AdditionsModel(
      shipmentOption: shipmentOption ?? this.shipmentOption,
      comment: comment ?? this.comment,
      personalPayment: personalPayment ?? this.personalPayment,
    );
  }
}

class AdditionsErrorModel {
  List<String>? shipmentOption;

  AdditionsErrorModel({this.shipmentOption});

  AdditionsErrorModel.fromJson(Map<String, dynamic> json) {
    shipmentOption = json['shipment_option']?.cast<String>();
  }
}
