import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/peerprofile.dart';
import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/design.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final chatRoomId;
  final snapShot;

  const ChatPage({Key key, @required this.chatRoomId, @required this.snapShot})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot> chats;
  TextEditingController chatEditingController;
  ScrollController scrollController = ScrollController();
  Database database = Database();
  String myUserId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatEditingController = TextEditingController();
    database.getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
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
  void dispose() {
    // TODO: implement dispose
    chatEditingController.dispose();
    super.dispose();
  }

  Widget chatMessages() {
    return StreamBuilder(
        stream: chats,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? Scrollbar(
                  child: ListView.builder(
                    controller: scrollController,
                    reverse: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      return Messages(
                        message: snapshot.data.documents[index].data['message'],
                        sendByMe: myUserId ==
                            snapshot.data.documents[index].data['sendBy'],
                        time: snapshot.data.documents[index].data['time']
                            .toString(),
                      );
                    },
                  ),
                )
              : Container();
        });
  }

  addChatFunc() {
    if (chatEditingController.text.trim().isNotEmpty) {
      Map<String, dynamic> chatData = {
        "sendBy": myUserId,
        "message": chatEditingController.text,
        "time": DateTime.now().millisecondsSinceEpoch
      };

      database.addChat(widget.chatRoomId, chatData);
      scrollController.animateTo(0,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
      setState(() {
        chatEditingController.text = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.ac_unit),
            onPressed: () {},
          )
        ],
        title: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Container(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PeerProfile(
                              snapShot: widget.snapShot,
                            )));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.snapShot['profilePhoto']),
                    radius: 18,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(widget.snapShot['name'].toString()),
                ],
              ),
            ),
          ),
        ),
      ),
      body: CustomPaint(
        willChange: false,
        painter: DesignPattern(),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(child: Expanded(child: chatMessages())),
              Container(
                padding: EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.pink[50],
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.solidSmile,
                        color: Colors.pink[600],
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(maxHeight: 150),
                        child: TextField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: chatEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 30, right: 30, top: 12, bottom: 10),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.pink[600], width: 2)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                borderSide: BorderSide(
                                    color: Colors.pink[600], width: 2)),
                            hintText: "Message..",
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.solidPaperPlane,
                        color: Colors.pink[600],
                      ),
                      onPressed: addChatFunc,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final String message;
  final bool sendByMe;
  final String time;

  const Messages(
      {Key key,
      @required this.message,
      @required this.sendByMe,
      @required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: sendByMe ? 0 : 20,
          right: sendByMe ? 20 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment:
            sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment:
            sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              margin: sendByMe
                  ? EdgeInsets.only(left: 60)
                  : EdgeInsets.only(right: 60),
              padding: EdgeInsets.only(top: 5, bottom: 5, right: 15, left: 15),
              decoration: BoxDecoration(
                  borderRadius: sendByMe
                      ? BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25))
                      : BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                  color: sendByMe ? Colors.pink[300] : Colors.deepPurple[300]),
              child: Text(
                message,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.grey[850],
                ),
              )),
          Text(
            DateFormat('jm')
                .format(DateTime.fromMillisecondsSinceEpoch(int.parse(time))),
            style: TextStyle(color: Colors.grey[500], fontSize: 12),
          ),
        ],
      ),
    );
  }
}
