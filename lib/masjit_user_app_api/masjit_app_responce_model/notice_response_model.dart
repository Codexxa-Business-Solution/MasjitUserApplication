// To parse this JSON data, do
//
//     final allMasjitDetailsResponceModel = allMasjitDetailsResponceModelFromJson(jsonString);

import 'dart:convert';

AllMasjitDetailsResponceModel allMasjitDetailsResponceModelFromJson(String str) => AllMasjitDetailsResponceModel.fromJson(json.decode(str));

String allMasjitDetailsResponceModelToJson(AllMasjitDetailsResponceModel data) => json.encode(data.toJson());

class AllMasjitDetailsResponceModel {
  AllMasjitDetailsResponceModel({
    this.id,
    this.weeklyNamaz,
    this.jumma,
    this.trustee,
    this.notice,
    this.eid,
    this.images,
    this.sahr,
    this.iftar,
    this.place,
  });

  int? id;
  List<WeeklyNamaz>? weeklyNamaz;
  Jumma? jumma;
  List<Trustee>? trustee;
  List<Notice>? notice;
  List<Eid>? eid;
  List<String>? images;
  dynamic sahr;
  dynamic iftar;
  Place? place;

  factory AllMasjitDetailsResponceModel.fromJson(Map<String, dynamic> json) => AllMasjitDetailsResponceModel(
    id: json["id"],
    weeklyNamaz: List<WeeklyNamaz>.from(json["weekly_namaz"].map((x) => WeeklyNamaz.fromJson(x))),
    jumma: Jumma.fromJson(json["jumma"]),
    trustee: List<Trustee>.from(json["trustee"].map((x) => Trustee.fromJson(x))),
    notice: List<Notice>.from(json["notice"].map((x) => Notice.fromJson(x))),
    eid: List<Eid>.from(json["eid"].map((x) => Eid.fromJson(x))),
    images: List<String>.from(json["images"].map((x) => x)),
    sahr: json["sahr"],
    iftar: json["iftar"],
    place: Place.fromJson(json["place"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "weekly_namaz": List<dynamic>.from(weeklyNamaz!.map((x) => x.toJson())),
    "jumma": jumma?.toJson(),
    "trustee": List<dynamic>.from(trustee!.map((x) => x.toJson())),
    "notice": List<dynamic>.from(notice!.map((x) => x.toJson())),
    "eid": List<dynamic>.from(eid!.map((x) => x.toJson())),
    "images": List<dynamic>.from(images!.map((x) => x)),
    "sahr": sahr,
    "iftar": iftar,
    "place": place?.toJson(),
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

class Notice {
  Notice({
    this.id,
    this.masjidId,
    this.notice,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? masjidId;
  String? notice;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
    id: json["id"],
    masjidId: json["masjid_id"],
    notice: json["notice"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "masjid_id": masjidId,
    "notice": notice,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class Place {
  Place({
    this.masjidName,
    this.street,
    this.subLocality,
    this.locality,
    this.postalCode,
    this.administrativeArea,
    this.country,
    this.lat,
    this.long,
  });

  String? masjidName;
  String? street;
  String? subLocality;
  String? locality;
  String? postalCode;
  String? administrativeArea;
  String? country;
  String? lat;
  String? long;

  factory Place.fromJson(Map<String, dynamic> json) => Place(
    masjidName: json["masjid_name"],
    street: json["street"],
    subLocality: json["sub_locality"],
    locality: json["locality"],
    postalCode: json["postal_code"],
    administrativeArea: json["administrative_area"],
    country: json["country"],
    lat: json["lat"],
    long: json["long"],
  );

  Map<String, dynamic> toJson() => {
    "masjid_name": masjidName,
    "street": street,
    "sub_locality": subLocality,
    "locality": locality,
    "postal_code": postalCode,
    "administrative_area": administrativeArea,
    "country": country,
    "lat": lat,
    "long": long,
  };
}

class Trustee {
  Trustee({
    this.name,
    this.contact,
    this.designation,
  });

  String? name;
  String? contact;
  String? designation;

  factory Trustee.fromJson(Map<String, dynamic> json) => Trustee(
    name: json["name"],
    contact: json["contact"],
    designation: json["designation"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "contact": contact,
    "designation": designation,
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
