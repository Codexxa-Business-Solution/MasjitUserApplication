// To parse this JSON data, do
//
//     final userPhoneNumberRegistrationResponceModel = userPhoneNumberRegistrationResponceModelFromJson(jsonString);

import 'dart:convert';

UserPhoneNumberRegistrationResponceModel userPhoneNumberRegistrationResponceModelFromJson(String str) => UserPhoneNumberRegistrationResponceModel.fromJson(json.decode(str));

String userPhoneNumberRegistrationResponceModelToJson(UserPhoneNumberRegistrationResponceModel data) => json.encode(data.toJson());

class UserPhoneNumberRegistrationResponceModel {
  UserPhoneNumberRegistrationResponceModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory UserPhoneNumberRegistrationResponceModel.fromJson(Map<String, dynamic> json) => UserPhoneNumberRegistrationResponceModel(
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
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.role,
    this.phone,
    this.area,
    this.city,
    this.state,
    this.country,
    this.token,
  });

  int? id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? role;
  String? phone;
  dynamic area;
  dynamic city;
  dynamic state;
  dynamic country;
  String? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    role: json["role"],
    phone: json["phone"],
    area: json["area"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "role": role,
    "phone": phone,
    "area": area,
    "city": city,
    "state": state,
    "country": country,
    "token": token,
  };
}
