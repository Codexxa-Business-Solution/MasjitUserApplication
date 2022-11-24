// To parse this JSON data, do
//
//     final searchMasjidData = searchMasjidDataFromJson(jsonString);

import 'dart:convert';

SearchMasjidData searchMasjidDataFromJson(String str) => SearchMasjidData.fromJson(json.decode(str));

String searchMasjidDataToJson(SearchMasjidData data) => json.encode(data.toJson());

class SearchMasjidData {
  SearchMasjidData({
    this.data,
  });

  List<Datum>? data;

  factory SearchMasjidData.fromJson(Map<String, dynamic> json) => SearchMasjidData(
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
    this.joined,
    this.place,
  });

  String? id;
  List<String>? images;
  List<WeeklyNamaz>? weeklyNamaz;
  bool? joined;
  List<Place>? place;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    images: List<String>.from(json["images"].map((x) => x)),
    weeklyNamaz: List<WeeklyNamaz>.from(json["weekly_namaz"].map((x) => WeeklyNamaz.fromJson(x))),
    joined: json["joined"],
    place: List<Place>.from(json["place"].map((x) => Place.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "weekly_namaz": List<dynamic>.from(weeklyNamaz!.map((x) => x.toJson())),
    "joined": joined,
    "place": List<dynamic>.from(place!.map((x) => x.toJson())),
  };
}

class Place {
  Place({
    this.lat,
    this.long,
    this.distance,
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
  String? distance;
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
    distance: json["distance"],
    masjidName: json["masjid_name"],
    street: json["street"],
    subLocality: json["sub_locality"],
    locality: json["locality"],
    postalCode: json["postal_code"],
    administrativeArea: json["administrative_area"],
    country: json["country"],
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "long": long,
    "distance": distance,
    "masjid_name": masjidName,
    "street": street,
    "sub_locality": subLocality,
    "locality": locality,
    "postal_code": postalCode,
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
