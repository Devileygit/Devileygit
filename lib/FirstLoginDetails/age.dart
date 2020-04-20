import 'package:deviley_production/FirstLoginDetails/gender.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AgeDetails extends StatefulWidget {
  final String name;

  const AgeDetails({Key key, this.name}) : super(key: key);

  @override
  _AgeDetailsState createState() => _AgeDetailsState();
}

class _AgeDetailsState extends State<AgeDetails> {
  String age = 'Age';

  Future datePick() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      final date2 = DateTime.now();
      var difference = date2.difference(picked).inDays;
      var years = (difference / 365).floor();
      var months = ((difference % 365) / 30).floor();
      final newDate =
          years.toString() + ' years and ' + months.toString() + ' months';
      setState(() {
        age = newDate;
      });
    }
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
                    'My Age',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              age,
                              style: TextStyle(fontSize: 15),
                            )),
                          ),
                          IconButton(
                            icon: FaIcon(FontAwesomeIcons.calendarAlt),
                            onPressed: datePick,
                            color: Colors.pink[600],
                          ),
                        ]),
                  )),
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
                                builder: (context) => GenderDetails(
                                      name: widget.name,
                                      age: age,
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
