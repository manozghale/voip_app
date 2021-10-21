// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MessageList welcomeFromJson(String str) =>
    MessageList.fromJson(json.decode(str));

String welcomeToJson(MessageList data) => json.encode(data.toJson());

class MessageList {
  MessageList({
    this.data,
    this.error,
  });

  List<MessageDatum> data;
  bool error;

  factory MessageList.fromJson(Map<String, dynamic> json) => MessageList(
        data: List<MessageDatum>.from(
            json["data"].map((x) => MessageDatum.fromJson(x))),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
      };
}

class MessageDatum {
  MessageDatum({
    this.contactNumber,
    this.contactName,
    this.messageSeen,
    this.recentMessage,
    this.time,
  });

  String contactNumber;
  String contactName;
  String messageSeen;
  String recentMessage;
  String time;

  factory MessageDatum.fromJson(Map<String, dynamic> json) => MessageDatum(
        contactNumber: json["contactNumber"],
        contactName: json["contactName"],
        messageSeen: json["message_seen"],
        recentMessage: json["recentMessage"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "contactNumber": contactNumber,
        "contactName": contactName,
        "message_seen": messageSeen,
        "recentMessage": recentMessage,
        "time": time,
      };
}

class Chat {
  final String name, lastMessage, image, time;
  final bool isActive;

  Chat({
    this.name,
    this.lastMessage,
    this.image,
    this.time,
    this.isActive,
  });
}

List chatsData = [
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/user.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/user_2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "assets/images/user_3.png",
    time: "5d ago",
    isActive: false,
  ),
  Chat(
    name: "Jacob Jones",
    lastMessage: "You’re welcome :)",
    image: "assets/images/user_4.png",
    time: "5d ago",
    isActive: true,
  ),
  Chat(
    name: "Albert Flores",
    lastMessage: "Thanks",
    image: "assets/images/user_5.png",
    time: "6d ago",
    isActive: false,
  ),
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/user.png",
    time: "3m ago",
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/user_2.png",
    time: "8m ago",
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "assets/images/user_3.png",
    time: "5d ago",
    isActive: false,
  ),
];
