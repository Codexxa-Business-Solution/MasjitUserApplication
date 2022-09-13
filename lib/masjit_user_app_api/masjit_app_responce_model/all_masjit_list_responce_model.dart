// To parse this JSON data, do
//
//     final allMasjitJoinListResponceModel = allMasjitJoinListResponceModelFromJson(jsonString);

import 'dart:convert';

AllMasjitListResponceModel allMasjitListResponceModelFromJson(String str) => AllMasjitListResponceModel.fromJson(json.decode(str));

String allMasjitListResponceModelToJson(AllMasjitListResponceModel data) => json.encode(data.toJson());

class AllMasjitListResponceModel {
  AllMasjitListResponceModel({
    this.data,
  });

  List<Datum>? data;

  factory AllMasjitListResponceModel.fromJson(Map<String, dynamic> json) => AllMasjitListResponceModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.images,
    this.weeklyNamaz,
    this.place,
  });

  int? id;
  List<String>? images;
  List<WeeklyNamaz>? weeklyNamaz;
  List<Place>? place;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    images: json["images"] == null ? null : List<String>.from(json["images"].map((x) => x)),
    weeklyNamaz: json["weekly_namaz"] == null ? null : List<WeeklyNamaz>.from(json["weekly_namaz"].map((x) => WeeklyNamaz.fromJson(x))),
    place: List<Place>.from(json["place"].map((x) => Place.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "images": images == null ? null : List<dynamic>.from(images!.map((x) => x)),
    "weekly_namaz": weeklyNamaz == null ? null : List<dynamic>.from(weeklyNamaz!.map((x) => x.toJson())),
    "place": List<dynamic>.from(place!.map((x) => x.toJson())),
  };
}

class Place {
  Place({
    this.lat,
    this.long,
    this.masjidName,
    this.street,
    this.subLocality,
    this.locality,
    this.postalCode,
    this.administrativeArea,
    this.country,
  });

  String? lat;
  String? long;
  String? masjidName;
  String? street;
  String? subLocality;
  String? locality;
  String? postalCode;
  String? administrativeArea;
  String? country;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    lat: json["lat"],
    long: json["long"],
    masjidName: json["masjid_name"],
    street: json["street"] == null ? null : json["street"],
    subLocality: json["sub_locality"] == null ? null : json["sub_locality"],
    locality: json["locality"],
    postalCode: json["postal_code"] == null ? null : json["postal_code"],
    administrativeArea: json["administrative_area"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "long": long,
    "masjid_name": masjidName,
    "street": street == null ? null : street,
    "sub_locality": subLocality == null ? null : subLocality,
    "locality": locality,
    "postal_code": postalCode == null ? null : postalCode,
    "administrative_area": administrativeArea,
    "country": country,
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
