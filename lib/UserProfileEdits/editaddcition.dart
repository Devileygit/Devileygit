import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:flutter/material.dart';

class ProfileAddictionEdit extends StatefulWidget {
  @override
  _ProfileAddictionEditState createState() => _ProfileAddictionEditState();
}

class _ProfileAddictionEditState extends State<ProfileAddictionEdit> {

  List<String> addictionList;
  Database database = Database();
  String myUserId;

  getUserId() async{
    await SharedPrefs.getUserIdSharedPreference().then((value){
      setState(() {
        myUserId=value;
      });
    });
  }

  Map<String, bool> addictions = {
    "Smoking": false,
    "Drinking": false,
    "Soft Drugs (Like Marijuana)": false,
    "Hard Drugs (Like Cocaine)": false
  };

  void getItems() {
    addictionList.clear();
    addictions.forEach((key, value) {
      if (value == true) {
        addictionList.add(key);
      }
    });
    if (addictionList.length == 0) {
      addictionList=["No Addiction!!"];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    addictionList = ["No Addiction!!"];
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
                    'Edit My Addictions',
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
                      children: addictions.keys.map((String key) {
                        return CheckboxListTile(
                          title: Text(key),
                          value: addictions[key],
                          onChanged: (bool val) {
                            setState(() {
                              addictions[key] = val;
                            });
                          },
                        );
                      }).toList(),
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
                            getItems();
                            database.updateProfileAddiction(myUserId, addictionList).then((v){
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Addictions Updated Successfully'),
                                duration: Duration(seconds: 2),
                              ));
                            });
                          },
                          child: Text('Update Addictions'),
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
