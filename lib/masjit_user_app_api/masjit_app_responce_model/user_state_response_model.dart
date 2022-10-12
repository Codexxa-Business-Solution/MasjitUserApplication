// To parse this JSON data, do
//
//     final addDropDownListResponseModel = addDropDownListResponseModelFromJson(jsonString);

import 'dart:convert';

List<AddDropDownListResponseModel> addDropDownListResponseModelFromJson(String str) => List<AddDropDownListResponseModel>.from(json.decode(str).map((x) => AddDropDownListResponseModel.fromJson(x)));

String addDropDownListResponseModelToJson(List<AddDropDownListResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddDropDownListResponseModel {
  AddDropDownListResponseModel({
    this.id,
    this.nameMr,
    this.nameEn,
    this.nameHi,
    this.createdAt,
    this.updatedAt,
    this.stateId,
  });

  String? id;
  String? nameMr;
  String? nameEn;
  dynamic nameHi;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? stateId;

  factory AddDropDownListResponseModel.fromJson(Map<String, dynamic> json) => AddDropDownListResponseModel(
    id: json["id"],
    nameMr: json["name_mr"],
    nameEn: json["name_en"],
    nameHi: json["name_hi"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    stateId: json["state_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name_mr": nameMr,
    "name_en": nameEn,
    "name_hi": nameHi,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "state_id": stateId,
  };
}
