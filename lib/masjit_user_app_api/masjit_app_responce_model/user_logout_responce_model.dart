// To parse this JSON data, do
//
//     final useLogoutResponceModel = useLogoutResponceModelFromJson(jsonString);

import 'dart:convert';

UseLogoutResponceModel useLogoutResponceModelFromJson(String str) => UseLogoutResponceModel.fromJson(json.decode(str));

String useLogoutResponceModelToJson(UseLogoutResponceModel data) => json.encode(data.toJson());

class UseLogoutResponceModel {
  UseLogoutResponceModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<dynamic>? data;
  String? message;

  factory UseLogoutResponceModel.fromJson(Map<String, dynamic> json) => UseLogoutResponceModel(
    success: json["success"],
    data: List<dynamic>.from(json["data"].map((x) => x)),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x)),
    "message": message,
  };
}
