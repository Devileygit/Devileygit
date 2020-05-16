import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/home.dart';
import 'package:deviley_production/redirect.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateUserProfile extends StatefulWidget {
  final String name;
  final String age;
  final String gender;
  final String marital;
  final String orientation;
  final List<String> addictionList;
  final String cityName;
  final String countryName;
  final double cityLatitude;
  final double cityLongitude;
  final String about;
  final File imageFile;

  const CreateUserProfile(
      {Key key,
      this.name,
      this.age,
      this.gender,
      this.marital,
      this.orientation,
      this.addictionList,
      this.cityName,
      this.countryName,
      this.cityLatitude,
      this.cityLongitude,
      this.about,
      this.imageFile})
      : super(key: key);

  @override
  _CreateUserProfileState createState() => _CreateUserProfileState();
}

class _CreateUserProfileState extends State<CreateUserProfile> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://devileyproduction.appspot.com');
  StorageUploadTask _uploadTask;
  StorageReference _storageReference;
  String _complete;

  Future imageUpload(FirebaseUser user) async {
    String uploadPath =
        'images/${user.email}/profile/profile_photo_+${user.uid}+${DateTime.now()}';
    setState(() {
      try {
        _storageReference = _storage.ref().child(uploadPath);
        _uploadTask = _storageReference.putFile(widget.imageFile);
        _uploadTask.onComplete.then((value) {
          if (value.error == null) {
            createProfile(user).then((value) {
              setState(() {
                _complete = 'Finish';
              });
            });
          }
        });
      } catch (e) {
        print('error on upload image');
      }
    });
  }

  Future createProfile(FirebaseUser user) async {
    final String profilePhotoUrl = await _storageReference.getDownloadURL();
    QuerySnapshot query = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: user.uid)
        .getDocuments();
    List<DocumentSnapshot> documents = query.documents;
    if (documents.length == 0) {
      Firestore.instance.collection('users').document(user.uid).setData({
        'id': user.uid,
        'age': widget.age,
        'name': widget.name,
        'profilePhoto': profilePhotoUrl,
        'gender': widget.gender,
        'marital': widget.marital,
        'orientation': widget.orientation,
        'addictionList': widget.addictionList,
        'cityName': widget.cityName,
        'countryName': widget.countryName,
        'cityLatitude': widget.cityLatitude,
        'cityLongitude': widget.cityLongitude,
        'about': widget.about,
        'emailId': user.email
      });

      SharedPrefs.saveUserLoggedInSharedPreference(true);
      SharedPrefs.saveUserIdSharedPreference(user.uid);
      SharedPrefs.saveUserEmailIdSharedPreference(user.email);

      setState(() {
        _complete = 'Finish';
      });
    } else {
      return null;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: Container(
          child: _complete == null
              ? FutureBuilder(
                  future: imageUpload(user),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      return Container();
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                )
              : Redirect()),
    );
  }
}

//body: Container(
//child: _complete == null
//? FutureBuilder(
//future: imageUpload(user),
//builder:
//(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//if (snapshot.connectionState == ConnectionState.active) {
//return Container();
//} else {
//return Center(
//child: CircularProgressIndicator(
//valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
//));
//}
//},
//)
//: Home()),

//imageUpload(user);
//if(_complete==null) {
//if(_uploadTask!=null) {
//return Scaffold(
//body: StreamBuilder<StorageTaskEvent>(
//stream: _uploadTask.events,
//builder: (context, snapshot){
//var event = snapshot?.data?.snapshot;
//
//double progressPercentage = event!=null?event.bytesTransferred/event.totalByteCount:0;
//return Column(
//mainAxisSize: MainAxisSize.max,
//mainAxisAlignment: MainAxisAlignment.center,
//crossAxisAlignment: CrossAxisAlignment.center,
//children: <Widget>[
//CircularProgressIndicator(value: progressPercentage,valueColor: AlwaysStoppedAnimation(Colors.deepPurple),)
//],
//);
//},
//),
//);
//}
//else{
//return Container();
//}
//}
//else{
//return Home();
//}
