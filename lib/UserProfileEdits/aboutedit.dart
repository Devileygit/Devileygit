import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileAboutEdit extends StatefulWidget {
  @override
  _ProfileAboutEditState createState() => _ProfileAboutEditState();
}

class _ProfileAboutEditState extends State<ProfileAboutEdit> {

  String editAbout='';
  Database database = Database();
  String myUserId;

  getUserId() async{
    await SharedPrefs.getUserIdSharedPreference().then((value){
      setState(() {
        myUserId=value;
      });
    });
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
                    'Edit Details About Me',
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
                        editAbout = val;
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
                      hintText: 'Edit About Me',
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Builder(
                      builder: (context) {
                        return FlatButton(
                          onPressed: () {
                            print(editAbout);
                            if(editAbout.trim()=='')
                            {
                              FocusScope.of(context).unfocus();
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('About Can\'t Be Empty'),
                                duration: Duration(seconds: 2),

                              ));
                            }
                            else{
                              database.updateProfileAbout(myUserId, editAbout)
                                  .then((val) {
                                FocusScope.of(context).unfocus();
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('About Updated Successfully'),
                                  duration: Duration(seconds: 2),
                                ));
                              });
                            }
                          },
                          child: Text('Update About'),
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
