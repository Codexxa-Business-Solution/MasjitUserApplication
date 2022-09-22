// To parse this JSON data, do
//
//     final useRemoveResponceModel = useRemoveResponceModelFromJson(jsonString);

import 'dart:convert';

UseRemoveResponceModel useRemoveResponceModelFromJson(String str) => UseRemoveResponceModel.fromJson(json.decode(str));

String useRemoveResponceModelToJson(UseRemoveResponceModel data) => json.encode(data.toJson());

class UseRemoveResponceModel {
  UseRemoveResponceModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory UseRemoveResponceModel.fromJson(Map<String, dynamic> json) => UseRemoveResponceModel(
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
    this.userId,
    this.masjidId,
  });

  int? userId;
  String? masjidId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    masjidId: json["masjid_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "masjid_id": masjidId,
  };
}
