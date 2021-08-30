import 'dart:developer';

import 'package:chat/components/primary_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/LoginForm.dart';
import 'package:chat/screens/DialogBox/info_dialog_box.dart';
import 'package:chat/screens/chats/chats_screen.dart';
import 'package:chat/screens/forgotPassword/forgot_password_screen.dart';
import 'package:chat/screens/signIn/sign_in_screen.dart';
import 'package:chat/screens/signUp/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SigninOrSignupScreen extends StatelessWidget {
  FocusNode myFocusNode = new FocusNode();
  TextEditingController emailField;
  TextEditingController passwordField;

  final _formKey = GlobalKey<FormState>();
  final model = LoginFormModel();
  final _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   emailField.dispose();
  //   passwordField.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
                decoration: const InputDecoration(
                  // icon: Icon(Icons.person),
                  // hintText: "Please enter your email address",
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onSaved: (String value) {
                  print('Value for field saved as "$value"');
                  model.emailAddress = value;
                },
                onChanged: (text) {
                  print('First text field: $text');
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter an email address';
                  } else if (!_emailRegExp.hasMatch(value)) {
                    return 'Invalid email address!';
                  }
                  return null;
                },
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              TextFormField(
                controller: passwordField,
                obscureText: true,
                decoration: const InputDecoration(
                  // icon: Icon(Icons.person),
                  // hintText: "Please enter your login pasword",
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onSaved: (String value) {
                  print('Value for field saved as "$value"');
                  model.password = value;
                },
                onChanged: (text) {
                  print('First text field: $text');
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                text: "Sign In",
                // press: () {
                //   if (_formKey.currentState.validate()) {
                //     _formKey.currentState.save();

                //     ScaffoldMessenger.of(_formKey.currentContext).showSnackBar(
                //         SnackBar(content: Text('Processing Data')));
                //   }
                // },
                press: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => ChatScreen(),
                  ),
                  //   // MaterialPageRoute(
                  //   //   builder: (context) => SignInScreen(),
                  //   // ),
                ),
              ),

              // SizedBox(
              //   height: kDefaultPadding * 1.5,
              // ),
              // PrimaryButton(
              //   color: Theme.of(context).colorScheme.secondary,
              //   text: "Sign Up",
              //   press: () => Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => SignUpScreen(),
              //     ),
              //   ),
              // ),
              SizedBox(height: kDefaultPadding * 1.5),
              FittedBox(
                child: TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => InfoDialogBox(
                      boxTitle: "Contact Admin",
                      boxContent:
                          "Please contact admin for your password query",
                    ),
                  ),
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => ForgotPasswordScreen(),
                  //   ),
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot Password?",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            decoration: TextDecoration.underline,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .color
                                .withOpacity(0.8)),
                      ),
                      // SizedBox(width: kDefaultPadding / 4),
                    ],
                  ),
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
