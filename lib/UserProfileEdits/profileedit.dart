import 'dart:io';
import 'package:deviley_production/UserProfileEdits/aboutedit.dart';
import 'package:deviley_production/UserProfileEdits/editaddcition.dart';
import 'package:deviley_production/UserProfileEdits/editlocation.dart';
import 'package:deviley_production/UserProfileEdits/editmarital.dart';
import 'package:deviley_production/UserProfileEdits/editsexualorientation.dart';
import 'package:deviley_production/UserProfileEdits/nameedit.dart';
import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfileEdit extends StatefulWidget {

  @override
  _ProfileEditState createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {

  String name;
  String addictionString='';
  File _imageFile;
  String myUid;
  Database database = Database();
  Stream myDetails;
  var userDoc;

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
            toolbarTitle: "Set Thumbnail",
            toolbarWidgetColor: Colors.pink[600],
            backgroundColor: Colors.pink[50],
            activeControlsWidgetColor: Colors.pink[600],
            activeWidgetColor: Colors.pink[600],
          ));

      setState(() {
        _imageFile = cropped;
        String newPath=path.join(path.dirname(image.path),'shit.jpg');
        image.renameSync(newPath);
      });
    }
  }

  Widget imageBuild() {
    return Container(
      height: MediaQuery.of(context).size.width/4,
      width: MediaQuery.of(context).size.width/4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              image: FileImage(_imageFile),
              fit: BoxFit.cover,
              alignment: Alignment.center)),
    );
  }

  getUserIdAndUserData() async {
    await SharedPrefs.getUserIdSharedPreference().then((value) {
      setState(() {
        myUid=value;
        database.getPersonalData(myUid).then((val){
          setState(() {
            myDetails=val;
          });
        });
      });
    });
  }


  Widget editDetails( String title, String initValue ){
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.pink[50]],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
      padding: EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text(title,style: TextStyle(fontSize: 13,color: Colors.grey[800]),),
                SizedBox(height: 15,),
                Text(initValue,style: TextStyle(fontSize: 16,color: Colors.grey[900]),)
              ],
            ),
          ),
          FaIcon(FontAwesomeIcons.solidEdit,size: 17,color: Colors.pink[600],)
        ],
      )
    );
  }

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserIdAndUserData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: StreamBuilder(
        stream: myDetails,
        builder: (context, snapshot) {
      if(snapshot.hasData) {
        userDoc = snapshot.data.data;
        addictionString='';
        for (int i = 0; i < userDoc['addictionList'].length; i++) {
          if (i != userDoc['addictionList'].length - 1) {
            addictionString =
                addictionString + userDoc['addictionList'][i] + ', ';
          } else {
            addictionString = addictionString + userDoc['addictionList'][i];
          }
        }
        return Container(
            child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                  NetworkImage(userDoc['profilePhoto']),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center)),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              alignment: Alignment.bottomRight,
                              child: IconButton(
                                icon: FaIcon(
                                  FontAwesomeIcons.pencilAlt, size: 30,
                                  color: Colors.pink[600],),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 75,
                          alignment: Alignment.centerLeft,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(0, 0, 0, 0.85),
                                    Colors.transparent
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter
                              )
                          ),
                          child: SafeArea(
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back, color: Colors.grey[50],),
                              onPressed: () {
                                Navigator.pop(context,
                                    ProfileEdit());
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ProfileNameEdit()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: <Widget>[
                            editDetails('Name', userDoc['name']),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileLocationEdit()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: <Widget>[
                            editDetails('Location', userDoc['cityName'])
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileAboutEdit()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: <Widget>[
                            editDetails('About',userDoc['about'])
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileMaritalEdit()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: <Widget>[
                            editDetails('Relationship Status',
                                userDoc['marital'])
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileAddictionEdit()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: <Widget>[
                            editDetails('Addictions', addictionString)
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileOrientationEdit()));
                      },
                      child: Card(
                        margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        child: Column(
                          children: <Widget>[
                            editDetails('Attraction Towards',
                                userDoc['orientation'])
                          ],
                        ),
                      ),
                    ),

                    Card(
                      margin: EdgeInsets.only(
                          top: 15, left: 10, right: 10),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                                colors: [Colors.pinkAccent, Colors.pink[50]]
                            )
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Photo Album', style: TextStyle(
                                fontSize: 13, color: Colors.grey[800]),),
                            SizedBox(height: 15,),
                            for(int j = 0; j < 3; j++)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  for(int i = 0; i < 3; i++)
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: InkWell(
                                        child: _imageFile == null ? Placeholder(
                                          fallbackWidth: MediaQuery
                                              .of(context)
                                              .size
                                              .width / 4,
                                          fallbackHeight: MediaQuery
                                              .of(context)
                                              .size
                                              .width / 4,)
                                            :
                                        imageBuild(),
                                        onTap: () {
                                          getImage(ImageSource.camera);
                                        },
                                      ),
                                    )
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),

                    Card(
                      margin: EdgeInsets.only(
                          top: 15, bottom: 15, left: 10, right: 10),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            gradient: LinearGradient(
                                colors: [Colors.pinkAccent, Colors.pink[50]]
                            )
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text('Private Photo Album', style: TextStyle(
                                    fontSize: 13, color: Colors.grey[800]),),
                                IconButton(
                                  icon: FaIcon(
                                    FontAwesomeIcons.infoCircle, size: 17,
                                    color: Colors.grey[800],),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 10,
                                            title: Center(child: Text(
                                                'Private Photo Album')),
                                            content: Text(
                                                'This iskjdijvvdvb hdfiuh iuwhefiu wf whfiwuh fuwhf wofnoiw nfoinf onwiofn iownfoirnwfiorwnof niorno finrionf'),
                                          );
                                        }
                                    );
                                  },
                                )
                              ],
                            ),

                            for(int j = 0; j < 3; j++)
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  for(int i = 0; i < 3; i++)
                                    Container(
                                      padding: EdgeInsets.only(top: 15),
                                      child: Placeholder(
                                        fallbackWidth: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 4,
                                        fallbackHeight: MediaQuery
                                            .of(context)
                                            .size
                                            .width / 4,),
                                    )
                                ],
                              ),
                          ],
                        ),
                      ),
                    )


                  ],
                )
            )
        );
      }
      else{
        return Container();
      }
        }
      ),
    );
  }
}

