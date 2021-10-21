// To parse this JSON data, do
//

import 'dart:convert';

MessageThread messageThreadFromJson(String str) =>
    MessageThread.fromJson(json.decode(str));

String messageThreadToJson(MessageThread data) => json.encode(data.toJson());

class MessageThread {
  MessageThread({
    this.data,
    this.error,
  });

  List<ThreadDatum> data;
  bool error;

  factory MessageThread.fromJson(Map<String, dynamic> json) => MessageThread(
        data: List<ThreadDatum>.from(
            json["data"].map((x) => ThreadDatum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class ThreadDatum {
  ThreadDatum({
    this.messageSid,
    this.messageBody,
    this.messageType,
    this.isSender,
    this.contactNumber,
    this.contactName,
    this.time,
  });

  String messageSid;
  String messageBody;
  String messageType;
  bool isSender;
  String contactNumber;
  String contactName;
  String time;

  factory ThreadDatum.fromJson(Map<String, dynamic> json) => ThreadDatum(
        messageSid: json["messageSID"],
        messageBody: json["messageBody"],
        messageType: json["messageType"],
        isSender: json["isSender"],
        contactNumber: json["contactNumber"],
        contactName: json["contactName"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "messageSID": messageSid,
        "messageBody": messageBody,
        "messageType": messageType,
        "isSender": isSender,
        "contactNumber": contactNumber,
        "contactName": contactName,
        "time": time,
      };
}
