// To parse this JSON data, do
//
//     final userUpdateRegistrationResponceModel = userUpdateRegistrationResponceModelFromJson(jsonString);

import 'dart:convert';

UserUpdateRegistrationResponceModel userUpdateRegistrationResponceModelFromJson(String str) => UserUpdateRegistrationResponceModel.fromJson(json.decode(str));

String userUpdateRegistrationResponceModelToJson(UserUpdateRegistrationResponceModel data) => json.encode(data.toJson());

class UserUpdateRegistrationResponceModel {
  UserUpdateRegistrationResponceModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory UserUpdateRegistrationResponceModel.fromJson(Map<String, dynamic> json) => UserUpdateRegistrationResponceModel(
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
  });

  int? id;
  dynamic name;
  dynamic email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? role;
  String? phone;
  String? area;
  String? city;
  String? state;
  String? country;

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
  };
}
