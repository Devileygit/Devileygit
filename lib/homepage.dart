import 'package:cloud_firestore/cloud_firestore.dart';
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
  PageController _pageController;
  Stream _stream;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stream=Firestore.instance.collection('users').snapshots();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<FirebaseUser>(context);
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
              child: IconButton(
                icon: Icon(Icons.tune,color: Colors.grey[800],),
                onPressed: () {
                  print('tapped');
                },
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: 3*MediaQuery.of(context).size.height/4,
          child: Column(
            children: <Widget>[
              Expanded(

                child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      return PageView.builder(
                        controller: _pageController,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => pageWidget(context, snapshot.data.documents[index], user),

                        itemCount: snapshot.data.documents.length,
                      );
                    }else{
                      return Container(
                      );
                    }
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pageWidget(BuildContext context, DocumentSnapshot documentSnapshot,FirebaseUser user){
    if(documentSnapshot['id']!=user.uid){
      return InkWell(
        onTap: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>PeerProfile(snapShot: documentSnapshot,)));
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 20),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 4,
                          spreadRadius: 4,
                          offset: Offset(0, 5),
                          color: Color.fromRGBO(0, 0, 0, 0.5))
                    ],
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
                            colors: [
                              Colors.black,
                              Colors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center,
                          children: <Widget>[
                            Text(
                              'Chamki Mamoni, 30',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey[100]),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
    }else{
      return Container();
    }
  }

}
