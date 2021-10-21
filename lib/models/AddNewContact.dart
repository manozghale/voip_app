// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AddNewContact addNewContactFromJson(String str) =>
    AddNewContact.fromJson(json.decode(str));

String addNewContactToJson(AddNewContact data) => json.encode(data.toJson());

class AddNewContact {
  AddNewContact({
    this.data,
    this.error,
  });

  AddNewContactData data;
  bool error;

  factory AddNewContact.fromJson(Map<String, dynamic> json) => AddNewContact(
        data: AddNewContactData.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
      };
}

class AddNewContactData {
  AddNewContactData({
    this.status,
  });

  bool status;

  factory AddNewContactData.fromJson(Map<String, dynamic> json) =>
      AddNewContactData(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
