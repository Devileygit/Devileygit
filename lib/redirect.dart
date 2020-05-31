import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/FirstLoginDetails/name.dart';
import 'package:deviley_production/login.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Redirect extends StatefulWidget {
  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> {
  bool userLoggedIn;

  Future queryCheck(FirebaseUser user) async {
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: user.uid)
        .getDocuments();
    List<DocumentSnapshot> documents = query.documents;

    if (documents.length == 0) {
      return 1;
    } else {
      return null;
    }
  }

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
    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: Container(
          child: userLoggedIn == true
              ? Home()
              : (user != null
                  ? FutureBuilder<dynamic>(
                      future: queryCheck(user),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          print(user.email);
                          if (snapshot.data == null) {
                            print(snapshot.data);
                            SharedPrefs.saveUserLoggedInSharedPreference(true);
                            SharedPrefs.saveUserIdSharedPreference(user.uid);
                            SharedPrefs.saveUserEmailIdSharedPreference(
                                user.email);
                            return Home();
                          } else {
                            print(snapshot.data);
                            return NameDetails();
                          }
                        } else {
                          return Container(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      })
                  : Login())),
    );
  }
}
