class FaceBookModel {
  String? name;
  String? email;
  Picture? picture;
  String? id;

  FaceBookModel({this.name, this.email, this.picture, this.id});

  FaceBookModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    print("object111:${json['picture']}");
    picture = json['picture'] != null
        ? Picture.fromJson(Map<String, dynamic>.from(json['picture']))
        : null;
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    if (picture != null) {
      data['picture'] = picture!.toJson();
    }
    data['id'] = id;
    return data;
  }
}

class Picture {
  Data? data;

  Picture({this.data});

  Picture.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? Data.fromJson(Map<String, dynamic>.from(json['data']))
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? height;
  String? url;
  int? width;

  Data({this.height, this.url, this.width});

  Data.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    url = json['url'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['height'] = height;
    data['url'] = url;
    data['width'] = width;
    return data;
  }
}
