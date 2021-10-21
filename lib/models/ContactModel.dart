class ContactModel {
  String telephoneNumber;
  String destination;
  String displayNumber;
  String timeZone;

  ContactModel(
      {this.telephoneNumber,
      this.destination,
      this.displayNumber,
      this.timeZone});

  ContactModel.fromJson(Map<String, dynamic> json)
      : telephoneNumber = json['tn'],
        destination = json['destination'],
        displayNumber = json['displayNumber'],
        timeZone = json['timeZone'];

  Map<String, dynamic> toJson() => {
        'tn': telephoneNumber,
        'destination': destination,
        'displayNumber': displayNumber,
        'timeZone': timeZone
      };
}
