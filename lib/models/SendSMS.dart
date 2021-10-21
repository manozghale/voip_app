// To parse this JSON data, do
//

import 'dart:convert';

SendSMS sendSMSFromJson(String str) => SendSMS.fromJson(json.decode(str));

String sendSMSToJson(SendSMS data) => json.encode(data.toJson());

class SendSMS {
  SendSMS({
    this.data,
    this.error,
  });

  SendSMSData data;
  bool error;

  factory SendSMS.fromJson(Map<String, dynamic> json) => SendSMS(
        data: SendSMSData.fromJson(json["data"]),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "error": error,
      };
}

class SendSMSData {
  SendSMSData({
    this.status,
    this.refId,
  });

  bool status;
  String refId;

  factory SendSMSData.fromJson(Map<String, dynamic> json) => SendSMSData(
        status: json["status"],
        refId: json["refID"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "refID": refId,
      };
}
