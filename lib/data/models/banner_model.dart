class BannerModel {
  int? id;
  String? image;
  String? href;

  BannerModel({this.id, this.image, this.href});

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['href'] = href;
    return data;
  }
}
