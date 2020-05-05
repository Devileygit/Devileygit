import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/FirstLoginDetails/name.dart';
import 'package:deviley_production/services/via.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:async/async.dart';

import 'home.dart';

class Redirect extends StatefulWidget {
  @override
  _RedirectState createState() => _RedirectState();
}

class _RedirectState extends State<Redirect> with AutomaticKeepAliveClientMixin<Redirect> {

  @override
  bool get wantKeepAlive => true;

  Future queryCheck(FirebaseUser user) async {
    final AsyncMemoizer _asyncMemoizer = AsyncMemoizer();

    return _asyncMemoizer.runOnce(() async{
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
    });


  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: queryCheck(user),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print(user.email);
              if (snapshot.data == null) {
                print(snapshot.data);
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
          }),
    );




  }
}













