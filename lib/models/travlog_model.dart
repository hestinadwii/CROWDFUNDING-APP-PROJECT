import 'dart:convert';

// List<TravlogModel> modelUserFromJson(String str) => List<TravlogModel>.from(
//     json.decode(str).map((x) => TravlogModel.fromJson(x)));
// String modelUserToJson(List<TravlogModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TravlogModel {
  String? name;
  String? content;
  String? place;
  String? image;

  TravlogModel({this.name, this.content, this.place, this.image});

  factory TravlogModel.fromJson(Map<String, dynamic> json) => TravlogModel(
        name: json["title"],
        content: json["description"],
        place: json["type"],
        image: json["picture"],
      );
  Map<String, dynamic> toJson() => {
        "title": name,
        "description": content,
        "type": place,
        "picture": image,
      };
}

// List<TravlogModel> travlogs = travlogsData
//     .map((item) => TravlogModel(
//         item['name'], item['content'], item['place'], item['image']))
//     .toList();

var travlogsData = [
  {
    "name": "\"Smart Tips for Tomato Cultivation!\"",
    "content":
        "Hallo, Merawat tanaman tomat sangat mudah sekali, dengan adanya aplikasi bitanic, semua menjadi mudah ...",
    "place": "Bitanic Info",
    "image": "assets/images/tomat.jpg"
  },
  {
    "name": "\"Lobak!\"",
    "content":
        "Hallo, Merawat tanaman Lobak sangat mudah sekali, dengan adanya aplikasi bitanic, semua menjadi mudah ...",
    "place": "Bitanic Info",
    "image": "assets/images/lobak.jpg"
  },
  {
    "name": "\"Strawberry!\"",
    "content":
        "Hallo, Merawat Strawberry sangat mudah sekali, dengan adanya aplikasi bitanic, semua menjadi mudah ...",
    "place": "Bitanic Info",
    "image": "assets/images/strawberry.jpg"
  },
  {
    "name": "\"Anggur!\"",
    "content":
        "Hallo, Merawat tanaman Anggur sangat mudah sekali, dengan adanya aplikasi bitanic, semua menjadi mudah ...",
    "place": "Bitanic Info",
    "image": "assets/images/anggur.jpg"
  }
];
