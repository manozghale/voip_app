import 'dart:convert';

import 'package:chat/services/url_constants.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class CallForwardingScreen extends StatelessWidget {
  // CallForwardingScreen({Key key,}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String forwardingNumber;
  final phoneController = TextEditingController();
  final forwardController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Call Forwaring'),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  phoneNumber = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'Parent Phone Number',
                ),
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter correct phone number';
                  }
                  return null;
                },
              ),
            ),
            // SizedBox(height: kDefaultPadding * 1.5),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: TextFormField(
                controller: forwardController,
                keyboardType: TextInputType.phone,
                onSaved: (value) {
                  forwardingNumber = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                  hintText: 'forwarding phone number',
                ),
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter correct phone number';
                  }
                  return null;
                },
              ),
            ),
            // SizedBox(height: kDefaultPadding * 1.5),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // Process data. save to model/db
                    // call api
                    print('phone number ${phoneController.text}');
                    print('forward number  ${forwardController.text}');
                    var user = await UserDefaults.getUser();
                    var response = await http.post(baseUrl, body: {
                      'appAction': 'setCallForwarding',
                      'apiKey': user.apiKey,
                      'userID': user.userId.toString(),
                      'token': user.sessionToken,
                      'tn': phoneController.text,
                      'destination': forwardController.text,
                      'displayNumber': 0.toString(),
                      // 'timeZone': '', //(optional) default: pacific
                    });

                    Map<String, dynamic> forwardingResponse =
                        jsonDecode(response.body);
                    print('forwarding response $forwardingResponse');
                    print('response body ${response.body}');
                    bool error = forwardingResponse['error'];
                    if (!error) {
                      Fluttertoast.showToast(
                          msg: "Successfully forwarded calls",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: kPrimaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "call forward failed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: kPrimaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MessagesScreen(),
                    //   ),
                    // );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget appBar(String text) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(text),
    );
  }
}
