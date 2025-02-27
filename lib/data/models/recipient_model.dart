class RecipientModel {
  bool? saveForm;
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

  RecipientModel(
      {this.saveForm,
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

  RecipientModel.fromJson(Map<String, dynamic> json) {
    saveForm = json['save_form'];
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
    data['save_form'] = saveForm;
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

class RecipientErrorModel {
  List<String>? tin;
  List<String>? issueDate;
  List<String>? frontPartImg;
  List<String>? backPartImg;
  List<String>? entityType;
  List<String>? name;
  List<String>? phone;
  List<String>? email;
  List<String>? country;
  List<String>? city;
  List<String>? region;
  List<String>? zipcode;
  List<String>? addressLine;

  RecipientErrorModel(
      {this.tin,
      this.issueDate,
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
      this.addressLine});

  RecipientErrorModel.fromJson(Map<String, dynamic> json) {
    tin = json['tin']?.cast<String>();
    issueDate = json['issue_date']?.cast<String>();
    frontPartImg = json['front_part_img']?.cast<String>();
    backPartImg = json['back_part_img']?.cast<String>();
    entityType = json['entity_type']?.cast<String>();
    name = json['name']?.cast<String>();
    phone = json['phone']?.cast<String>();
    email = json['email']?.cast<String>();
    country = json['country']?.cast<String>();
    city = json['city']?.cast<String>();
    region = json['region']?.cast<String>();
    zipcode = json['zipcode']?.cast<String>();
    addressLine = json['address_line']?.cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['tin'] = tin;
    data['issue_date'] = issueDate;
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
    return data;
  }
}
