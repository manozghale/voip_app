import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String emailAddress;
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  emailAddress = value;
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'email address',
                ),
                validator: emailValidator,
                // validator: (String value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter email address';
                //   }
                //   return null;
                // },
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
                    String message =
                        await UserDefaults.forgotPassword(emailController.text);

                    Fluttertoast.showToast(
                        msg: message,
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        timeInSecForIosWeb: 5,
                        backgroundColor: kPrimaryColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
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
}
