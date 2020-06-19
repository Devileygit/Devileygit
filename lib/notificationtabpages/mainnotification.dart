import 'package:deviley_production/peerprofile.dart';
import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNotificationTab extends StatefulWidget {
  @override
  _MainNotificationTabState createState() => _MainNotificationTabState();
}

class _MainNotificationTabState extends State<MainNotificationTab> {
  Stream notificationData;
  Stream userDoc;
  int type;
  int giftIndex;
  String myUserId;
  Database database = Database();
  List<AssetImage> gifts = [];

  getUserId() async {
    await SharedPrefs.getUserIdSharedPreference().then((value) {
      setState(() {
        myUserId = value;
      });
    });
  }

  Widget notificationBuilder() {
    return StreamBuilder(
        stream: notificationData,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            return ListView.builder(
                cacheExtent: 500 * (snapshots.data.documents.length).toDouble(),
                physics: BouncingScrollPhysics(),
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  userDoc = database.getPersonalDataDocuments(
                      snapshots.data.documents[index]['peerId']);
                  type = snapshots.data.documents[index]['type'];
                  if (type == 1) {
                    giftIndex = snapshots.data.documents[index]['giftIndex'];
                  }
                  if (type == 0) {
                    return notificationTypeWidget(userDoc, [type]);
                  } else {
                    return notificationTypeWidget(userDoc, [type, giftIndex]);
                  }
                });
          } else {
            return Container();
          }
        });
  }

  Widget notificationTypeWidget(Stream documentSnapshot, List list) {
    //userDoc=
    //print(documentSnapshot.data.toString());
    return StreamBuilder(
        stream: documentSnapshot,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            var userDocDesignData = snapshots.data.documents;
            //type 0 means favourite type notifications
            if (list[0] == 0) {
              return Padding(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Container(
                    child: favouriteDesign(userDocDesignData[0]),
                  ));
            } else if (list[0] == 1) {
              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Container(
                  child: giftDesign(userDocDesignData[0], list[1]),
                ),
              );
              //giftdesign todo
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        });
  }

  Widget favouriteDesign(var userDoc) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PeerProfile(
                      snapShot: userDoc,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.yellow[700], width: 3)),
        child: Column(
          children: <Widget>[
            Center(
              child: Text(
                userDoc['name'] + " Marked You as Favourite",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundColor: Colors.yellow[700],
                        radius: 40,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userDoc['profilePhoto']),
                          radius: 37,
                        )),
                    FaIcon(
                      FontAwesomeIcons.solidStar,
                      size: 20,
                      color: Colors.yellow[700],
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                    child: Text(
                  "Hey!! " +
                      userDoc['name'] +
                      " have added you in Favourite List!! Check out profile and send gifts or start conversation.",
                  style: TextStyle(fontSize: 15),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget giftDesign(var userDoc, int giftIndex) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PeerProfile(
                      snapShot: userDoc,
                    )));
      },
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.blue[600], width: 3)),
        child: Column(
          children: <Widget>[
            Image(
              image: gifts[giftIndex],
              width: 150,
              height: 150,
            ),
            Center(
              child: Text(
                userDoc['name'] + " Sent You A Gift",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Stack(
                  alignment: Alignment.bottomRight,
                  children: <Widget>[
                    CircleAvatar(
                        backgroundColor: Colors.blue[600],
                        radius: 40,
                        child: CircleAvatar(
                          backgroundImage:
                              NetworkImage(userDoc['profilePhoto']),
                          radius: 37,
                        )),
                    FaIcon(
                      FontAwesomeIcons.gift,
                      size: 20,
                      color: Colors.blue[600],
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Flexible(
                    child: Text(
                  "Hey!! " +
                      userDoc['name'] +
                      " have added you in Favourite List!! Check out profile and send gifts or start conversation.",
                  style: TextStyle(fontSize: 15),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId().then((v) {
      database.getNotificationsData(myUserId).then((v) {
        setState(() {
          notificationData = v;
        });
      });
    });
    for (int j = 1; j <= 10; j++) {
      gifts.add(AssetImage('gift/$j.png'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: notificationBuilder(),
      ),
    );
  }
}
