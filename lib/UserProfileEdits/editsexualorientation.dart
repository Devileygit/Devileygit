import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:flutter/material.dart';

class ProfileOrientationEdit extends StatefulWidget {
  @override
  _ProfileOrientationEditState createState() => _ProfileOrientationEditState();
}

class _ProfileOrientationEditState extends State<ProfileOrientationEdit> {
  Database database = Database();
  String orientation = 'Male';
  List<String> orientations = [
    'Male',
    'Female',
    'Both Male and Female',
    'Others',
    'I Love All People'
  ];
  String myUserId;

  getUserId() async{
    await SharedPrefs.getUserIdSharedPreference().then((value){
      setState(() {
        myUserId=value;
      });
    });
  }

  List<Widget> orientationRadioList() {
    List<Widget> widgets = [];
    for (int i = 0; i < orientations.length; i++) {
      widgets.add(
        RadioListTile(
          value: i,
          groupValue: orientations.indexOf(orientation),
          title: Text(orientations[i]),
          onChanged: (val) {
            setState(() {
              orientation = orientations[val];
            });
          },
          selected: orientation == orientations[i],
        ),
      );
    }
    return widgets;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.pink[600]),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.pink[50],
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Center(
                  child: Text(
                    'Change Whom I Like',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      children: orientationRadioList(),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Builder(
                      builder: (context) {
                        return FlatButton(
                          onPressed: () {
                            database.updateProfileOrientation(myUserId, orientation).then((v){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Updated Attraction Successfully'),
                                duration: Duration(seconds: 2),
                              ));
                            });
                          },
                          child: Text('Update Attracted Towards'),
                          splashColor: Colors.transparent,
                          color: Colors.pink[600],
                          highlightColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                        );
                      }
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
