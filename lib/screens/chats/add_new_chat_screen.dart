import 'package:chat/models/SendSMS.dart';
import 'package:chat/screens/contacts/contacts_screen.dart';
import 'package:chat/screens/messages/message_screen.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';

class AddNewChatScreen extends StatefulWidget {
  const AddNewChatScreen({Key key}) : super(key: key);

  @override
  _AddNewChatScreenState createState() => _AddNewChatScreenState();
}

class _AddNewChatScreenState extends State<AddNewChatScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String message;
  final fromController = TextEditingController();
  final toController = TextEditingController();
  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar('Create new message'),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Spacer(
            //   flex: 1,
            // ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: TextFormField(
                onSaved: (value) {
                  phoneNumber = value;
                },
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                controller: fromController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'from',
                ),
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter correct phone number';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: TextFormField(
                onSaved: (value) {
                  phoneNumber = value;
                },
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                controller: toController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'to',
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
                onSaved: (value) {
                  message = value;
                },
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                controller: messageController,
                maxLines: 8,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                  hintText: 'Message here',
                ),
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Please input message';
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
                    SendSMSData smsData = await UserDefaults.sendSMS(
                        fromController.text,
                        toController.text,
                        messageController.text);
                    if (smsData != null) {
                      Fluttertoast.showToast(
                          msg: "Successfully send message",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 5,
                          backgroundColor: kPrimaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      // navigate to login screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContactsScrenState(),
                        ),
                      );
                    }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MessageScreen(),
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
