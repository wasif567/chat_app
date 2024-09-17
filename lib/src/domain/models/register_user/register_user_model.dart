import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterUserModel {
  String? id;
  String? email;
  String? password;
  String? mobileNumber;
  String? country;
  String? fullName;

  RegisterUserModel({
    this.id,
    this.email,
    this.password,
    this.mobileNumber,
    this.country,
    this.fullName,
  });

  static List<RegisterUserModel> fromJsonList(List list) {
    return list.map((item) => RegisterUserModel.fromJson(item)).toList();
  }

  factory RegisterUserModel.fromRawJson(String str) => RegisterUserModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RegisterUserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return RegisterUserModel(
      id: data["uui"],
      email: data["email"],
      mobileNumber: data["mobileNumber"],
      country: data["country"],
      fullName: data["displayName"],
    );
  }

  factory RegisterUserModel.fromJson(Map<String, dynamic> json) => RegisterUserModel(
        email: json["email"],
        password: json["password"],
        mobileNumber: json["mobileNumber"],
        country: json["country"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "mobileNumber": mobileNumber,
        "country": country,
        "fullName": fullName,
      };
}
