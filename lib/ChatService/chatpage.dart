import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final chatRoomId;

  const ChatPage({Key key, @required this.chatRoomId}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot> chats;
  TextEditingController chatEditingController;

  addChatFunc() {}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    chatEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(),
    );
  }
}

class Messages extends StatelessWidget {
  final String message;
  final bool sendByMe;

  const Messages({Key key, @required this.message, @required this.sendByMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 15, bottom: 15, right: 20, left: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
            color: sendByMe ? Colors.pink[300] : Colors.deepPurple[300]),
        child: Text(
          message,
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
