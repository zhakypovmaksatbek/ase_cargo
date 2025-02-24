import 'package:ase/data/models/pagination_model.dart';

class NewsPaginationModel extends PaginationModel<NewsModel> {
  NewsPaginationModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (item) => NewsModel.fromJson(item));
}

class NewsModel {
  String? slug;
  String? title;
  String? image;
  String? createdAt;

  NewsModel({this.slug, this.title, this.image, this.createdAt});

  NewsModel.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    title = json['title'];
    image = json['image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['title'] = title;
    data['image'] = image;
    data['created_at'] = createdAt;
    return data;
  }
}
