// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class SenderModel {
  bool? saveForm;
  String? tin;
  String? issueDate;
  String? issuingAuthority;
  XFile? frontPartImg;
  XFile? backPartImg;
  String? entityType;
  String? name;
  String? phone;
  String? email;
  String? countryCode;
  String? city;
  String? region;
  String? zipcode;
  String? addressLine;
  bool? savedByUser;

  SenderModel(
      {this.saveForm = false,
      this.tin,
      this.issueDate,
      this.issuingAuthority,
      this.frontPartImg,
      this.backPartImg,
      this.entityType,
      this.name,
      this.phone,
      this.email,
      this.countryCode,
      this.city,
      this.region,
      this.zipcode,
      this.addressLine,
      this.savedByUser = false});

  SenderModel.fromJson(Map<String, dynamic> json) {
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
    countryCode = json['country'];
    city = json['city'];
    region = json['region'];
    zipcode = json['zipcode'];
    addressLine = json['address_line'];
    savedByUser = json['saved_by_user'];
  }

  static Future<FormData> physicalToFormData(SenderModel sender) async {
    return FormData.fromMap({
      'save_form': sender.saveForm,
      'tin': sender.tin,
      'issue_date': sender.issueDate,
      'issuing_authority': sender.issuingAuthority,
      'entity_type': sender.entityType,
      'name': sender.name,
      'phone': sender.phone,
      'email': sender.email,
      'city': sender.city,
      'region': sender.region,
      'zipcode': sender.zipcode,
      'address_line': sender.addressLine,
      'saved_by_user': sender.savedByUser,
      'country_code': sender.countryCode,
      'front_part_img': sender.frontPartImg != null
          ? await MultipartFile.fromFile(sender.frontPartImg!.path,
              filename: sender.frontPartImg!.name)
          : null,
      'back_part_img': sender.backPartImg != null
          ? await MultipartFile.fromFile(sender.backPartImg!.path,
              filename: sender.backPartImg!.name)
          : null,
    });
  }

  Map<String, dynamic> legalToJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['save_form'] = saveForm;
    data['tin'] = tin;
    data['entity_type'] = entityType;
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['country'] = countryCode;
    data['city'] = city;
    data['region'] = region;
    data['zipcode'] = zipcode;
    data['address_line'] = addressLine;
    data['saved_by_user'] = savedByUser;
    data['country_code'] = countryCode;
    return data;
  }

  SenderModel copyWith({
    bool? saveForm,
    String? tin,
    String? issueDate,
    String? issuingAuthority,
    XFile? frontPartImg,
    XFile? backPartImg,
    String? entityType,
    String? name,
    String? phone,
    String? email,
    String? country,
    String? city,
    String? region,
    String? zipcode,
    String? addressLine,
    bool? savedByUser,
  }) {
    return SenderModel(
      saveForm: saveForm ?? this.saveForm,
      tin: tin ?? this.tin,
      issueDate: issueDate ?? this.issueDate,
      issuingAuthority: issuingAuthority ?? this.issuingAuthority,
      frontPartImg: frontPartImg ?? this.frontPartImg,
      backPartImg: backPartImg ?? this.backPartImg,
      entityType: entityType ?? this.entityType,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      countryCode: country ?? countryCode,
      city: city ?? this.city,
      region: region ?? this.region,
      zipcode: zipcode ?? this.zipcode,
      addressLine: addressLine ?? this.addressLine,
      savedByUser: savedByUser ?? this.savedByUser,
    );
  }
}

class SenderErrorModel {
  List<String>? tin;
  List<String>? issueDate;
  List<String>? issuingAuthority;
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

  SenderErrorModel(
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
      this.addressLine,
      this.issuingAuthority});

  SenderErrorModel.fromJson(Map<String, dynamic> json) {
    tin = json['tin']?.cast<String>();
    issueDate = json['issue_date']?.cast<String>();
    frontPartImg = json['front_part_img']?.cast<String>();
    backPartImg = json['back_part_img']?.cast<String>();
    entityType = json['entity_type']?.cast<String>();
    name = json['name']?.cast<String>();
    phone = json['phone']?.cast<String>();
    email = json['email']?.cast<String>();
    country = json['country_code']?.cast<String>();
    city = json['city']?.cast<String>();
    region = json['region']?.cast<String>();
    zipcode = json['zipcode']?.cast<String>();
    addressLine = json['address_line']?.cast<String>();
    issuingAuthority = json['issuing_authority']?.cast<String>();
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
    data['country_code'] = country;
    data['city'] = city;
    data['region'] = region;
    data['zipcode'] = zipcode;
    data['address_line'] = addressLine;
    data['issuing_authority'] = issuingAuthority;
    return data;
  }
}
