class HomeModel {
  List<Categories>? categories;
  List<Banners>? banners;
  HomeModel({this.categories, this.banners,});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(Banners.fromJson(v));
      });
    }
   
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    if (banners != null) {
      data['banners'] = banners!.map((v) => v.toJson()).toList();
    }
    
    return data;
  }
}

class Categories {
  String? slug;
  String? title;
  String? image;

  Categories({this.slug, this.title, this.image});

  Categories.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    title = json['title'];
    image = json['image']?.toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slug'] = slug;
    data['title'] = title;
    data['image'] = image;
    return data;
  }
}

class Banners {
  String? title;
  String? type;
  String? imageDesktop;
  String? imageMobile;
  Link? link;
  bool? isActive;
  String? createdAt;

  Banners(
      {this.title,
      this.type,
      this.imageDesktop,
      this.imageMobile,
      this.link,
      this.isActive,
      this.createdAt});

  Banners.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    type = json['type'];
    imageDesktop = json['image_desktop'];
    imageMobile = json['image_mobile'];
    link = json['link'] != null ? Link.fromJson(json['link']) : null;
    isActive = json['is_active'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['type'] = type;
    data['image_desktop'] = imageDesktop;
    data['image_mobile'] = imageMobile;
    if (link != null) {
      data['link'] = link!.toJson();
    }
    data['is_active'] = isActive;
    data['created_at'] = createdAt;
    return data;
  }
}

class Link {
  String? name;
  String? link;

  Link({this.name, this.link});

  Link.fromJson(Map<String, dynamic> json) {
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
