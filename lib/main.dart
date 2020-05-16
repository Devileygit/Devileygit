import 'package:deviley_production/home.dart';
import 'package:deviley_production/login.dart';
import 'package:deviley_production/redirect.dart';
import 'package:deviley_production/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(RunApp());
}

class RunApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child,
          );
        },
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.deepPurple[500],
            accentColor: Colors.pink[600],
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            fontFamily: 'Flamenco',
            buttonTheme: ButtonThemeData(minWidth: 5),
            snackBarTheme: SnackBarThemeData(
                backgroundColor: Colors.deepPurple[500],
                contentTextStyle: TextStyle(
                    color: Colors.grey[100],
                    fontFamily: 'Flamenco',
                    fontWeight: FontWeight.bold)),
            textTheme: TextTheme(
                headline4: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4,
                    fontWeight: FontWeight.bold),
                headline3: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4,
                    fontWeight: FontWeight.bold),
                headline2: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4,
                    fontWeight: FontWeight.bold),
                headline1: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4,
                    fontWeight: FontWeight.bold),
                bodyText2: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4,
                    fontWeight: FontWeight.bold),
                bodyText1: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4,
                    fontWeight: FontWeight.bold),
                button: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 17,
                    fontWeight: FontWeight.bold))),
        home: MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userLoggedIn;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (userLoggedIn == true) {
      return Home();
    } else {
      return Redirect();
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
