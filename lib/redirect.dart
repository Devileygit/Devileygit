import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/FirstLoginDetails/name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home.dart';

class Redirect extends StatelessWidget {


  Future queryCheck(FirebaseUser user) async{
    QuerySnapshot query = await Firestore.instance.collection('users').where('id', isEqualTo: user.uid).getDocuments();
    List<DocumentSnapshot> documents = query.documents;
    if(documents.length==0)
      {
        return 1;
      }
    else{
      return null;
    }
  }



  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: FutureBuilder<dynamic>(
          future: queryCheck(user),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot ){
            if(snapshot.connectionState==ConnectionState.done) {
              if (snapshot.data == null) {
                return Home();
              }
              else {
                return NameDetails();
              }
            }
            else{
              return Container(
                child: Center(
                  child: CircularProgressIndicator()
                ),
              );
            }
          }
      ),
    );

  }
}

