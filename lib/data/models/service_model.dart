import 'package:ase/data/models/pagination_model.dart';

class ServicePaginationModel extends PaginationModel<ServiceModel> {
  ServicePaginationModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (item) => ServiceModel.fromJson(item));
}

class ServiceModel {
  String? slug;
  String? title;
  String? subtitle;
  String? image;
  String? createdAt;

  ServiceModel(
      {this.slug, this.title, this.subtitle, this.image, this.createdAt});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    title = json['title'];
    subtitle = json['subtitle'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['image'] = image;
    data['created_at'] = createdAt;
    return data;
  }
}
