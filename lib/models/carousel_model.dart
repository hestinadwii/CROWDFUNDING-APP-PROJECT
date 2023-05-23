import 'dart:convert';

// List<CarouselModel> modelUserFromJson(String str) =>
//     List<CarouselModel>.from(
//         json.decode(str).map((x) => CarouselModel.fromJson(x)));
// String modelUserToJson(List<CarouselModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarouselModel {
  String? image;
  String? label;

  CarouselModel({this.image, this.label});

  factory CarouselModel.fromJson(Map<String, dynamic> json) => CarouselModel(
        label: json["title"],
        image: json["picture"],
      );
  Map<String, dynamic> toJson() => {
        "title": label,
        "picture": image,
      };
}

// List<CarouselModel> carousels = carouselsData
//     .map((item) => CarouselModel(item['image'], item['label']))
//     .toList();

var carouselsData = [
  {"image": "assets/images/anggur.jpg", "label": "Hanya di bitanic, semua ada"},
  {"image": "assets/images/lobak.jpg", "label": "Hanya di bitanic, semua ada"},
  {"image": "assets/images/tomat.jpg", "label": "Hanya di bitanic, semua ada"},
  {
    "image": "assets/images/strawberry.jpg",
    "label": "Hanya di bitanic, semua ada"
  },
];
