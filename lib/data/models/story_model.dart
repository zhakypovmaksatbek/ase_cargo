class StoryModel {
  int? id;
  List<Stories>? stories;
  String? title;
  String? image;
  bool? isActive;
  bool? viewed;

  StoryModel(
      {this.id,
      this.stories,
      this.title,
      this.image,
      this.isActive,
      this.viewed});

  StoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['stories'] != null) {
      stories = <Stories>[];
      json['stories'].forEach((v) {
        stories!.add(Stories.fromJson(v));
      });
    }
    title = json['title'];
    image = json['image'];
    isActive = json['is_active'];
    viewed = json['viewed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (stories != null) {
      data['stories'] = stories!.map((v) => v.toJson()).toList();
    }
    data['title'] = title;
    data['image'] = image;
    data['is_active'] = isActive;
    data['viewed'] = viewed;
    return data;
  }
}

class Stories {
  String? image;
  String? type;
  StoryLink? link;
  String? createdAt;

  Stories({this.image, this.type, this.link, this.createdAt});

  Stories.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    type = json['type'];
    link = json['link'] != null ? StoryLink.fromJson(json['link']) : null;
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['type'] = type;
    if (link != null) {
      data['link'] = link!.toJson();
    }
    data['created_at'] = createdAt;
    return data;
  }
}

class StoryLink {
  String? name;
  String? link;

  StoryLink({this.name, this.link});

  StoryLink.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    link = json['link']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['link'] = link;
    return data;
  }
}
