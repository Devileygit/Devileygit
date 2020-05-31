import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/favourites.dart';
import 'package:deviley_production/peerprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _listController;
  //PageController _pageController;
  Stream _stream;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream = Firestore.instance.collection('users').snapshots();
    _listController = ScrollController()..addListener((){
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return Scaffold(
      backgroundColor: Colors.pink[50],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.album),
        heroTag: 'favouritePage',
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Favourites()));
        },
      ),
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ClipperHome(),
            child: Container(
              height: 400,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple[600],Colors.deepPurple[600]]
                )
              ),
            ),
          ),
          Center(
            child: Container(

              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
              controller: _listController,
              slivers: <Widget>[
                SliverAppBar(
                  title: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text('Deviley',style: TextStyle(fontSize: 30,fontWeight: FontWeight.w900),),
                  ),

                  floating: true,
                  backgroundColor: Colors.deepPurple[600],
                  elevation: 0,
                  actions: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: IconButton(
                        color: Colors.grey[50],
                        icon: Icon(Icons.tune),
                        onPressed: (){},
                      ),
                    )
                  ],
                ),

                StreamBuilder(

                    stream: _stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate((context,index){
                            return pageWidget(context, snapshot.data.documents[index], user);
                          },
                            childCount: snapshot.data.documents.length,
                          ),
                        );
                      } else {
                        return SliverToBoxAdapter(child: Container(),);
                      }
                    })
              ],

              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pageWidget(BuildContext context, DocumentSnapshot documentSnapshot,
      FirebaseUser user) {
    if (documentSnapshot['id'] != user.uid) {
      return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PeerProfile(
                        snapShot: documentSnapshot,
                      )));
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Card(
            color: Colors.transparent,
            margin: EdgeInsets.all(0),
            elevation: 5,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 420,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(15),

                      image: DecorationImage(
                          image: NetworkImage(documentSnapshot['profilePhoto']),
                          fit: BoxFit.cover,
                          alignment: Alignment.center)),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          gradient: LinearGradient(
                              colors: [Colors.black, Colors.transparent],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                documentSnapshot['name'] +
                                    ', ' +
                                    documentSnapshot['age'],
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey[100]),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

class ClipperHome extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0,  size.height -150);
    path.quadraticBezierTo(
        size.width / 4, 3*size.height/4-25, size.width / 2, 3*size.height/4-25 );
    path.quadraticBezierTo(
        3 * size.width / 4, 3*size.height/4-25, size.width, size.height -150);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

