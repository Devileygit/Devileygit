import 'package:deviley_production/FirstLoginDetails/location.dart';
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
        builder: (context,child){
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
            fontFamily: 'Handlee',
            buttonTheme: ButtonThemeData(minWidth: 5),
            textTheme: TextTheme(
                display1: TextStyle(color: Colors.grey[800]),
                display2: TextStyle(color: Colors.grey[800]),
                display3: TextStyle(color: Colors.grey[800]),
                display4: TextStyle(color: Colors.grey[800]),
                body1: TextStyle(color: Colors.grey[800]),
                body2: TextStyle(color: Colors.grey[800]),
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
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if (user == null) {
      return Login();
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