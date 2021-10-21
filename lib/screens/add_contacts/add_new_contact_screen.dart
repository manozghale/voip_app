import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';

class AddNewContactScreen extends StatefulWidget {
  const AddNewContactScreen({Key key}) : super(key: key);

  @override
  _AddNewContactScreenState createState() => _AddNewContactScreenState();
}

class _AddNewContactScreenState extends State<AddNewContactScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String message;
  final tnController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastNameController = TextEditingController();
  final companyController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar('Add New Contact'),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Spacer(
            //   flex: 1,
            // ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                onSaved: (value) {
                  phoneNumber = value;
                },
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                controller: tnController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'Telephone Number *',
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
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                onSaved: (value) {
                  phoneNumber = value;
                },
                controller: firstnameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  hintText: 'First Name',
                ),
                // validator: (String value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please enter First Name';
                //   }
                //   return null;
                // },
              ),
            ),
            // SizedBox(height: kDefaultPadding * 1.5),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                onSaved: (value) {
                  message = value;
                },
                controller: lastNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                  hintText: 'Last Name',
                ),
                // validator: (String value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please input lastname';
                //   }
                //   return null;
                // },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                onSaved: (value) {
                  message = value;
                },
                controller: companyController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                  hintText: 'Company',
                ),
                // validator: (String value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please input company name';
                //   }
                //   return null;
                // },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: TextFormField(
                scrollPadding: EdgeInsets.only(bottom: 40),
                onSaved: (value) {
                  message = value;
                },
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                  hintText: 'Email Address',
                ),
                // validator: (String value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please input Email Address';
                //   }
                //   return null;
                // },
              ),
            ),
            // SizedBox(height: kDefaultPadding * 1.5),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding / 2),
              child: ElevatedButton(
                onPressed: () async {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (_formKey.currentState.validate()) {
                    // Process data. save to model/db
                    bool status = await UserDefaults.addEditContactNumber(
                        tnController.text,
                        firstnameController.text,
                        lastNameController.text,
                        companyController.text,
                        emailController.text);
                    if (status) {
                      tnController.text = '';
                      firstnameController.text = '';
                      lastNameController.text = '';
                      companyController.text = '';
                      emailController.text = '';
                      Fluttertoast.showToast(
                          msg: "Contact Saved",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: kPrimaryColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Failed to save contact",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
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
