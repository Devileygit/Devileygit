import 'package:deviley_production/FirstLoginDetails/location.dart';
import 'package:flutter/material.dart';

class AddictionDetails extends StatefulWidget {
  final String name;
  final String age;
  final String gender;
  final String marital;
  final String orientation;

  const AddictionDetails(
      {Key key,
      this.name,
      this.age,
      this.gender,
      this.marital,
      this.orientation})
      : super(key: key);

  @override
  _AddictionDetailsState createState() => _AddictionDetailsState();
}

class _AddictionDetailsState extends State<AddictionDetails> {
  List<String> addictionList;

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
      addictionList = ["No Addiction!!"];
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                    'My Addictions',
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
                    child: FlatButton(
                      onPressed: () {
                        getItems();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LocationDetails(
                                      name: widget.name,
                                      age: widget.age,
                                      gender: widget.gender,
                                      marital: widget.marital,
                                      orientation: widget.orientation,
                                      addictionList: addictionList,
                                    )));
                      },
                      child: Text('Next'),
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
