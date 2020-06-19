import 'package:flutter/material.dart';

class GiftCountTab extends StatefulWidget {
  @override
  _GiftCountTabState createState() => _GiftCountTabState();
}

class _GiftCountTabState extends State<GiftCountTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Text('Gift Count'),
      ),
    );
  }
}
