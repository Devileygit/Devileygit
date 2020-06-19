import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future addChat(String chatRoomId, chatData) async {
    Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .collection('chats')
        .add(chatData)
        .catchError((e) {
      print('addchat error : ' + e.toString());
    });
  }

  Future addChatRoom(chatRoom, chatRoomId) async {
    Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .setData(chatRoom)
        .catchError((e) {
      print('addchatroom error : ' + e.toString());
    });
  }

  getChats(String chatRoomId) async {
    return Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots();
  }

  getUserChatList(String userId) async {
    return Firestore.instance
        .collection('chatRoom')
        .where('users', arrayContains: userId)
        .snapshots();
  }

  Future addFavourite(String myUid, String peerUid) async {
    return Firestore.instance.collection('users').document(myUid).updateData({
      'favouriteList': FieldValue.arrayUnion([peerUid])
    }).catchError((onError) {
      print(onError);
    });
  }

  getPersonalData(String myUid) async {
    return Firestore.instance.collection('users').document(myUid).snapshots();
  }

  getPersonalDataDocuments(String myUid) {
    return Firestore.instance
        .collection('users')
        .where('id', isEqualTo: myUid)
        .limit(1)
        .snapshots();
  }

  updateProfileName(String myUid, String changedName) async {
    Firestore.instance
        .collection('users')
        .document(myUid)
        .updateData({'name': changedName});
  }

  updateProfileAbout(String myUid, String changedAbout) async {
    Firestore.instance
        .collection('users')
        .document(myUid)
        .updateData({'about': changedAbout});
  }

  updateProfileLocation(String myUid, String cityName, String countryName,
      double cityLatitude, double cityLongitude) async {
    Firestore.instance.collection('users').document(myUid).updateData({
      'cityName': cityName,
      'countryName': countryName,
      'cityLatitude': cityLatitude,
      'cityLongitude': cityLongitude
    });
  }

  updateProfileMarital(String myUid, String marital) async {
    Firestore.instance
        .collection('users')
        .document(myUid)
        .updateData({'marital': marital});
  }

  updateProfileAddiction(String myUid, List<String> addictionList) async {
    Firestore.instance
        .collection('users')
        .document(myUid)
        .updateData({'addictionList': addictionList});
  }

  updateProfileOrientation(String myUid, String orientation) async {
    Firestore.instance
        .collection('users')
        .document(myUid)
        .updateData({'orientation': orientation});
  }

  Future addNotificationData(String userId, data) async {
    Firestore.instance
        .collection('users')
        .document(userId)
        .collection('notificationData')
        .add(data)
        .catchError((e) {
      print('addNotification Data error.....    ' + e);
    });
  }

  Future checkDuplicateNotification(
      String userId, String peerId, int type) async {
    return Firestore.instance
        .collection('users')
        .document(userId)
        .collection('notificationData')
        .where('peerId', isEqualTo: peerId)
        .where('type', isEqualTo: type)
        .limit(1)
        .getDocuments();
  }

  getNotificationsData(String userId) async {
    return Firestore.instance
        .collection('users')
        .document(userId)
        .collection('notificationData')
        .orderBy('time', descending: true)
        .limit(1000)
        .snapshots();
  }
}
