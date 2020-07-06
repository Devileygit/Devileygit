import 'package:deviley_production/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../main.dart';

class AccountHome extends StatefulWidget {
  @override
  _AccountHomeState createState() => _AccountHomeState();
}

class _AccountHomeState extends State<AccountHome> {
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    return Container(
      child: SafeArea(
        child: Column(
          children: <Widget>[
            Center(
              child: FlatButton(
                onPressed: () async {
                  dynamic result = await _auth.signOut();
                  if (result == null) {
                    Fluttertoast.showToast(msg: 'Success');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyApp()),
                            (Route<dynamic> route) => false);
                  } else {
                    Fluttertoast.showToast(msg: 'Error');
                  }

//logout/todo
                },
                child: Text('Log Out'),
                splashColor: Colors.transparent,
                color: Colors.pink[600],
                highlightColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              ),
            ),
            Center(
              child: FlatButton(
                onPressed: () async {
                  dynamic result = await _auth.googleSignOut();
                  print(result);
                  if (result == null) {
                    Fluttertoast.showToast(msg: 'Success');
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyApp()),
                            (Route<dynamic> route) => false);
                  } else {
                    Fluttertoast.showToast(msg: 'error');
                  }

//logout/todo
                },
                child: Text('Log Out Google'),
                splashColor: Colors.transparent,
                color: Colors.pink[600],
                highlightColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
