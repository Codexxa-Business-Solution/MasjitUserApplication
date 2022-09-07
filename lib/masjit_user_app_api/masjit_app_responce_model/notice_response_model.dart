import 'dart:convert';

NoticeResponceModel noticeResponceModelFromJson(String str) => NoticeResponceModel.fromJson(json.decode(str));

String allMasjidIstResponseToJson(NoticeResponceModel data) => json.encode(data.toJson());

class NoticeResponceModel {
  NoticeResponceModel({
    this.id,
    this.weeklyNamaz,
    this.jumma,
    this.trustee,
    this.ed,
    this.location,
    this.images,
    this.notices,
    this.sahr,
    this.iftar,
  });

  int? id;
  List<WeeklyNamaz>? weeklyNamaz;
  Jumma? jumma;
  List<Trustee>? trustee;
  List<Ed>? ed;
  Location? location;
  List<String>? images;
  List<String>? notices;
  String? sahr;
  String? iftar;

  factory NoticeResponceModel.fromJson(Map<String, dynamic> json) => NoticeResponceModel(
    id: json["id"],
    weeklyNamaz: List<WeeklyNamaz>.from(json["weekly_namaz"].map((x) => WeeklyNamaz.fromJson(x))),
    jumma: Jumma.fromJson(json["jumma"]),
    trustee: List<Trustee>.from(json["trustee"].map((x) => Trustee.fromJson(x))),
    ed: List<Ed>.from(json["ed"].map((x) => Ed.fromJson(x))),
    location: Location.fromJson(json["location"]),
    images: List<String>.from(json["images"].map((x) => x)),
    notices: List<String>.from(json["notices"].map((x) => x)),
    sahr: json["sahr"],
    iftar: json["iftar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "weekly_namaz": List<dynamic>.from(weeklyNamaz!.map((x) => x.toJson())),
    "jumma": jumma?.toJson(),
    "trustee": List<dynamic>.from(trustee!.map((x) => x.toJson())),
    "ed": List<dynamic>.from(ed!.map((x) => x.toJson())),
    "location": location?.toJson(),
    "images": List<dynamic>.from(images!.map((x) => x)),
    "notices": List<dynamic>.from(notices!.map((x) => x)),
    "sahr": sahr,
    "iftar": iftar,
  };
}

class Ed {
  Ed({
    this.name,
    this.jammat,
  });

  String? name;
  List<Jammat>? jammat;

  factory Ed.fromJson(Map<String, dynamic> json) => Ed(
    name: json["name"],
    jammat: List<Jammat>.from(json["jammat"].map((x) => Jammat.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "jammat": List<dynamic>.from(jammat!.map((x) => x.toJson())),
  };
}

class Jammat {
  Jammat({
    this.name,
    this.time,
  });

  String? name;
  String? time;

  factory Jammat.fromJson(Map<String, dynamic> json) => Jammat(
    name: json["name"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "time": time,
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

class Trustee {
  Trustee({
    this.designation,
    this.name,
    this.contact,
  });

  String? designation;
  String? name;
  String? contact;

  factory Trustee.fromJson(Map<String, dynamic> json) => Trustee(
    designation: json["designation"],
    name: json["name"],
    contact: json["contact"],
  );

  Map<String, dynamic> toJson() => {
    "designation": designation,
    "name": name,
    "contact": contact,
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
