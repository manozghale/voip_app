import 'dart:convert';
import 'dart:ffi';

import 'package:chat/models/AddNewContact.dart';
import 'package:chat/models/Chat.dart';
import 'package:chat/models/GetContactList.dart';
import 'package:chat/models/MessageThread.dart';
import 'package:chat/models/SendSMS.dart';
import 'package:chat/screens/messages/components/message.dart';
import 'package:chat/services/url_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;

class UserDefaults {
  static Future<UserData> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getApiKey = prefs.getString(apiKey);
    var getUserId = prefs.getInt(userId);
    var getSessionToken = prefs.getString(sessionToken);
    var getEmailAddress = prefs.getString(emailAddress);
    var user = UserData(
        apiKey: getApiKey,
        userId: getUserId,
        sessionToken: getSessionToken,
        emailAddress: getEmailAddress);
    return user;
  }

  static void setUser(UserData user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(apiKey, user.apiKey);
    prefs.setInt(userId, user.userId);
    prefs.setString(sessionToken, user.sessionToken);
    prefs.setString(emailAddress, user.emailAddress);
  }

  static void removeUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(apiKey);
    prefs.remove(userId);
    prefs.remove(sessionToken);
    prefs.remove(emailAddress);
  }

  static Future<bool> sessionChecker() async {
    // call api services
    print('sessin checker');
    var user = await getUser();
    var response = await http.post(baseUrl, body: {
      'appAction': 'verifyToken',
      'userID': user.userId.toString(),
      'token': user.sessionToken
    });

    Map<String, dynamic> sessionResponse = jsonDecode(response.body);
    print('sessionResponse: $sessionResponse');
    bool error = sessionResponse['error'];
    print('error: $error');
    if (!error) {
      var data = sessionResponse['data'];
      bool isValid = data['valid'];
      return isValid;
    } else {
      return false;
    }
  }

  static void getUserPhoneNumbers() async {
    var user = await getUser();
    var response = await http.post(baseUrl, body: {
      'appAction': 'getUserPhoneNumbers',
      'apiKey': user.apiKey,
      'userID': user.userId.toString(),
      'token': user.sessionToken
    });
  }

  static Future<bool> changePassword(String newPass, String reNewPass) async {
    var user = await getUser();
    var response = await http.post(baseUrl, body: {
      'appAction': 'changePassword',
      'apiKey': user.apiKey,
      'userID': user.userId.toString(),
      'token': user.sessionToken,
      'newPass': newPass,
      'reNewPass': reNewPass
    });
    Map<String, dynamic> changePasswordResponse = jsonDecode(response.body);
    bool error = changePasswordResponse['error'];
    if (!error) {
      var data = changePasswordResponse['data'];
      bool status = data['status'];
      return status;
    }
    return false;
  }

  static Future<SendSMSData> sendSMS(String from, to, message) async {
    var user = await getUser();
    var response = await http.post(baseUrl, body: {
      'appAction': 'sendSMS',
      'apiKey': user.apiKey,
      'userID': user.userId.toString(),
      'token': user.sessionToken,
      'from': from,
      'to': to,
      'msg': message
    });
    // Map<String, dynamic> sendSMSResponse = jsonDecode(response.body);
    final smsResponse = sendSMSFromJson(response.body.toString());
    print('smsresponse: $smsResponse');
    bool error = smsResponse.error;
    if (!error) {
      SendSMSData smsData = smsResponse.data;
      return smsData;
    }
    return null;
  }

  static Future<bool> addEditContactNumber(
      String tn, firstname, lastname, company, email) async {
    var user = await getUser();
    var response = await http.post(baseUrl, body: {
      'appAction': 'contactUpdate',
      'apiKey': user.apiKey,
      'userID': user.userId.toString(),
      'token': user.sessionToken,
      'tn': tn,
      'firstName': firstname,
      'lastName': lastname,
      'company': company,
      'email': email
    });
    // Map<String, dynamic> contactResponse = jsonDecode(response.body);
    final contactResponse = addNewContactFromJson(response.body.toString());
    bool error = contactResponse.error;
    if (!error) {
      AddNewContactData status = contactResponse.data;
      return status.status;
    }
    return false;
  }

  static Future<bool> deleteContactNumber(String tn) async {
    var user = await getUser();
    var response = await http.post(baseUrl, body: {
      'appAction': 'contactUpdate',
      'apiKey': user.apiKey,
      'userID': user.userId.toString(),
      'token': user.sessionToken,
      'tn': tn
    });
    Map<String, dynamic> deleteContactResponse = jsonDecode(response.body);
    bool error = deleteContactResponse['error'];
    if (!error) {
      var data = deleteContactResponse['data'];
      bool status = data['status'];
      return status;
    }
    return false;
  }

  static Future<List<GetContactListData>> getUserContactList(String tn) async {
    var user = await getUser();
    var response = await http.post(baseUrl, body: {
      'appAction': 'contactList',
      'apiKey': user.apiKey,
      'userID': user.userId.toString(),
      'token': user.sessionToken
    });
    // Map<String, dynamic> contactListResponse = jsonDecode(response.body);
    final contactListResponse =
        getContactListFromJson(response.body.toString());
    bool error = contactListResponse.error;
    if (!error) {
      List<GetContactListData> contactListData = contactListResponse.data;
      return contactListData;
    }
    return null;
  }

  static Future<String> forgotPassword(String emailAddress) async {
    print(emailAddress);
    var response = await http.post(baseUrl,
        body: {'appAction': 'forgotPassword', 'email': emailAddress});
    Map<String, dynamic> forgotResponse = jsonDecode(response.body);
    print(forgotResponse);
    bool error = forgotResponse['error'];
    if (!error) {
      String message = forgotResponse['message'];
      return message;
    }
    return null;
  }

  static Future<List<MessageDatum>> getMessageList(String tn) async {
    // List<MessageList> data;
    var user = await getUser();
    var response = await http.post(baseUrl, body: {
      'appAction': 'getMessagesList',
      'apiKey': user.apiKey,
      'userID': user.userId.toString(),
      'token': user.sessionToken,
      'tn': tn
    });
    final messageListResponse = welcomeFromJson(response.body.toString());
    // MessageList messageListResponse =
    //     json.decode(response.body); //jsonDecode(response.body.toString());

    print('messagelistresponse: ${response.body.toString()}');
    print('message list error: ${messageListResponse.error}');
    if (!messageListResponse.error) {
      List<MessageDatum> messageData = messageListResponse.data;
      print('user data: $messageData');
      return messageData;
    } else {
      return null;
    }
  }

  static Future<List<ThreadDatum>> getMessageThread(
      String tn, contactNumber) async {
    var user = await getUser();
    var response = await http.post(baseUrl, body: {
      'appAction': 'getMessageThread',
      'apiKey': user.apiKey,
      'userID': user.userId.toString(),
      'token': user.sessionToken,
      'tn': tn,
      'contactNumber': contactNumber
    });
    final messageThreadResponse =
        messageThreadFromJson(response.body.toString());
    print('message thread: ${response.body.toString()}');
    // Map<String, dynamic> messageThreadResponse = jsonDecode(response.body);
    bool error = messageThreadResponse.error;
    if (!error) {
      List<ThreadDatum> threadData = messageThreadResponse.data;
      print('thread data: $threadData');
      for (var msg in threadData) {
        print('thread: ${msg.messageBody}');
      }
      return threadData;
    }
    return null;
  }
}

class UserData {
  String apiKey;
  int userId;
  String sessionToken;
  String emailAddress;
  UserData({this.apiKey, this.userId, this.sessionToken, this.emailAddress});
}

class UserConactList {
  String tn;
  int firstname;
  String lastname;
  String company;
  String email;
  UserConactList(
      {this.tn, this.firstname, this.lastname, this.company, this.email});
}

class UserPhoneNumbersResponse {}
