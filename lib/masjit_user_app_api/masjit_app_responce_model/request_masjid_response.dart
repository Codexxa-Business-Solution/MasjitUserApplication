// To parse this JSON data, do
//
//     final requestFormResponse = requestFormResponseFromJson(jsonString);

import 'dart:convert';

RequestFormResponse requestFormResponseFromJson(String str) => RequestFormResponse.fromJson(json.decode(str));

String requestFormResponseToJson(RequestFormResponse data) => json.encode(data.toJson());

class RequestFormResponse {
  RequestFormResponse({
    this.message,
  });

  String? message;

  factory RequestFormResponse.fromJson(Map<String, dynamic> json) => RequestFormResponse(
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
  };
}
