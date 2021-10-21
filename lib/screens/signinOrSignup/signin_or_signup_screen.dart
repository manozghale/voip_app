import 'dart:convert';

import 'package:chat/components/primary_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/LoginForm.dart';
import 'package:chat/screens/DialogBox/info_dialog_box.dart';
import 'package:chat/screens/chats/chats_screen.dart';
import 'package:chat/screens/forgotPassword/forgot_password_screen.dart';
import 'package:chat/screens/loader_screen/loader_screen.dart';
import 'package:chat/screens/messages/message_screen.dart';
import 'package:chat/services/url_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninOrSignupScreen extends StatefulWidget {
  @override
  _SigninOrSignupScreenState createState() => _SigninOrSignupScreenState();
}

class _SigninOrSignupScreenState extends State<SigninOrSignupScreen> {
  FocusNode myFocusNode = new FocusNode();
  TextEditingController emailField = TextEditingController();

  TextEditingController passwordField = TextEditingController();

  // shared instance initialization
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  final model = LoginFormModel();

  bool loading = false;

  bool _obscureText = true;
  // Toggles the password show status
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  children: [
                    Spacer(
                      flex: 2,
                    ),
                    // Image.asset(
                    //   MediaQuery.of(context).platformBrightness == Brightness.light
                    //       ? "assets/images/Logo_light.png"
                    //       : "assets/images/Logo_dark.png",
                    //   height: 146,
                    // ),

                    TextFormField(
                      focusNode: myFocusNode,
                      controller: emailField,
                      validator: EmailValidator(
                          errorText: "Please enter email in valid format"),
                      decoration: const InputDecoration(
                        // icon: Icon(Icons.person),
                        fillColor: Colors.black12,
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.purple,
                        ),
                      ),
                      onSaved: (String value) {
                        print('Value for field saved as "$value"');
                        model.emailAddress = value;
                      },
                    ),

                    SizedBox(height: kDefaultPadding * 1.5),

                    TextFormField(
                      controller: passwordField,
                      obscureText: _obscureText,
                      validator: passwordValidator,
                      decoration: InputDecoration(
                        // icon: Icon(Icons.password),
                        fillColor: Colors.black12,
                        labelText: "Password",
                        labelStyle: TextStyle(
                          color: Colors.purple,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: _togglePasswordStatus,
                          color: Colors.pink[400],
                        ),
                      ),
                      onSaved: (String value) {
                        print('Value for field saved as "$value"');
                        model.password = value;
                      },
                    ),

                    SizedBox(height: kDefaultPadding * 1.5),
                    PrimaryButton(
                      text: "Sign In",
                      press: () async {
                        if (emailField.text.isNotEmpty &&
                            passwordField.text.isNotEmpty) {
                          setState(() {
                            loading = true;
                          });

                          // call api services
                          var response = await http.post(baseUrl, body: {
                            'appAction': 'login',
                            'email': emailField.text,
                            'pass': passwordField.text
                          });

                          Map<String, dynamic> user = jsonDecode(response.body);
                          bool error = user['error'];
                          if (!error) {
                            // login successful - saved to sharedpreferences
                            final SharedPreferences prefs = await _prefs;
                            var result = user['data'];
                            var userUserId = result['$userId'];
                            var userApiKey = result['$apiKey'];
                            var userSessionToken = result['$sessionToken'];
                            var userEmailAddress = result['$emailAddress'];

                            prefs.setString(apiKey, userApiKey);
                            prefs.setInt(userId, userUserId);
                            prefs.setString(sessionToken, userSessionToken);
                            prefs.setString(emailAddress, userEmailAddress);

                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                fullscreenDialog: true,
                                builder: (context) => ChatScreen(),
                              ),
                            );
                          } else {
                            // show failure message
                            setState(() {
                              loading = false;
                            });
                            Fluttertoast.showToast(
                                msg: "Please enter valid email or password",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 5,
                                backgroundColor: kPrimaryColor,
                                textColor: secondaryColor,
                                fontSize: 16.0);
                          }
                        } else {
                          // empty text field. show message
                          Fluttertoast.showToast(
                              msg: "Please fill all the fields",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              timeInSecForIosWeb: 5,
                              backgroundColor: kPrimaryColor,
                              textColor: secondaryColor,
                              fontSize: 16.0);
                        }
                      },
                    ),

                    SizedBox(height: kDefaultPadding * 1.5),
                    FittedBox(
                      child: TextButton(
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .color
                                  .withOpacity(0.8)),
                        ),
                        // color: Colors.black,
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              fullscreenDialog: true,
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                          // showDialog(
                          //   context: context,
                          //   builder: (BuildContext context) =>
                          //       // _buildPopupDialog(context),
                          //       InfoDialogBox(
                          //     boxTitle: "Test",
                          //     boxContent: "test content",
                          //   ),
                          // );
                        },
                      ),
                    ),
                    Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
