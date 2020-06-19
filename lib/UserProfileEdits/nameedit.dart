import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileNameEdit extends StatefulWidget {
  @override
  _ProfileNameEditState createState() => _ProfileNameEditState();
}

class _ProfileNameEditState extends State<ProfileNameEdit> {
  String changedName = '';
  String myUserId;
  Database database = Database();
  TextEditingController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  getUserId() async {
    await SharedPrefs.getUserIdSharedPreference().then((value) {
      setState(() {
        myUserId = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.grey[800],
        ),
      ),
      backgroundColor: Colors.pink[50],
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: Text(
                      'Edit My Name',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    controller: controller,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter a name';
                      } else if (value.length < 3) {
                        return 'Your name is really short!';
                      } else if (value.length > 15) {
                        return 'Your name is too long!';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (val) {
                      setState(() {
                        changedName = val;
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
                      hintText: 'Edit Name',
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Builder(builder: (context) {
                        return FlatButton(
                          onPressed: () {
                            print(changedName);
                            if (changedName.length < 3 ||
                                changedName.trim() == '') {
                              FocusScope.of(context).unfocus();
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Name is too small'),
                                duration: Duration(seconds: 2),
                              ));
                            } else {
                              database
                                  .updateProfileName(myUserId, changedName)
                                  .then((val) {
                                FocusScope.of(context).unfocus();
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Name Update Successfully'),
                                  duration: Duration(seconds: 2),
                                ));
                              });
                            }
                          },
                          child: Text('Update Name'),
                          splashColor: Colors.transparent,
                          color: Colors.pink[600],
                          highlightColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                        );
                      }),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
