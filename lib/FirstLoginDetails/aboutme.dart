import 'package:deviley_production/FirstLoginDetails/profilephoto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AboutDetails extends StatefulWidget {
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

  const AboutDetails(
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
      this.cityLongitude})
      : super(key: key);

  @override
  _AboutDetailsState createState() => _AboutDetailsState();
}

class _AboutDetailsState extends State<AboutDetails> {
  String about = '';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: Text(
                    'Details About Me',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 5,
                    cursorColor: Colors.pink[600],
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(250),
                    ],
                    validator: (value) {
                      if (value == null) {
                        return 'Please don\'t make it blank';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        about = val;
                      });
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide:
                              BorderSide(color: Colors.purple[600], width: 2)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          borderSide:
                              BorderSide(color: Colors.pink[600], width: 2)),
                      hintText: 'About Me',
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfilePictureDetails(
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
                                      about: about,
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
