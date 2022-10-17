// To parse this JSON data, do
//
//     final bannerImage = bannerImageFromJson(jsonString);

import 'dart:convert';

BannerImage bannerImageFromJson(String str) => BannerImage.fromJson(json.decode(str));

String bannerImageToJson(BannerImage data) => json.encode(data.toJson());

class BannerImage {
  BannerImage({
    this.data,
  });

  List<Datum>? data;

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.image,
  });

  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "image": image,
  };
}
