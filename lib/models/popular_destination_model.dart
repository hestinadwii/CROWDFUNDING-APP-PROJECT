import 'dart:convert';

// List<PopularDestinationModel> modelUserFromJson(String str) =>
//     List<PopularDestinationModel>.from(
//         json.decode(str).map((x) => PopularDestinationModel.fromJson(x)));
// String modelUserToJson(List<PopularDestinationModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularDestinationModel {
  String? name;
  String? country;
  String? image;

  PopularDestinationModel({this.name, this.country, this.image});

  factory PopularDestinationModel.fromJson(Map<String, dynamic> json) =>
      PopularDestinationModel(
        name: json["crop_name"],
        country: json["type"],
        image: json["picture"],
      );
  Map<String, dynamic> toJson() => {
        "crop_name": name,
        "type": country,
        "picture": image,
      };
}

// List<PopularDestinationModel> populars = popularsData
//     .map((item) =>
//         PopularDestinationModel(item['name'], item['country'], item['image']))
//     .toList();

var popularsData = [
  {
    "name": "Tomat",
    "country": "20 Jan 2022",
    "image": "assets/images/tomat.jpg"
  },
  {
    "name": "Strawberry",
    "country": "01 Jan 2022",
    "image": "assets/images/strawberry.jpg"
  },
  {
    "name": "Lobak",
    "country": "02 Febr 2022",
    "image": "assets/images/lobak.jpg"
  },
  {
    "name": "Anggur",
    "country": "14 Feb 2022",
    "image": "assets/images/anggur.jpg"
  },
];
