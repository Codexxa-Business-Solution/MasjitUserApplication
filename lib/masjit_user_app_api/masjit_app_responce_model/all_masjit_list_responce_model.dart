// To parse this JSON data, do
//
//     final allMasjitListResponceModel = allMasjitListResponceModelFromJson(jsonString);

import 'dart:convert';

List<AllMasjitListResponceModel> allMasjitListResponceModelFromJson(String str) => List<AllMasjitListResponceModel>.from(json.decode(str).map((x) => AllMasjitListResponceModel.fromJson(x)));

String allMasjitListResponceModelToJson(List<AllMasjitListResponceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllMasjitListResponceModel {
  AllMasjitListResponceModel({
    this.id,
    this.location,
    this.images,
    this.weeklyNamaz,
  });

  int? id;
  Location? location;
  List<String>? images;
  List<WeeklyNamaz>? weeklyNamaz;

  factory AllMasjitListResponceModel.fromJson(Map<String, dynamic> json) => AllMasjitListResponceModel(
    id: json["id"],
    location: Location.fromJson(json["location"]),
    images: List<String>.from(json["images"].map((x) => x)),
    weeklyNamaz: json["weekly_namaz"] == null ? null : List<WeeklyNamaz>.from(json["weekly_namaz"].map((x) => WeeklyNamaz.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "location": location?.toJson(),
    "images": List<dynamic>.from(images!.map((x) => x)),
    "weekly_namaz": weeklyNamaz == null ? null : List<dynamic>.from(weeklyNamaz!.map((x) => x.toJson())),
  };
}

class Location {
  Location({
    this.lat,
    this.long,
    this.place,
  });

  String? lat;
  String? long;
  String? place;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"],
    long: json["long"],
    place: json["place"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "long": long,
    "place": place,
  };
}

class WeeklyNamaz {
  WeeklyNamaz({
    this.day,
    this.azan,
    this.jammat,
  });

  String? day;
  String? azan;
  String? jammat;

  factory WeeklyNamaz.fromJson(Map<String, dynamic> json) => WeeklyNamaz(
    day: json["day"],
    azan: json["azan"],
    jammat: json["jammat"],
  );

  Map<String, dynamic> toJson() => {
    "day": day,
    "azan": azan,
    "jammat": jammat,
  };
}
