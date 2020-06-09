import 'dart:io';

import 'package:deviley_production/services/firestoredataupload.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureDetails extends StatefulWidget {
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

  const ProfilePictureDetails(
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
      this.about})
      : super(key: key);

  @override
  _ProfilePictureDetailsState createState() => _ProfilePictureDetailsState();
}

class _ProfilePictureDetailsState extends State<ProfilePictureDetails> {
  File _imageFile;

  getImage(ImageSource source) async {
    File image = await ImagePicker.pickImage(source: source,imageQuality: 90);
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          maxHeight: 400,
          maxWidth: 400,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.pink[50],
            toolbarTitle: "Resize Image",
            toolbarWidgetColor: Colors.pink[600],
            backgroundColor: Colors.pink[50],
            activeControlsWidgetColor: Colors.pink[600],
            activeWidgetColor: Colors.pink[600],
          ));

      setState(() {
        _imageFile = cropped;
      });
    }
  }

  Widget imageBuild() {
    return Container(
      height: 350,
      width: 210,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.purple, width: 2),
          borderRadius: BorderRadius.circular(40),
          image: DecorationImage(
              image: FileImage(_imageFile),
              fit: BoxFit.cover,
              alignment: Alignment.center)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pink[600]),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'My Profile Picture',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                  height: 210,
                  width: 210,
                  child: Center(
                    child: InkWell(
                      child: _imageFile == null
                          ? Placeholder(
                              fallbackWidth: 210,
                              fallbackHeight: 210,
                            )
                          : imageBuild(),
                      onTap: () {
                        print('tapped');
                        getImage(ImageSource.camera);
                      },
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateUserProfile(
                                      name: widget.name,
                                      age: widget.age,
                                      gender: widget.gender,
                                      marital: widget.marital,
                                      orientation: widget.orientation,
                                      addictionList: widget.addictionList,
                                      cityName: widget.cityName,
                                      countryName: widget.countryName,
                                      cityLatitude: widget.cityLatitude,
                                      cityLongitude: widget.cityLongitude,
                                      imageFile: _imageFile,
                                  about: widget.about,
                                    )));
                      },
                      child: Text('Create My Account'),
                      splashColor: Colors.transparent,
                      color: Colors.pink[600],
                      highlightColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
