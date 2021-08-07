import 'package:chat/screens/welcome/welcome_screen.dart';
import 'package:chat/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

final newUserDefault = SharedPreferences.getInstance();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  // In order to track the welcome screen whether it is already loaded or not
  final prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VOIP APP',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      // themeMode: ThemeMode.light,

      home: WelcomeScreen(),
    );
  }

  // _read() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'my_int_key';
  //   final value = prefs.getInt(key) ?? 0;
  //   print('read: $value');
  // }

  // _save() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'my_int_key';
  //   final value = 42;
  //   prefs.setInt(key, value);
  //   print('saved $value');
  // }
}
