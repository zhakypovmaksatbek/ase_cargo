class StoryDetailModel {
  int? id;
  String? title;
  String? coverImg;
  List<Items>? items;
  String? createdAt;

  StoryDetailModel(
      {this.id, this.title, this.coverImg, this.items, this.createdAt});

  StoryDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    coverImg = json['cover_img'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['cover_img'] = coverImg;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class Items {
  int? id;
  String? image;
  bool? isActive;
  int? sortOrder;
  int? story;

  Items({this.id, this.image, this.isActive, this.sortOrder, this.story});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isActive = json['is_active'];
    sortOrder = json['sort_order'];
    story = json['story'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['is_active'] = isActive;
    data['sort_order'] = sortOrder;
    data['story'] = story;
    return data;
  }
}
