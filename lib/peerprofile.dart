import 'package:deviley_production/ChatService/chatpage.dart';
import 'package:deviley_production/galleryservice/gallery.dart';
import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:flutter/material.dart';
import 'package:deviley_production/galleryservice/galleryitem.dart';
import 'package:flutter/scheduler.dart';

class PeerProfile extends StatefulWidget {
  final snapShot;

  const PeerProfile({Key key, this.snapShot}) : super(key: key);

  @override
  _PeerProfileState createState() => _PeerProfileState();
}

class _PeerProfileState extends State<PeerProfile> {
  Database database = Database();
  String myUserId;
  String name = '';
  String addictionString = '';
  ScrollController _scrollController = new ScrollController();
  ScrollController _scrollController2 = new ScrollController();
  List<AssetImage> gifts = [];

  Future<int> showGift() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: SimpleDialog(
              elevation: 4,
              backgroundColor: Colors.pink[50],
              title: Text('Gift'),
              children: <Widget>[
                for (var i = 0; i < gifts.length; i++)
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.of(context).pop(i);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width - 10,
                      child: ListTile(
                        leading: Image(image: gifts[i]),
                        title: Text('Gift $i'),
                        subtitle: Text('Something Sexy'),
                      ),
                    ),
                  )
              ],
            ),
          );
        });
  }

  getChatRoomId(String a, String b) {
    if (a.hashCode > b.hashCode) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createChatRoom() {
    List<String> users = [myUserId, widget.snapShot['id']];
    String chatRoomId = getChatRoomId(myUserId, widget.snapShot['id']);
    Map<String, dynamic> chatRoom = {"users": users, "chatRoomId": chatRoomId};

    database.addChatRoom(chatRoom, chatRoomId);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChatPage(
                  chatRoomId: chatRoomId,
              snapShot: widget.snapShot,
                )));
  }

  addFavourite(){
    database.addFavourite(myUserId, widget.snapShot['id']);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.snapShot['addictionList'].length; i++) {
      if (i != widget.snapShot['addictionList'].length - 1) {
        addictionString =
            addictionString + widget.snapShot['addictionList'][i] + ', ';
      } else {
        addictionString = addictionString + widget.snapShot['addictionList'][i];
      }
    }

    for (int j = 1; j <= 10; j++) {
      gifts.add(AssetImage('gift/$j.png'));
    }
    name = widget.snapShot['name'];
    getMyUserId();
  }

  getMyUserId() async {
    SharedPrefs.getUserIdSharedPreference().then((value) {
      setState(() {
        myUserId = value;
      });
    });
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GalleryPhotoViewWrapper(
          galleryItems: galleryItems,
          backgroundDecoration: BoxDecoration(
            color: Colors.deepPurple[100],
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.favorite),
              mini: true,
              //backgroundColor: Colors.pinkAccent,
              heroTag: 0,
              onPressed: addFavourite,
            ),
            SizedBox(
              height: 10,
            ),
            FloatingActionButton(
              child: Icon(Icons.message),
              heroTag: 1,
              //backgroundColor: Colors.pinkAccent,
              onPressed: createChatRoom,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        body: Container(
          color: Colors.pink[50],
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight:MediaQuery.of(context).size.width ,
                pinned: true,
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      //todo block,report
                      print('action pressed');
                    },
                    icon: Icon(Icons.more_vert),
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                      widget.snapShot['name'] + ', ' + widget.snapShot['age']),
                  centerTitle: true,
                  background: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    NetworkImage(widget.snapShot['profilePhoto']),
                                fit: BoxFit.cover,
                                alignment: Alignment.center)),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 100,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Color.fromRGBO(0, 0, 0, 0.85), Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color.fromRGBO(0, 0, 0, 0.85), Colors.transparent],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                          ),
                        ),
                      ),
                    ],
                  ),
                  collapseMode: CollapseMode.parallax,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 4,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: LinearGradient(
                                colors: [
                                  //Colors.pink[600],
                                  //Colors.pinkAccent
                                  Colors.pinkAccent,
                                  Colors.pink[50]
                                  //Color.fromRGBO(216, 27, 96,0.8),
                                  //Color.fromRGBO(103,58,183,0.8)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 5),
                                    child: descriptionWidget(context, 'Gender',
                                        widget.snapShot['gender']),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 5, 5),
                                    child: descriptionWidget(
                                        context,
                                        'Location',
                                        widget.snapShot['cityName']),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: descriptionWidget(
                                  context,
                                  'Relationship Status',
                                  widget.snapShot['marital']),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      elevation: 4,
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                        //todo, about
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: LinearGradient(
                                colors: [Colors.pinkAccent, Colors.pink[50]],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: descriptionWidget(
                                  context, 'About', widget.snapShot['about']),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    Card(
                      margin: EdgeInsets.all(0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                        //todo, about
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: LinearGradient(
                                colors: [Colors.pinkAccent, Colors.pink[50]],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: descriptionWidget(context, 'Attracted To',
                                  widget.snapShot['orientation']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: descriptionWidget(context, 'Addictions',
                                  addictionString.toString()),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                        //todo, about
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: LinearGradient(
                                colors: [Colors.pinkAccent, Colors.pink[50]],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text('Photos'),
                                  InkWell(
                                    child: Text('> more'),
                                    onTap: () {
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        _scrollController.animateTo(
                                            _scrollController
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                color: Colors.deepPurple[100],
                                child: SingleChildScrollView(
                                  controller: _scrollController,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[0],
                                        onTap: () {
                                          open(context, 0);
                                        },
                                      ),
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[1],
                                        onTap: () {
                                          open(context, 1);
                                        },
                                      ),
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[2],
                                        onTap: () {
                                          open(context, 2);
                                        },
                                      ),
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[3],
                                        onTap: () {
                                          open(context, 3);
                                        },
                                      ),
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[4],
                                        onTap: () {
                                          open(context, 4);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Builder(builder: (context) {
                      return Center(
                        child: Container(
                          child: InkWell(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'gift/icons/gift_icon_2.png',
                                  scale: 2.5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    ShaderMask(
                                      shaderCallback: (rect)=>
                                      LinearGradient(
                                        colors: [Colors.deepPurple[600],Colors.pink[600]],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight
                                      ).createShader(rect),
                                        child: Text('Send Gifts',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),)
                                    ),
                                    Container(
                                      width: 200,
                                        child: Text('Send Gifts To Start Conversation And Get Closer To Know Each Other',style: TextStyle(fontSize: 13,fontStyle: FontStyle.italic),)),
                                  ],
                                )
                              ],
                            ),
                            onTap: () {
                              showGift().then((v) {
                                print('we got ' + v.toString());
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('Gift $v sent to $name'),
                                  duration: Duration(seconds: 2),
                                ));
                              });
                            },
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 15,
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0)),
                      child: Container(
                        //todo, about
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            gradient: LinearGradient(
                                colors: [
                                  //Colors.pink[600],
                                  //Colors.pinkAccent
                                  Colors.pinkAccent,
                                  Colors.pink[50]
//                              Color.fromRGBO(216, 27, 96,0.8),
//                              Color.fromRGBO(103,58,183,0.8)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(13.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text('Photos'),
                                  InkWell(
                                    child: Text('> more'),
                                    onTap: () {
                                      SchedulerBinding.instance
                                          .addPostFrameCallback((_) {
                                        _scrollController2.animateTo(
                                            _scrollController2
                                                .position.maxScrollExtent,
                                            duration:
                                                Duration(milliseconds: 300),
                                            curve: Curves.easeOut);
                                      });
                                    },
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                color: Colors.deepPurple[100],
                                child: SingleChildScrollView(
                                  controller: _scrollController2,
                                  scrollDirection: Axis.horizontal,
                                  physics: BouncingScrollPhysics(),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[5],
                                        onTap: () {
                                          open(context, 5);
                                        },
                                      ),
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[6],
                                        onTap: () {
                                          open(context, 6);
                                        },
                                      ),
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[7],
                                        onTap: () {
                                          open(context, 7);
                                        },
                                      ),
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[8],
                                        onTap: () {
                                          open(context, 8);
                                        },
                                      ),
                                      GalleryItemThumbnail(
                                        galleryExampleItem: galleryItems[9],
                                        onTap: () {
                                          open(context, 9);
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget descriptionWidget(BuildContext context, String title, String body) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 2),
          child: Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[800]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Text(
            body,
            style: TextStyle(fontSize: 17, color: Colors.grey[900]),
          ),
        ),
      ],
    );
  }
}
