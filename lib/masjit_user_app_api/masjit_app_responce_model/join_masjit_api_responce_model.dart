// To parse this JSON data, do
//
//     final allMasjitJoinListResponceModel = allMasjitJoinListResponceModelFromJson(jsonString);

import 'dart:convert';

AllMasjitJoinListResponceModel allMasjitJoinListResponceModelFromJson(String str) => AllMasjitJoinListResponceModel.fromJson(json.decode(str));

String allMasjitJoinListResponceModelToJson(AllMasjitJoinListResponceModel data) => json.encode(data.toJson());

class AllMasjitJoinListResponceModel {
  AllMasjitJoinListResponceModel({
    this.data,
  });

  List<Datum>? data;

  factory AllMasjitJoinListResponceModel.fromJson(Map<String, dynamic> json) => AllMasjitJoinListResponceModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.isPrimary,
    this.images,
    this.weeklyNamaz,
    this.jumma,
    this.sahr,
    this.iftar,
    this.eid,
    this.place,
  });

  int? id;
  bool? isPrimary;
  List<String>? images;
  List<WeeklyNamaz>? weeklyNamaz;
  Jumma? jumma;
  String? sahr;
  String? iftar;
  List<Eid>? eid;
  List<Place>? place;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    isPrimary: json["is_primary"],
    images: List<String>.from(json["images"].map((x) => x)),
    weeklyNamaz: List<WeeklyNamaz>.from(json["weekly_namaz"].map((x) => WeeklyNamaz.fromJson(x))),
    jumma: Jumma.fromJson(json["jumma"]),
    sahr: json["sahr"] == null ? null : json["sahr"],
    iftar: json["iftar"] == null ? null : json["iftar"],
    eid: json["eid"] == null ? null : List<Eid>.from(json["eid"].map((x) => Eid.fromJson(x))),
    place: List<Place>.from(json["place"].map((x) => Place.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "is_primary": isPrimary,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "weekly_namaz": List<dynamic>.from(weeklyNamaz!.map((x) => x.toJson())),
    "jumma": jumma?.toJson(),
    "sahr": sahr == null ? null : sahr,
    "iftar": iftar == null ? null : iftar,
    "eid": eid == null ? null : List<dynamic>.from(eid!.map((x) => x.toJson())),
    "place": List<dynamic>.from(place!.map((x) => x.toJson())),
  };
}

class Eid {
  Eid({
    this.name,
    this.azan,
    this.jammat,
  });

  String? name;
  String? azan;
  List<String>? jammat;

  factory Eid.fromJson(Map<String, dynamic> json) => Eid(
    name: json["name"],
    azan: json["azan"],
    jammat: List<String>.from(json["jammat"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "azan": azan,
    "jammat": List<dynamic>.from(jammat!.map((x) => x)),
  };
}

class Jumma {
  Jumma({
    this.azan,
    this.jammat,
  });

  String? azan;
  List<String>? jammat;

  factory Jumma.fromJson(Map<String, dynamic> json) => Jumma(
    azan: json["azan"],
    jammat: List<String>.from(json["jammat"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "azan": azan,
    "jammat": List<dynamic>.from(jammat!.map((x) => x)),
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
