import 'package:deviley_production/notificationtabpages/giftcount.dart';
import 'package:deviley_production/notificationtabpages/mainnotification.dart';
import 'package:deviley_production/notificationtabpages/tab3.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.pink[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            'Notifications',
            style:
                TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Main',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              Tab(
                child: Text(
                  'Gift Library',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
              Tab(
                child: Text(
                  'Kichu Ekta',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            MainNotificationTab(),
            GiftCountTab(),
            MainNotificationTab()
          ],
        ),
      ),
    );
  }
}
