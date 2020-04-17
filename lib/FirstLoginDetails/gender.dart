import 'package:deviley_production/FirstLoginDetails/maritalstatus.dart';
import 'package:flutter/material.dart';

class GenderDetails extends StatefulWidget {
  final String name;
  final String age;

  const GenderDetails({Key key, this.name, this.age}) : super(key: key);

  @override
  _GenderDetailsState createState() => _GenderDetailsState();
}

class _GenderDetailsState extends State<GenderDetails> {
  String gender = 'Female';
  List<String> genders = ['Female', 'Male', 'Others'];

  List<Widget> genderRadioList() {
    List<Widget> widgets = [];
    for (int i = 0; i < genders.length; i++) {
      widgets.add(
        RadioListTile(
          value: i,
          groupValue: genders.indexOf(gender),
          title: Text(genders[i]),
          onChanged: (val) {
            setState(() {
              gender = genders[val];
            });
          },
          selected: gender == genders[i],
        ),
      );
    }
    return widgets;
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
                    'I Am',
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
                      children: genderRadioList(),
                    ),
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
                                builder: (context) => MaritalDetails(
                                      name: widget.name,
                                      age: widget.age,
                                      gender: gender,
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
