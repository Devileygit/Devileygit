import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future addChat(String chatRoomId, chatData) async{
    Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .collection('chats')
        .add(chatData)
        .catchError((e) {
      print('addchat error : ' + e.toString());
    });
  }

  Future addChatRoom(chatRoom, chatRoomId) async{
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

  Future addFavourite(String myUid, String peerUid ) async{
    Firestore.instance
        .collection('users')
        .document(myUid)
        .updateData({
      'favouriteList':FieldValue.arrayUnion([peerUid])
    });
  }
  
  getPersonalData(String myUid) async{
    return Firestore.instance
        .collection('users')
        .document(myUid)
        .snapshots();
  }

}
