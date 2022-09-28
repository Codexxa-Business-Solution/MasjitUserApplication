// To parse this JSON data, do
//
//     final userLOginRespnseModel = userLOginRespnseModelFromJson(jsonString);

import 'dart:convert';

UserRegisterRespnseModel userRegisterRespnseModelFromJson(String str) => UserRegisterRespnseModel.fromJson(json.decode(str));

String userLOginRespnseModelToJson(UserRegisterRespnseModel data) => json.encode(data.toJson());

class UserRegisterRespnseModel {
  UserRegisterRespnseModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory UserRegisterRespnseModel.fromJson(Map<String, dynamic> json) => UserRegisterRespnseModel(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.phone,
    this.email,
    this.area,
    this.city,
    this.state,
    this.country,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.token,
  });

  String? phone;
  String? email;
  String? area;
  String? city;
  String? state;
  String? country;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phone: json["phone"],
    email: json["email"],
    area: json["area"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    updatedAt: DateTime.parse(json["updated_at"]),
    createdAt: DateTime.parse(json["created_at"]),
    id: json["id"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "email": email,
    "area": area,
    "city": city,
    "state": state,
    "country": country,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "token": token,
  };
}
