import 'package:flutter/material.dart';

class PeerProfile extends StatefulWidget {
  final snapShot;

  const PeerProfile({Key key, this.snapShot}) : super(key: key);

  @override
  _PeerProfileState createState() => _PeerProfileState();
}

class _PeerProfileState extends State<PeerProfile> {
  String addictionString='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=0;i<widget.snapShot['addictionList'].length;i++)
      {
        print(i);
        if (i!=widget.snapShot['addictionList'].length-1) {
          addictionString=addictionString+widget.snapShot['addictionList'][i]+', ';
        }
        else{
          print('....'+i.toString());
          addictionString=addictionString+widget.snapShot['addictionList'][i];
        }
      }
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
            onPressed: (){

            },
          ),
          SizedBox(height: 10,),
          FloatingActionButton(
            child: Icon(Icons.message),
            heroTag: 1,
            //backgroundColor: Colors.pinkAccent,
            onPressed: (){

            },
          ),
          SizedBox(height: 10,)
        ],
      ),
        body: Container(
      color: Colors.pink[50],
      child: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 350,
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
              title: Text(widget.snapShot['name']+', '+widget.snapShot['age']),
              centerTitle: true,
              background: Container(
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.snapShot['profilePhoto']),
                        fit: BoxFit.cover,
                        alignment: Alignment.center)),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.black, Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter),
                    ),
                  ),
                ),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
                                padding: const EdgeInsets.fromLTRB(5 , 5, 0, 5),
                                child: descriptionWidget(
                                    context, 'Gender', widget.snapShot['gender']),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
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
                SizedBox(height: 15,),
                Card(
                  elevation: 4,
                  margin: EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                  child: Container(
                    //todo, about
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        gradient: LinearGradient(
                            colors: [
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
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: descriptionWidget(
                              context,
                              'About',
                              widget.snapShot['about']),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Card(
                  margin: EdgeInsets.all(0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: descriptionWidget(
                              context,
                              'Attracted To',
                              widget.snapShot['orientation']),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: descriptionWidget(
                              context,
                              'Addictions',
                              addictionString.toString()),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text('Photos'),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,

            child: Padding(

              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(94, 53, 177, 0.2),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.favorite,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.chat,
                        size: 40,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          )
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
