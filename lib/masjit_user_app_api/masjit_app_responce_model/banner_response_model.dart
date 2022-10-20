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

  List<String>? data;

  factory BannerImage.fromJson(Map<String, dynamic> json) => BannerImage(
    data: List<String>.from(json["data"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x)),
  };
}
