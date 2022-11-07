// To parse this JSON data, do
//
//     final deleteAccount = deleteAccountFromJson(jsonString);

import 'dart:convert';

DeleteAccount deleteAccountFromJson(String str) => DeleteAccount.fromJson(json.decode(str));

String deleteAccountToJson(DeleteAccount data) => json.encode(data.toJson());

class DeleteAccount {
  DeleteAccount({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  List<dynamic>? data;
  String? message;

  factory DeleteAccount.fromJson(Map<String, dynamic> json) => DeleteAccount(
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
