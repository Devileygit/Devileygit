import 'package:deviley_production/FirstLoginDetails/locationauto.dart';
import 'package:deviley_production/FirstLoginDetails/locationmanual.dart';
import 'package:flutter/material.dart';

class LocationDetails extends StatefulWidget {
  final String name;
  final String age;
  final String gender;
  final String marital;
  final String orientation;
  final List<String> addictionList;

  const LocationDetails(
      {Key key,
      this.name,
      this.age,
      this.gender,
      this.marital,
      this.orientation,
      this.addictionList})
      : super(key: key);

  @override
  _LocationDetailsState createState() => _LocationDetailsState();
}

class _LocationDetailsState extends State<LocationDetails> {
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
                    'My Location',
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LocationAutoDetails(
                                            name: widget.name,
                                            age: widget.age,
                                            gender: widget.gender,
                                            marital: widget.marital,
                                            orientation: widget.orientation,
                                            addictionList: widget.addictionList,
                                          )));
                            },
                            child: Text('I Am Now At'),
                            splashColor: Colors.transparent,
                            color: Colors.pink[600],
                            highlightColor: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                          child: Text(
                            'Press It To Detect Location Automatically',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            child: Text(
                              'No Thanks, I will Select',
                              style: TextStyle(
                                  color: Colors.pink[600],
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LocationManualDetails(
                                            name: widget.name,
                                            age: widget.age,
                                            gender: widget.gender,
                                            marital: widget.marital,
                                            orientation: widget.orientation,
                                            addictionList: widget.addictionList,
                                          )));
                            },
                          ),
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: 150,
              )
            ],
          ),
        ),
      ),
    );
  }
}
