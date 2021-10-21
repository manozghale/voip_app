import 'package:chat/screens/signinOrSignup/signin_or_signup_screen.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../constants.dart';

class ChangePasswordScreen extends StatefulWidget {
  // const ChangePasswordScreen({ Key key }) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String newPassword;
  String confirmPassword;
  final newPasswordValue = TextEditingController();
  final confirmPasswordValue = TextEditingController();
  bool _newPassObscureText = true;
  bool _confirmPassObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Change Password'),
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
                onSaved: (value) {
                  newPassword = value;
                },
                controller: newPasswordValue,
                obscureText: _newPassObscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'New Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newPassObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _newPassObscureText = !_newPassObscureText;
                      });
                    },
                    //_togglePasswordStatus,
                    color: Colors.pink[400],
                  ),
                ),
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter new password';
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
                  confirmPassword = value;
                },
                obscureText: _confirmPassObscureText,
                controller: confirmPasswordValue,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                  hintText: 'Confirm Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPassObscureText
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPassObscureText = !_confirmPassObscureText;
                      });
                    },
                    //_togglePasswordStatus,
                    color: Colors.pink[400],
                  ),
                ),
                validator: (String value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  print('newpassword: ${newPasswordValue.text}');
                  if (value != newPasswordValue.text) {
                    return 'password does not match';
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
                    // call api
                    bool error = await UserDefaults.changePassword(
                        newPasswordValue.text, confirmPasswordValue.text);
                    if (!error) {
                      Fluttertoast.showToast(
                          msg: "Successfully changed password",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: kPrimaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);

                      // navigate to login screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SigninOrSignupScreen(),
                        ),
                      );
                    } else {
                      Fluttertoast.showToast(
                          msg: "password change failed",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 5,
                          backgroundColor: kPrimaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
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
