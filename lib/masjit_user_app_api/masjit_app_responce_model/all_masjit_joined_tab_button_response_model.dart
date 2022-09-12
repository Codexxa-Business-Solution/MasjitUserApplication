// To parse this JSON data, do
//
//     final allMasjitJoinedTabButtonResponceModel = allMasjitJoinedTabButtonResponceModelFromJson(jsonString);

import 'dart:convert';

AllMasjitJoinedTabButtonResponceModel allMasjitJoinedTabButtonResponceModelFromJson(String str) => AllMasjitJoinedTabButtonResponceModel.fromJson(json.decode(str));

String allMasjitJoinedTabButtonResponceModelToJson(AllMasjitJoinedTabButtonResponceModel data) => json.encode(data.toJson());

class AllMasjitJoinedTabButtonResponceModel {
  AllMasjitJoinedTabButtonResponceModel({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<dynamic>? data;
  String? message;

  factory AllMasjitJoinedTabButtonResponceModel.fromJson(Map<String, dynamic> json) => AllMasjitJoinedTabButtonResponceModel(
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
