import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  Future<void> addChat(String chatRoomId, chatData) {
    Firestore.instance
        .collection('chatRoom')
        .document(chatRoomId)
        .collection('chats')
        .add(chatData)
        .catchError((e) {
      print('addchat error : ' + e.toString());
    });
  }

  Future addChatRoom(chatRoom, chatRoomId) {
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
        .orderBy('time')
        .snapshots();
  }

  getUserChatList(String userId) async {
    return Firestore.instance
        .collection('chatRoom')
        .where('users', arrayContains: userId)
        .snapshots();
  }
}
