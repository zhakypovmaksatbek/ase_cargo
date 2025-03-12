import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

final class SignatureModel {
  String? recipientName;
  XFile? signatureImage;
  XFile? approveImage;

  SignatureModel({this.recipientName, this.signatureImage, this.approveImage});

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['recipient_name'] = recipientName;
  //   data['signature_image'] = signatureImage;
  //   data['approve_image'] = approveImage;
  //   return data;
  // }

  Future<FormData> toFormData() async {
    Map<String, dynamic> data = {};
    if (recipientName != null) data['recipient_name'] = recipientName;

    if (signatureImage != null) {
      data['signature_image'] = await MultipartFile.fromFile(
          signatureImage!.path,
          filename: signatureImage!.name);
    }

    if (approveImage != null) {
      data['approve_image'] = await MultipartFile.fromFile(approveImage!.path,
          filename: approveImage!.name);
    }

    return FormData.fromMap(data);
  }
}
