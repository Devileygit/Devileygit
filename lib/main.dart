import 'package:deviley_production/home.dart';
import 'package:deviley_production/login.dart';
import 'package:deviley_production/redirect.dart';
import 'package:deviley_production/services/auth.dart';
import 'package:deviley_production/services/sharedprefs.dart';
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
            primaryColor: Colors.deepPurple[600],
            accentColor: Colors.pink[600],
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            fontFamily: 'Delius',
            buttonTheme: ButtonThemeData(minWidth: 5),
            snackBarTheme: SnackBarThemeData(
                backgroundColor: Colors.deepPurple[600],
                contentTextStyle: TextStyle(
                    color: Colors.grey[100],
                    fontFamily: 'Delius',
                    height: 1.4,
                    fontWeight: FontWeight.bold)),
            textTheme: TextTheme(
                headline4: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4
                    ),
                headline3: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4
                    ),
                headline2: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4
                    ),
                headline1: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4
                    ),
                bodyText2: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4
                    ),
                bodyText1: TextStyle(
                    color: Colors.grey[800],
                    height: 1.4
                    ),
                button: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 17,
                    ))),
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
    getUserLoggedInState();
  }

  getUserLoggedInState() async {
    await SharedPrefs.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userLoggedIn = value;
      });
    });
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
