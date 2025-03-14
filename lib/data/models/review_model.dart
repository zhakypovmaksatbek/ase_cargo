import 'package:ase/data/models/pagination_model.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ReviewPaginationModel extends PaginationModel<ReviewModel> {
  ReviewPaginationModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (item) => ReviewModel.fromJson(item));
}

final class ReviewModel {
  Author? author;
  String? code;
  int? rating;
  String? comment;
  String? image;
  String? createdAt;
  XFile? imageFile;

  ReviewModel(
      {this.author,
      this.code,
      this.rating,
      this.comment,
      this.image,
      this.createdAt,
      this.imageFile});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    code = json['code'];
    rating = json['rating'];
    comment = json['comment'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['rating'] = rating;
    data['comment'] = comment;
    data['image'] = image;
    return data;
  }

  Future<FormData> toFormData() async {
    Map<String, dynamic> data = {};

    if (imageFile != null) {
      data['image'] = [
        await MultipartFile.fromFile(imageFile!.path, filename: imageFile!.name)
      ];
    }
    if (comment != null) data['comment'] = comment;
    if (rating != null) data['rating'] = rating;

    return FormData.fromMap(data);
  }
}

class Author {
  String? name;
  String? avatar;

  Author({this.name, this.avatar});

  Author.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['avatar'] = avatar;
    return data;
  }
}
