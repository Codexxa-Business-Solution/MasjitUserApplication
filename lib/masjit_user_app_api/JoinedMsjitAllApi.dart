import 'dart:convert';

/// id : 1
/// weekly_namaz : [{"day":"FAJR","azan":"05:00","jammt":"05:00"},{"day":"ZUHAR","azan":"05:00","jammt":"05:00"},{"day":"ASR","azan":"05:00","jammt":"05:00"},{"day":"MAGHRIB","azan":"05:00","jammt":"05:00"},{"day":"ISHA","azan":"05:00","jammt":"05:00"},{"day":"JUMA","azan":"05:00","jammt":"05:00"}]
/// trustee : [{"designation":"Chairman","name":"Feroz","contact":"9168682309"},{"designation":"Vice Chairman","name":"Feroz","contact":"9168682309"},{"designation":"Vice President","name":"Feroz","contact":"9168682309"}]
/// ed : [{"name":"EID AL - FITR","jammat":[{"name":"jammat 1","time":"08:30"},{"name":"jammat 1","time":"08:30"}]},{"name":"EID AL - ADHA","jammat":[{"name":"jammat 1","time":"08:30"},{"name":"jammat 1","time":"08:30"}]}]
/// location : {"lat":"18.56603826697165","long":"73.77360616239547","place":"The Rustle Nest"}
/// images : ["https://picsum.photos/200/300","https://picsum.photos/200/300"]
/// notices : ["notice 1","notice 2"]
/// sahr : "05:00"
/// iftar : "05:00"
///
///
///
///



List<JoinedMsjitAllApi> userModelFromJson(String str) =>
    List<JoinedMsjitAllApi>.from(json.decode(str).map((x) => JoinedMsjitAllApi.fromJson(x)));
   // List<JoinedMsjitAllApi>.from(json.decode(str).map((x) => JoinedMsjitAllApi.fromJson(x)));

String userModelToJson(List<JoinedMsjitAllApi> data) =>
    json.encode(List<JoinedMsjitAllApi>.from(data.map((x) => x.toJson())));

class JoinedMsjitAllApi {
  JoinedMsjitAllApi({
      this.id, 
      this.weeklyNamaz, 
      this.trustee, 
      this.ed, 
      this.location, 
      this.images, 
      this.notices, 
      this.sahr, 
      this.iftar,});

  JoinedMsjitAllApi.fromJson(dynamic json) {
    id = json['id'];
    if (json['weekly_namaz'] != null) {
      weeklyNamaz = [];
      json['weekly_namaz'].forEach((v) {
        weeklyNamaz?.add(WeeklyNamaz.fromJson(v));
      });
    }
    if (json['trustee'] != null) {
      trustee = [];
      json['trustee'].forEach((v) {
        trustee?.add(Trustee.fromJson(v));
      });
    }
    if (json['ed'] != null) {
      ed = [];
      json['ed'].forEach((v) {
        ed?.add(Ed.fromJson(v));
      });
    }
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    images = json['images'] != null ? json['images'].cast<String>() : [];
    notices = json['notices'] != null ? json['notices'].cast<String>() : [];
    sahr = json['sahr'];
    iftar = json['iftar'];
  }
  int? id;
  List<WeeklyNamaz>? weeklyNamaz;
  List<Trustee>? trustee;
  List<Ed>? ed;
  Location? location;
  List<String>? images;
  List<String>? notices;
  String? sahr;
  String? iftar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (weeklyNamaz != null) {
      map['weekly_namaz'] = weeklyNamaz?.map((v) => v.toJson()).toList();
    }
    if (trustee != null) {
      map['trustee'] = trustee?.map((v) => v.toJson()).toList();
    }
    if (ed != null) {
      map['ed'] = ed?.map((v) => v.toJson()).toList();
    }
    if (location != null) {
      map['location'] = location?.toJson();
    }
    map['images'] = images;
    map['notices'] = notices;
    map['sahr'] = sahr;
    map['iftar'] = iftar;
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
      this.place,});

  Location.fromJson(dynamic json) {
    lat = json['lat'];
    long = json['long'];
    place = json['place'];
  }
  String? lat;
  String? long;
  String? place;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['long'] = long;
    map['place'] = place;
    return map;
  }

}

/// name : "EID AL - FITR"
/// jammat : [{"name":"jammat 1","time":"08:30"},{"name":"jammat 1","time":"08:30"}]

class Ed {
  Ed({
      this.name, 
      this.jammat,});

  Ed.fromJson(dynamic json) {
    name = json['name'];
    if (json['jammat'] != null) {
      jammat = [];
      json['jammat'].forEach((v) {
        jammat?.add(Jammat.fromJson(v));
      });
    }
  }
  String? name;
  List<Jammat>? jammat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    if (jammat != null) {
      map['jammat'] = jammat?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "jammat 1"
/// time : "08:30"

class Jammat {
  Jammat({
      this.name, 
      this.time,});

  Jammat.fromJson(dynamic json) {
    name = json['name'];
    time = json['time'];
  }
  String? name;
  String? time;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['time'] = time;
    return map;
  }

}

/// designation : "Chairman"
/// name : "Feroz"
/// contact : "9168682309"

class Trustee {
  Trustee({
      this.designation, 
      this.name, 
      this.contact,});

  Trustee.fromJson(dynamic json) {
    designation = json['designation'];
    name = json['name'];
    contact = json['contact'];
  }
  String? designation;
  String? name;
  String? contact;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['designation'] = designation;
    map['name'] = name;
    map['contact'] = contact;
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
      this.jammt,});

  WeeklyNamaz.fromJson(dynamic json) {
    day = json['day'];
    azan = json['azan'];
    jammt = json['jammt'];
  }
  String? day;
  String? azan;
  String? jammt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['azan'] = azan;
    map['jammt'] = jammt;
    return map;
  }

}