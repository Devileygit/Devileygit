import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:deviley_production/services/databse.dart';

///types///
///type 0 means favourite
///type 1 means gift

class NotificationFillService {
  Database database = Database();

  addFavouriteNotificationDataFunction(String peerId, String userId, int type) {
    Map<String, dynamic> favouriteNotificationData = {
      'userId':userId,
      'peerId': peerId,
      'type': type,
      'time': DateTime.now().millisecondsSinceEpoch
    };

    database.checkDuplicateNotification(userId, peerId, type).then((v) {
      if (v.documents.length == 0) {
        print('lalala   ' + v.documents.length.toString());
        database.addNotificationData(userId, favouriteNotificationData);
      }
    });
  }

  addGiftNotificationDataFunction(
      String peerId, String userId, int type, int giftIndex) {
    Map<String, dynamic> giftNotificationData = {
      'userId':userId,
      'peerId': peerId,
      'type': type,
      'giftIndex': giftIndex,
      'time': DateTime.now().millisecondsSinceEpoch
    };

    database.addNotificationData(userId, giftNotificationData).then((v) {
      print('success gift');
    });
  }
}
