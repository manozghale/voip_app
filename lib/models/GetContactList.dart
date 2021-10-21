// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetContactList getContactListFromJson(String str) =>
    GetContactList.fromJson(json.decode(str));

String getContactListToJson(GetContactList data) => json.encode(data.toJson());

class GetContactList {
  GetContactList({
    this.data,
    this.error,
  });

  List<GetContactListData> data;
  bool error;

  factory GetContactList.fromJson(Map<String, dynamic> json) => GetContactList(
        data: List<GetContactListData>.from(
            json["data"].map((x) => GetContactListData.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class GetContactListData {
  GetContactListData({
    this.tn,
    this.firstName,
    this.lastName,
    this.company,
    this.email,
  });

  String tn;
  String firstName;
  String lastName;
  String company;
  String email;

  factory GetContactListData.fromJson(Map<String, dynamic> json) =>
      GetContactListData(
        tn: json["tn"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        company: json["company"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "tn": tn,
        "firstName": firstName,
        "lastName": lastName,
        "company": company,
        "email": email,
      };
}
