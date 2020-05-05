import 'package:deviley_production/home.dart';
import 'package:flutter/material.dart';
class Via extends StatefulWidget {
  final String user;

  const Via({Key key, this.user}) : super(key: key);
  @override
  _ViaState createState() => _ViaState();
}

class _ViaState extends State<Via> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(widget.user != null) {
      setState(() {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        Navigator.pop(context, MaterialPageRoute(builder: (context) => Via()));
      });

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
