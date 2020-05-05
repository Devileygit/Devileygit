import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:deviley_production/chat.dart';
import 'package:deviley_production/favourite.dart';
import 'package:deviley_production/homepage.dart';
import 'package:deviley_production/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
 Key keyPageView=PageStorageKey('pageviewstore');
  int _currentIndex = 0;

  List _children;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _children=[HomePage(key: keyPageView,), Chat(), Favourite(), Profile()];
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 40,
        showElevation: false,
        backgroundColor: Colors.pink[50],
        curve: Curves.linearToEaseOut,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedIndex: _currentIndex,
        items: [
          BottomNavyBarItem(
            title: Text('Home'),
            icon: Icon(FontAwesomeIcons.solidClone,size: 20,),
            activeColor: Colors.deepPurple[500],
            inactiveColor: Colors.pinkAccent,
          ),
          BottomNavyBarItem(
            title: Text('Chat'),
            icon: Icon(FontAwesomeIcons.solidComment,size:20),
            activeColor: Colors.deepPurple[500],
            inactiveColor: Colors.pinkAccent,
          ),
          BottomNavyBarItem(
            title: Text('Favourite'),
            icon: Icon(FontAwesomeIcons.solidHeart,size: 20,),
            activeColor: Colors.deepPurple[500],
            inactiveColor: Colors.pinkAccent,
          ),
          BottomNavyBarItem(
            title: Text('Profile'),
            icon: Icon(FontAwesomeIcons.solidUser,size: 20,),
            activeColor: Colors.deepPurple[500],
            inactiveColor: Colors.pinkAccent,
          )
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
