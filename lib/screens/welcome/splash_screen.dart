import 'package:chat/screens/chats/chats_screen.dart';
import 'package:chat/screens/signinOrSignup/signin_or_signup_screen.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<bool> loginCheckFuture;

  @override
  void initState() {
    super.initState();
    // demo time it required to load inital data
    loginCheckFuture = _checkIfLoggedIn();
    // Future.delayed(
    //   Duration(seconds: 15),
    //   () => Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => WelcomeScreen(),
    //       )),
    // );
  }

  Future<bool> _checkIfLoggedIn() async {
    bool sessionPersist = await UserDefaults.sessionChecker();
    // sessionPersist = false;
    print('sessionPersist: $sessionPersist');
    if (sessionPersist) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Widget child;
    return FutureBuilder(
        future: loginCheckFuture,
        builder: (context, snapshot) {
          print('snapshot: $snapshot');
          if (snapshot.hasData) {
            if (snapshot.data == true) {
              // verify sesion id and session time
              child = ChatScreen();
            } else {
              child = SigninOrSignupScreen();
            }
          } else {
            // future hasnt completed yet
            // child = SvgPicture.asset(
            //   MediaQuery.of(context).platformBrightness == Brightness.dark
            //       ? "assets/icons/Logo_dark_theme.svg"
            //       : "assets/icons/Logo_light_theme.svg",
            // );
            child = SigninOrSignupScreen();
          }

          return Scaffold(
            body: Center(
              child: child,
            ),
          );
        });
  }
}
