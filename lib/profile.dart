import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/AccountSettings/accounthome.dart';
import 'package:deviley_production/home.dart';
import 'package:deviley_production/UserProfileEdits/profileedit.dart';
import 'package:deviley_production/services/auth.dart';
import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'main.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  AuthService _auth = AuthService();
  Stream<DocumentSnapshot> myDetails;
  Database database = Database();
  String myUid;
  var userDoc;

  getUserIdAndUserData() async {
    await SharedPrefs.getUserIdSharedPreference().then((value) {
      setState(() {
        myUid = value;
        database.getPersonalData(myUid).then((val) {
          setState(() {
            myDetails = val;
          });
        });
      });
    });
  }

  Widget profileAvatar() {
    return StreamBuilder(
        stream: myDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            userDoc = snapshot.data.data;
            return Container(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(userDoc['profilePhoto']),
                      backgroundColor: Colors.grey[500],
                      radius: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userDoc['name'] + ', ' + userDoc['age'],
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      userDoc['cityName'],
                      style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserIdAndUserData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          profileAvatar(),
          RaisedButton(
            splashColor: Colors.transparent,
            color: Colors.pink[600],
            highlightColor: Colors.pinkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            onPressed: () {},
            child: Text(
              'Poisa Patir button eta',
              style: TextStyle(color: Colors.grey[100]),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileEdit()));
            },
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0)),
              child: Container(
                height: 70,
                color: Colors.pink[50],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Edit My Profile',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AccountHome()));
            },
            child: Card(
              margin: EdgeInsets.all(0),
              elevation: 4,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              child: Container(
                height: 70,
                color: Colors.pink[50],
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Account Settings',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Column(
//children: <Widget>[
//Center(
//child: FlatButton(
//onPressed: () async {
//dynamic result = await _auth.signOut();
//if (result == null) {
//Fluttertoast.showToast(msg: 'Success');
//Navigator.of(context).pushAndRemoveUntil(
//MaterialPageRoute(builder: (context) => MyApp()),
//(Route<dynamic> route) => false);
//} else {
//Fluttertoast.showToast(msg: 'Error');
//}
//
////logout/todo
//},
//child: Text('Log Out'),
//splashColor: Colors.transparent,
//color: Colors.pink[600],
//highlightColor: Colors.pinkAccent,
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.circular(40),
//),
//padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
//),
//),
//Center(
//child: FlatButton(
//onPressed: () async {
//dynamic result = await _auth.googleSignOut();
//print(result);
//if (result == null) {
//Fluttertoast.showToast(msg: 'Success');
//Navigator.of(context).pushAndRemoveUntil(
//MaterialPageRoute(builder: (context) => MyApp()),
//(Route<dynamic> route) => false);
//} else {
//Fluttertoast.showToast(msg: 'error');
//}
//
////logout/todo
//},
//child: Text('Log Out Google'),
//splashColor: Colors.transparent,
//color: Colors.pink[600],
//highlightColor: Colors.pinkAccent,
//shape: RoundedRectangleBorder(
//borderRadius: BorderRadius.circular(40),
//),
//padding: EdgeInsets.fromLTRB(50, 20, 50, 20),
//),
//),
//],
//),
