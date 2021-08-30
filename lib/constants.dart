import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const kPrimaryColor = Color(0xFF6450a5);
const secondaryColor = Color(0xFFdb565b);
const contentColorLightTheme = Color(0xFF1D1D35);
const contentColorDarkTheme = Color(0xFFF5FCF9);
const warninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 16.0;

const logoDarkTheme = "assets/icons/Only_logo_dark_theme.svg";
const logoLightTheme = "assets/icons/Only_logo_light_theme.svg";

const requiredField = "This field is required";
const invalidEmail = "Enter a valid email address";

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: requiredField),
    MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'passwords must have at least one special character')
  ],
);

const InputDecoration otpInputDecoration = InputDecoration(
  filled: false,
  border: UnderlineInputBorder(),
  hintText: "0",
);

// For demo

final List<String> demoContactsImage =
    List.generate(5, (index) => "assets/images/user_${index + 1}.png");

const users = const {
  'manoj@gmail.com': '12345',
  'admin@gmail.com': '12345',
};
