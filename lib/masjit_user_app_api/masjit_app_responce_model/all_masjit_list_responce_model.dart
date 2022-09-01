import 'dart:convert';

/// id : 1
/// location : {"lat":"18.56603826697165","long":"73.77360616239547","place":"The Rustle Nest"}
/// images : ["https://www.google.com/maps/place/The+Rustle+Nest/@18.5659754,73.7735104,3a,75y,90t/data=!3m8!1e2!3m6!1sAF1QipOqVfqrxcD-hopFlCAUchiBf2NnaMcr5YTzK9Cb!2e10!3e12!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipOqVfqrxcD-hopFlCAUchiBf2NnaMcr5YTzK9Cb%3Dw216-h100-k-no!7i4624!8i2136!4m5!3m4!1s0x3bc2bf780bc66241:0x7ba7608fecd32b4f!8m2!3d18.5659643!4d73.773595#","https://www.google.com/maps/place/The+Rustle+Nest/@18.5659754,73.7735104,3a,75y,90t/data=!3m8!1e2!3m6!1sAF1QipOqVfqrxcD-hopFlCAUchiBf2NnaMcr5YTzK9Cb!2e10!3e12!6shttps:%2F%2Flh5.googleusercontent.com%2Fp%2FAF1QipOqVfqrxcD-hopFlCAUchiBf2NnaMcr5YTzK9Cb%3Dw216-h100-k-no!7i4624!8i2136!4m5!3m4!1s0x3bc2bf780bc66241:0x7ba7608fecd32b4f!8m2!3d18.5659643!4d73.773595#"]
/// weekly_namaz : [{"day":"FAJR","azan":"05:00","jammt":"05:00"},{"day":"ZUHAR","azan":"05:00","jammt":"05:00"},{"day":"ASR","azan":"05:00","jammt":"05:00"},{"day":"MAGHRIB","azan":"05:00","jammt":"05:00"},{"day":"ISHA","azan":"05:00","jammt":"05:00"},{"day":"JUMA","azan":"05:00","jammt":"05:00"}]
/*
AllMasjitListResponceModel getAllMasjidFromJson(String str) =>
    AllMasjitListResponceModel.fromJson(json.decode(str));

String getAllMasjidToJson(AllMasjitListResponceModel data) =>
    json.encode(data.toJson());*/

List<AllMasjitListResponceModel> postFromJson(String str) =>
    List<AllMasjitListResponceModel>.from(json.decode(str).map((x) => AllMasjitListResponceModel.fromJson(x)));

class AllMasjitListResponceModel {
  AllMasjitListResponceModel({
    this.id,
    this.location,
    this.images,
    this.weeklyNamaz,
  });

  AllMasjitListResponceModel.fromJson(dynamic json) {
    id = json['id'];
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['weekly_namaz'] != null) {
      weeklyNamaz = [];
      json['weekly_namaz'].forEach((v) {
        weeklyNamaz?.add(WeeklyNamaz.fromJson(v));
      });
    }
  }

  num? id;
  Location? location;
  List<String>? images;
  List<WeeklyNamaz>? weeklyNamaz;

  AllMasjitListResponceModel copyWith({
    num? id,
    Location? location,
    List<String>? images,
    List<WeeklyNamaz>? weeklyNamaz,
  }) =>
      AllMasjitListResponceModel(
        id: id ?? this.id,
        location: location ?? this.location,
        images: images ?? this.images,
        weeklyNamaz: weeklyNamaz ?? this.weeklyNamaz,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['images'] = images;
    if (weeklyNamaz != null) {
      map['weekly_namaz'] = weeklyNamaz?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// day : "FAJR"
/// azan : "05:00"
/// jammt : "05:00"

class WeeklyNamaz {
  WeeklyNamaz({
    this.day,
    this.azan,
    this.jammt,
  });

  WeeklyNamaz.fromJson(dynamic json) {
    day = json['day'];
    azan = json['azan'];
    jammt = json['jammt'];
  }

  String? day;
  String? azan;
  String? jammt;

  WeeklyNamaz copyWith({
    String? day,
    String? azan,
    String? jammt,
  }) =>
      WeeklyNamaz(
        day: day ?? this.day,
        azan: azan ?? this.azan,
        jammt: jammt ?? this.jammt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['azan'] = azan;
    map['jammt'] = jammt;
    return map;
  }
}

/// lat : "18.56603826697165"
/// long : "73.77360616239547"
/// place : "The Rustle Nest"

class Location {
  Location({
    this.lat,
    this.long,
    this.place,
  });

  Location.fromJson(dynamic json) {
    lat = json['lat'];
    long = json['long'];
    place = json['place'];
  }

  String? lat;
  String? long;
  String? place;

  Location copyWith({
    String? lat,
    String? long,
    String? place,
  }) =>
      Location(
        lat: lat ?? this.lat,
        long: long ?? this.long,
        place: place ?? this.place,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['long'] = long;
    map['place'] = place;
    return map;
  }
}
