import 'package:ase/data/models/pagination_model.dart';

class StoryPaginationModel extends PaginationModel<StoryModel> {
  StoryPaginationModel.fromJson(Map<String, dynamic> json)
      : super.fromJson(json, (item) => StoryModel.fromJson(item));
}

class StoryModel {
  int? id;
  String? title;
  String? coverImg;
  String? createdAt;
  bool? isRead;

  StoryModel({this.id, this.title, this.coverImg, this.createdAt, this.isRead});

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    coverImg = json['cover_img'];
    createdAt = json['created_at'];
    isRead = json['is_read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['cover_img'] = coverImg;
    data['created_at'] = createdAt;
    data['is_read'] = isRead;
    return data;
  }
}
