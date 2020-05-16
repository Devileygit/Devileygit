import 'package:deviley_production/fadeinAnimation.dart';
import 'package:deviley_production/redirect.dart';
import 'package:deviley_production/register.dart';
import 'package:deviley_production/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService _auth = AuthService();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ClipPath(
                    clipper: Clipper(),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.deepPurple[600],
                                Colors.deepPurpleAccent
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          child: CustomPaint(
                            painter: Pattern(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FadeIn(
                    3.0,
                    Container(
                      height: 300,
                      child: Center(
                        child: Container(
                          height: 150,
                          width: 150,
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, boxShadow: [
                            BoxShadow(
                                color: Colors.deepPurple[600],
                                blurRadius: 4,
                                spreadRadius: 4),
                          ]),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('images/3.0.png'),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              FadeIn2(
                4,
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                color: Colors.purple[600], width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide:
                                BorderSide(color: Colors.pink[600], width: 2)),
                        labelText: 'Username',
                        prefixIcon: Icon(FontAwesomeIcons.solidUserCircle),
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                  ),
                ),
              ),
              FadeIn2(
                4,
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Container(
                    child: TextField(
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide: BorderSide(
                                color: Colors.purple[600], width: 2)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                            borderSide:
                                BorderSide(color: Colors.pink[600], width: 2)),
                        labelText: 'Password',
                        prefixIcon: Icon(FontAwesomeIcons.lock),
                      ),
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                  ),
                ),
              ),
              FadeIn2(
                4,
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerRight,
                        child: FlatButton(
                          onPressed: () {
                            //todo, forgot pass
                          },
                          child: Text('Forgot Password?'),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.pink[50],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FadeIn2(
                4,
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: Center(
                    child: FlatButton(
                      onPressed: () async {
                        dynamic result = await _auth
                            .signInWithEmailIdAndPassword(email, password);
                        if (result == null) {
                          Fluttertoast.showToast(msg: 'Wrong');
                        } else {
                          Fluttertoast.showToast(msg: 'Success');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Redirect()));
                        }

                        //login/todo
                      },
                      child: Text('Log In'),
                      splashColor: Colors.transparent,
                      color: Colors.pink[600],
                      highlightColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                    ),
                  ),
                ),
              ),
              FadeIn2(
                4,
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 15.0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Divider(
                            thickness: 1,
                            color: Colors.purple[600],
                          ),
                        ),
                      ),
                      Text('Or Login With'),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child: Divider(
                            thickness: 1,
                            color: Colors.purple[600],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              FadeIn2(
                5,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: IconButton(
                          onPressed: () async {
                            dynamic result = await _auth.signInWithGoogle();
                            if (result == null) {
                              Fluttertoast.showToast(msg: 'Wrong');
                            } else {
                              Fluttertoast.showToast(msg: 'Success');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Redirect()));
                            }

                            //login/todo
                          },
                          iconSize: 25.0,
                          splashColor: Colors.transparent,
                          color: Colors.pink[600],
                          icon: FaIcon(FontAwesomeIcons.google)),
                    ),
                    Center(
                      child: IconButton(
                          onPressed: () {},
                          iconSize: 25.0,
                          splashColor: Colors.transparent,
                          color: Colors.pink[600],
                          icon: FaIcon(FontAwesomeIcons.facebook)),
                    ),
                  ],
                ),
              ),
              FadeIn2(
                  5.5,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?  "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.pink[600]),
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, 3 * size.height / 4);
    path.quadraticBezierTo(
        size.width / 4, 3 * size.height / 4, size.width / 2, size.height / 2);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height / 4, size.width, size.height / 4);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Pattern extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint

    Paint paint1 = Paint()
      ..color = Color.fromRGBO(171, 71, 188, 0.15); //Colors.Purple[400];
    Paint paint2 = Paint()
      ..color = Color.fromRGBO(186, 104, 200, 0.15); //Colors.Purple[300];
    Paint paint3 = Paint()
      ..color = Color.fromRGBO(206, 147, 216, 0.15); //Colors.Purple[200];
    Paint paint4 = Paint()
      ..color = Color.fromRGBO(225, 190, 231, 0.15); //Colors.Purple[100];

    //first row
    canvas.drawCircle(Offset(0, 0), 30, paint1);
    canvas.drawCircle(Offset(0, 0), 20, paint2);
    canvas.drawCircle(Offset(60, 0), 30, paint1);
    canvas.drawCircle(Offset(60, 0), 20, paint3);
    canvas.drawCircle(Offset(120, 0), 30, paint1);
    canvas.drawCircle(Offset(120, 0), 20, paint4);
    canvas.drawCircle(Offset(180, 0), 30, paint2);
    canvas.drawCircle(Offset(180, 0), 20, paint1);
    canvas.drawCircle(Offset(240, 0), 30, paint2);
    canvas.drawCircle(Offset(240, 0), 20, paint3);
    canvas.drawCircle(Offset(300, 0), 30, paint2);
    canvas.drawCircle(Offset(300, 0), 20, paint4);
    canvas.drawCircle(Offset(360, 0), 30, paint3);
    canvas.drawCircle(Offset(360, 0), 20, paint2);
    canvas.drawCircle(Offset(420, 0), 30, paint3);
    canvas.drawCircle(Offset(420, 0), 20, paint1);
    canvas.drawCircle(Offset(480, 0), 30, paint3);
    canvas.drawCircle(Offset(480, 0), 20, paint4);
    canvas.drawCircle(Offset(540, 0), 30, paint4);
    canvas.drawCircle(Offset(540, 0), 20, paint1);
    canvas.drawCircle(Offset(600, 0), 30, paint4);
    canvas.drawCircle(Offset(600, 0), 20, paint3);
    canvas.drawCircle(Offset(660, 0), 30, paint4);
    canvas.drawCircle(Offset(660, 0), 20, paint2);
    canvas.drawCircle(Offset(720, 0), 30, paint1);
    canvas.drawCircle(Offset(720, 0), 20, paint4);
    canvas.drawCircle(Offset(780, 0), 30, paint2);
    canvas.drawCircle(Offset(780, 0), 20, paint1);
    canvas.drawCircle(Offset(840, 0), 30, paint2);
    canvas.drawCircle(Offset(840, 0), 20, paint3);
    canvas.drawCircle(Offset(900, 0), 30, paint2);
    canvas.drawCircle(Offset(900, 0), 20, paint4);

    //second row
    canvas.drawCircle(Offset(30, 52), 30, paint2);
    canvas.drawCircle(Offset(30, 52), 20, paint4);

    canvas.drawCircle(Offset(90, 52), 30, paint1);
    canvas.drawCircle(Offset(90, 52), 20, paint3);

    canvas.drawCircle(Offset(150, 52), 30, paint1);
    canvas.drawCircle(Offset(150, 52), 20, paint4);

    canvas.drawCircle(Offset(210, 52), 30, paint3);
    canvas.drawCircle(Offset(210, 52), 20, paint4);

    canvas.drawCircle(Offset(270, 52), 30, paint2);
    canvas.drawCircle(Offset(270, 52), 20, paint1);

    canvas.drawCircle(Offset(330, 52), 30, paint1);
    canvas.drawCircle(Offset(330, 52), 20, paint4);

    canvas.drawCircle(Offset(390, 52), 30, paint2);
    canvas.drawCircle(Offset(390, 52), 20, paint1);

    canvas.drawCircle(Offset(450, 52), 30, paint1);
    canvas.drawCircle(Offset(450, 52), 20, paint2);

    canvas.drawCircle(Offset(510, 52), 30, paint3);
    canvas.drawCircle(Offset(510, 52), 20, paint4);

    canvas.drawCircle(Offset(570, 52), 30, paint4);
    canvas.drawCircle(Offset(570, 52), 20, paint1);

    canvas.drawCircle(Offset(630, 52), 30, paint4);
    canvas.drawCircle(Offset(630, 52), 20, paint1);

    canvas.drawCircle(Offset(690, 52), 30, paint3);
    canvas.drawCircle(Offset(690, 52), 20, paint2);

    canvas.drawCircle(Offset(750, 52), 30, paint3);
    canvas.drawCircle(Offset(750, 52), 20, paint2);

    canvas.drawCircle(Offset(810, 52), 30, paint3);
    canvas.drawCircle(Offset(810, 52), 20, paint1);

    canvas.drawCircle(Offset(870, 52), 30, paint3);
    canvas.drawCircle(Offset(870, 52), 20, paint4);

    canvas.drawCircle(Offset(930, 52), 30, paint4);
    canvas.drawCircle(Offset(930, 52), 20, paint1);

    canvas.drawCircle(Offset(990, 52), 30, paint1);
    canvas.drawCircle(Offset(990, 52), 20, paint3);

    //third row

    canvas.drawCircle(Offset(0, 104), 30, paint4);
    canvas.drawCircle(Offset(0, 104), 20, paint3);

    canvas.drawCircle(Offset(60, 104), 30, paint2);
    canvas.drawCircle(Offset(60, 104), 20, paint3);

    canvas.drawCircle(Offset(120, 104), 30, paint1);
    canvas.drawCircle(Offset(120, 104), 20, paint3);

    canvas.drawCircle(Offset(180, 104), 30, paint2);
    canvas.drawCircle(Offset(180, 104), 20, paint1);

    canvas.drawCircle(Offset(240, 104), 30, paint1);
    canvas.drawCircle(Offset(240, 104), 20, paint3);

    canvas.drawCircle(Offset(300, 104), 30, paint2);
    canvas.drawCircle(Offset(300, 104), 20, paint4);

    canvas.drawCircle(Offset(360, 104), 30, paint1);
    canvas.drawCircle(Offset(360, 104), 20, paint2);

    canvas.drawCircle(Offset(420, 104), 30, paint4);
    canvas.drawCircle(Offset(420, 104), 20, paint1);

    canvas.drawCircle(Offset(480, 104), 30, paint2);
    canvas.drawCircle(Offset(480, 104), 20, paint4);

    canvas.drawCircle(Offset(540, 104), 30, paint4);
    canvas.drawCircle(Offset(540, 104), 20, paint1);

    canvas.drawCircle(Offset(600, 104), 30, paint4);
    canvas.drawCircle(Offset(600, 104), 20, paint3);

    canvas.drawCircle(Offset(660, 104), 30, paint1);
    canvas.drawCircle(Offset(660, 104), 20, paint2);

    canvas.drawCircle(Offset(720, 104), 30, paint1);
    canvas.drawCircle(Offset(720, 104), 20, paint4);

    canvas.drawCircle(Offset(780, 104), 30, paint2);
    canvas.drawCircle(Offset(780, 104), 20, paint3);

    canvas.drawCircle(Offset(840, 104), 30, paint2);
    canvas.drawCircle(Offset(840, 104), 20, paint3);

    canvas.drawCircle(Offset(900, 104), 30, paint2);
    canvas.drawCircle(Offset(900, 104), 20, paint1);

    //fourth row

    canvas.drawCircle(Offset(30, 156), 30, paint3);
    canvas.drawCircle(Offset(30, 156), 20, paint4);

    canvas.drawCircle(Offset(90, 156), 30, paint4);
    canvas.drawCircle(Offset(90, 156), 20, paint3);

    canvas.drawCircle(Offset(150, 156), 30, paint2);
    canvas.drawCircle(Offset(150, 156), 20, paint4);

    canvas.drawCircle(Offset(210, 156), 30, paint3);
    canvas.drawCircle(Offset(210, 156), 20, paint4);

    canvas.drawCircle(Offset(270, 156), 30, paint2);
    canvas.drawCircle(Offset(270, 156), 20, paint1);

    canvas.drawCircle(Offset(330, 156), 30, paint1);
    canvas.drawCircle(Offset(330, 156), 20, paint4);

    canvas.drawCircle(Offset(390, 156), 30, paint3);
    canvas.drawCircle(Offset(390, 156), 20, paint2);

    canvas.drawCircle(Offset(450, 156), 30, paint1);
    canvas.drawCircle(Offset(450, 156), 20, paint2);

    canvas.drawCircle(Offset(510, 156), 30, paint3);
    canvas.drawCircle(Offset(510, 156), 20, paint2);

    canvas.drawCircle(Offset(570, 156), 30, paint2);
    canvas.drawCircle(Offset(570, 156), 20, paint1);

    canvas.drawCircle(Offset(630, 156), 30, paint4);
    canvas.drawCircle(Offset(630, 156), 20, paint2);

    canvas.drawCircle(Offset(690, 156), 30, paint3);
    canvas.drawCircle(Offset(690, 156), 20, paint2);

    canvas.drawCircle(Offset(750, 156), 30, paint3);
    canvas.drawCircle(Offset(750, 156), 20, paint1);

    canvas.drawCircle(Offset(810, 156), 30, paint3);
    canvas.drawCircle(Offset(810, 156), 20, paint1);

    canvas.drawCircle(Offset(870, 156), 30, paint1);
    canvas.drawCircle(Offset(870, 156), 20, paint4);

    canvas.drawCircle(Offset(930, 156), 30, paint4);
    canvas.drawCircle(Offset(930, 156), 20, paint1);

    canvas.drawCircle(Offset(990, 156), 30, paint1);
    canvas.drawCircle(Offset(990, 156), 20, paint3);

    //fifth row

    canvas.drawCircle(Offset(0, 208), 30, paint1);
    canvas.drawCircle(Offset(0, 208), 20, paint3);

    canvas.drawCircle(Offset(60, 208), 30, paint1);
    canvas.drawCircle(Offset(60, 208), 20, paint3);

    canvas.drawCircle(Offset(120, 208), 30, paint4);
    canvas.drawCircle(Offset(120, 208), 20, paint3);

    canvas.drawCircle(Offset(180, 208), 30, paint2);
    canvas.drawCircle(Offset(180, 208), 20, paint3);

    canvas.drawCircle(Offset(240, 208), 30, paint1);
    canvas.drawCircle(Offset(240, 208), 20, paint3);

    canvas.drawCircle(Offset(300, 208), 30, paint2);
    canvas.drawCircle(Offset(300, 208), 20, paint4);

    canvas.drawCircle(Offset(360, 208), 30, paint1);
    canvas.drawCircle(Offset(360, 208), 20, paint4);

    canvas.drawCircle(Offset(420, 208), 30, paint4);
    canvas.drawCircle(Offset(420, 208), 20, paint1);

    canvas.drawCircle(Offset(480, 208), 30, paint3);
    canvas.drawCircle(Offset(480, 208), 20, paint4);

    canvas.drawCircle(Offset(540, 208), 30, paint4);
    canvas.drawCircle(Offset(540, 208), 20, paint1);

    canvas.drawCircle(Offset(600, 208), 30, paint4);
    canvas.drawCircle(Offset(600, 208), 20, paint1);

    canvas.drawCircle(Offset(660, 208), 30, paint1);
    canvas.drawCircle(Offset(660, 208), 20, paint2);

    canvas.drawCircle(Offset(720, 208), 30, paint1);
    canvas.drawCircle(Offset(720, 208), 20, paint4);

    canvas.drawCircle(Offset(780, 208), 30, paint2);
    canvas.drawCircle(Offset(780, 208), 20, paint3);

    canvas.drawCircle(Offset(840, 208), 30, paint2);
    canvas.drawCircle(Offset(840, 208), 20, paint3);

    canvas.drawCircle(Offset(900, 208), 30, paint2);
    canvas.drawCircle(Offset(900, 208), 20, paint1);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
