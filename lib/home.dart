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
  PageController _pageController;

  PageController _pageController2;
  int _currentIndex = 0;
  final List _children = [HomePage(), Chat(), Favourite(), Profile()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
    _pageController2 = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _pageController.dispose();
    _pageController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
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
            icon: Icon(FontAwesomeIcons.home),
            activeColor: Colors.pink[600],
            inactiveColor: Colors.pink[300],
          ),
          BottomNavyBarItem(
            title: Text('Chat'),
            icon: Icon(FontAwesomeIcons.solidComments),
            activeColor: Colors.pink[600],
            inactiveColor: Colors.pink[300],
          ),
          BottomNavyBarItem(
            title: Text('Favourite'),
            icon: Icon(FontAwesomeIcons.solidHeart),
            activeColor: Colors.pink[600],
            inactiveColor: Colors.pink[300],
          ),
          BottomNavyBarItem(
            title: Text('Profile'),
            icon: Icon(FontAwesomeIcons.solidUser),
            activeColor: Colors.pink[600],
            inactiveColor: Colors.pink[300],
          )
        ],
      ),
      body: _children[_currentIndex],
    );
  }
}
