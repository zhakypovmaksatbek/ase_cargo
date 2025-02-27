class FormDetailModel {
  RoleStep? roleStep;
  PackagesStep? packagesStep;
  SenderStep? senderStep;
  SenderStep? recipientStep;
  AdditionsStep? additionsStep;

  FormDetailModel(
      {this.roleStep,
      this.packagesStep,
      this.senderStep,
      this.recipientStep,
      this.additionsStep});

  FormDetailModel.fromJson(Map<String, dynamic> json) {
    roleStep =
        json['role_step'] != null ? RoleStep.fromJson(json['role_step']) : null;
    packagesStep = json['packages_step'] != null
        ? PackagesStep.fromJson(json['packages_step'])
        : null;
    senderStep = json['sender_step'] != null
        ? SenderStep.fromJson(json['sender_step'])
        : null;
    recipientStep = json['recipient_step'] != null
        ? SenderStep.fromJson(json['recipient_step'])
        : null;
    additionsStep = json['additions_step'] != null
        ? AdditionsStep.fromJson(json['additions_step'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (roleStep != null) {
      data['role_step'] = roleStep!.toJson();
    }
    if (packagesStep != null) {
      data['packages_step'] = packagesStep!.toJson();
    }
    if (senderStep != null) {
      data['sender_step'] = senderStep!.toJson();
    }
    if (recipientStep != null) {
      data['recipient_step'] = recipientStep!.toJson();
    }
    if (additionsStep != null) {
      data['additions_step'] = additionsStep!.toJson();
    }
    return data;
  }
}

class RoleStep {
  String? userRole;

  RoleStep({this.userRole});

  RoleStep.fromJson(Map<String, dynamic> json) {
    userRole = json['user_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_role'] = userRole;
    return data;
  }
}

class PackagesStep {
  String? packagesType;
  List<PackagesDetail>? packages;

  PackagesStep({this.packagesType, this.packages});

  PackagesStep.fromJson(Map<String, dynamic> json) {
    packagesType = json['packages_type'];
    if (json['packages'] != null) {
      packages = <PackagesDetail>[];
      json['packages'].forEach((v) {
        packages!.add(PackagesDetail.fromJson(v));
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
}

class PackagesDetail {
  int? id;
  String? weight;
  String? name;
  String? description;
  String? price;
  String? width;
  String? height;
  String? length;

  PackagesDetail(
      {this.id,
      this.weight,
      this.name,
      this.description,
      this.price,
      this.width,
      this.height,
      this.length});

  PackagesDetail.fromJson(Map<String, dynamic> json) {
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

class SenderStep {
  int? id;
  String? tin;
  String? issueDate;
  String? issuingAuthority;
  String? frontPartImg;
  String? backPartImg;
  String? entityType;
  String? name;
  String? phone;
  String? email;
  String? country;
  String? city;
  String? region;
  String? zipcode;
  String? addressLine;
  bool? savedByUser;

  SenderStep(
      {this.id,
      this.tin,
      this.issueDate,
      this.issuingAuthority,
      this.frontPartImg,
      this.backPartImg,
      this.entityType,
      this.name,
      this.phone,
      this.email,
      this.country,
      this.city,
      this.region,
      this.zipcode,
      this.addressLine,
      this.savedByUser});

  SenderStep.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tin = json['tin'];
    issueDate = json['issue_date'];
    issuingAuthority = json['issuing_authority'];
    frontPartImg = json['front_part_img'];
    backPartImg = json['back_part_img'];
    entityType = json['entity_type'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    country = json['country'];
    city = json['city'];
    region = json['region'];
    zipcode = json['zipcode'];
    addressLine = json['address_line'];
    savedByUser = json['saved_by_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tin'] = tin;
    data['issue_date'] = issueDate;
    data['issuing_authority'] = issuingAuthority;
    data['front_part_img'] = frontPartImg;
    data['back_part_img'] = backPartImg;
    data['entity_type'] = entityType;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['country'] = country;
    data['city'] = city;
    data['region'] = region;
    data['zipcode'] = zipcode;
    data['address_line'] = addressLine;
    data['saved_by_user'] = savedByUser;
    return data;
  }
}

class AdditionsStep {
  List<SelectedServices>? selectedServices;
  int? shipmentOption;
  String? shipmentOptionName;
  String? shipmentOptionPrice;
  String? comment;
  bool? personalPayment;

  AdditionsStep(
      {this.selectedServices,
      this.shipmentOption,
      this.shipmentOptionName,
      this.shipmentOptionPrice,
      this.comment,
      this.personalPayment});

  AdditionsStep.fromJson(Map<String, dynamic> json) {
    if (json['selected_services'] != null) {
      selectedServices = <SelectedServices>[];
      json['selected_services'].forEach((v) {
        selectedServices!.add(SelectedServices.fromJson(v));
      });
    }
    shipmentOption = json['shipment_option'];
    shipmentOptionName = json['shipment_option_name'];
    shipmentOptionPrice = json['shipment_option_price'];
    comment = json['comment'];
    personalPayment = json['personal_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (selectedServices != null) {
      data['selected_services'] =
          selectedServices!.map((v) => v.toJson()).toList();
    }
    data['shipment_option'] = shipmentOption;
    data['shipment_option_name'] = shipmentOptionName;
    data['shipment_option_price'] = shipmentOptionPrice;
    data['comment'] = comment;
    data['personal_payment'] = personalPayment;
    return data;
  }
}

class SelectedServices {
  int? pk;
  String? name;
  String? price;

  SelectedServices({this.pk, this.name, this.price});

  SelectedServices.fromJson(Map<String, dynamic> json) {
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
