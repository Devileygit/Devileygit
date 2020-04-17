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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: Colors.deepPurple[600],
            accentColor: Colors.pink[600],
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            fontFamily: 'BalooPaaji',
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
