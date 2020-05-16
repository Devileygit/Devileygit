import 'package:deviley_production/ChatService/chatpage.dart';
import 'package:flutter/material.dart';


class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      color: Colors.green,
      child: Center(
        child: FlatButton(
          child: Text('chat'),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatPage()));
          },
        ),
      ),
    );
  }
}
