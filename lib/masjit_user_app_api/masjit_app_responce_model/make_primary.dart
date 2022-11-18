// To parse this JSON data, do
//
//     final makePrimary = makePrimaryFromJson(jsonString);

import 'dart:convert';

MakePrimaryResponseModel makePrimaryFromJson(String str) => MakePrimaryResponseModel.fromJson(json.decode(str));

String makePrimaryToJson(MakePrimaryResponseModel data) => json.encode(data.toJson());

class MakePrimaryResponseModel {
  MakePrimaryResponseModel({
    this.data,
  });

  String? data;

  factory MakePrimaryResponseModel.fromJson(Map<String, dynamic> json) => MakePrimaryResponseModel(
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "data": data,
  };
}
