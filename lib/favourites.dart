import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/services/databse.dart';
import 'package:deviley_production/services/sharedprefs.dart';
import 'package:flutter/material.dart';

class Favourites extends StatefulWidget {
  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  Stream<DocumentSnapshot> myDetails;
  Stream<DocumentSnapshot> favDetails;
  Database database = Database();
  String myUid;

  getUserIdAndUserData() async {
    await SharedPrefs.getUserIdSharedPreference().then((value) {
      setState(() {
        myUid=value;
        database.getPersonalData(myUid).then((val){
          setState(() {
            myDetails=val;
          });
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserIdAndUserData();
  }

  Widget favouriteList(){
    return StreamBuilder(
        stream: myDetails,
        builder: (context,snapshots){
          if(snapshots.hasData){
            var docs=snapshots.data.data;
            return ListView.builder(
                itemCount: docs['favouriteList'].length,
                itemBuilder: (context,index){
                  return Container(
                    child: favouriteUsers(docs['favouriteList'][index]),
                  );
                }
            );
          }
          else{
            return Container();
          }
        }
    );
  }

  Widget favouriteUsers(String favId){
    return FutureBuilder(
        future: database.getPersonalData(favId),
        builder:(context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done){
            favDetails=snapshot.data;
            return StreamBuilder(
                stream: favDetails,
                builder: (context,snapshots){
                  if(snapshots.hasData){
                    var favDoc=snapshots.data.data;
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              child: CircleAvatar(
                                backgroundColor: Colors.pink[600],
                                radius: 33,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(favDoc['profilePhoto']),
                                  backgroundColor: Colors.transparent,
                                  radius: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(favDoc['name']+', '+favDoc['age'],style: TextStyle(fontSize: 17),),
                                Text(favDoc['cityName'],style: TextStyle(color: Colors.grey[600]),)
                              ],
                            )
                          ],
                        ),
                      )
                    );
                  }
                  else{
                    return Container();
                  }
                }
            );
          }
          else{
            return Container();
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        leading: BackButton(
            color: Colors.grey[800]
        ),
        elevation: 0,
        backgroundColor: Colors.pink[50],
        title: Text('Favourites',style: TextStyle(color: Colors.grey[800],fontWeight: FontWeight.bold),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_vert,color: Colors.grey[800],),
            onPressed: (){},
          )
        ],
      ),
      body: Container(
        child: favouriteList(),
      ),
    );
  }
}
