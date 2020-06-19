import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Chat extends StatefulWidget {
  Chat({Key key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<DocumentSnapshot> chatUsers;
  Stream chatListDetails;
  Database database = Database();
  String myUid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserIdAndChatList();
  }

  getUserIdAndChatList() async {
    await SharedPrefs.getUserIdSharedPreference().then((value) {
      setState(() {
        myUid = value;
        database.getUserChatList(myUid).then((val) {
          setState(() {
            chatListDetails = val;
          });
        });
      });
    });
  }

  Widget chatList() {
    return StreamBuilder(
        stream: chatListDetails,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                physics: BouncingScrollPhysics(),
                cacheExtent: 500 * (snapshot.data.documents.length).toDouble(),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: chatListUser(snapshot.data.documents[index]),
                  );
                });
          } else {
            return Container();
          }
        });
  }

  Widget chatListUser(DocumentSnapshot documentSnapshot) {
    for (var i in documentSnapshot['users']) {
      if (i != myUid) {
        return FutureBuilder(
            future: database.getPersonalData(i.toString()),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                chatUsers = snapshot.data;
                return StreamBuilder(
                    stream: chatUsers,
                    builder: (context, snapshots) {
                      if (snapshots.hasData) {
                        var chatUserDoc = snapshots.data.data;
                        return Container(
                          height: 70,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  child: Stack(
                                alignment: Alignment.bottomRight,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        chatUserDoc['profilePhoto']),
                                    radius: 30,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.solidCircle,
                                    size: 15,
                                    color: Colors.green,
                                  )
                                ],
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      chatUserDoc['name'],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    Container(
                                        child: Text(
                                      'ekhane last message likhbohhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh',
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: TextStyle(color: Colors.grey[600]),
                                    ))
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('12:43 PM'),
                                  FaIcon(
                                    FontAwesomeIcons.solidCircle,
                                    size: 15,
                                    color: Colors.pink[600],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    });
              } else {
                return Container();
              }
            });
      }
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        title: Text(
          'Messages',
          style:
              TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.grey[800],
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: chatList(),
      ),
    );
  }
}
