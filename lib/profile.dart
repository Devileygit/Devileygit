import 'package:deviley_production/home.dart';
import 'package:deviley_production/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.red,
      child: Column(
        children: <Widget>[
          Center(
            child: FlatButton(
              onPressed: () async {
                dynamic result = await _auth.signOut();
                if (result == null) {
                  Fluttertoast.showToast(msg: 'Success');
                  Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (Route<dynamic> route) => false);
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
                  Navigator.of(context)
                      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyApp()), (Route<dynamic> route) => false);
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
    );
  }
}
