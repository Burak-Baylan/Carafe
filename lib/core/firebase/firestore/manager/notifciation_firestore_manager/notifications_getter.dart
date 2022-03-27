import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../main.dart';
import '../../../../../pages/main/model/notification_model.dart';
import '../../../base/firebase_base.dart';

class NotificationsGetter with FirebaseBase {
  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisibleNotification;
  late Query<Map<String, dynamic>> userLikedPostsRef;

  Future<List<NotificationModel>?> getNotifications({
    required Query<Map<String, dynamic>> reference,
  }) async {
    var rawNotifications = await firestoreService.getQuery(reference);
    if (rawNotifications.error != null || rawNotifications.data == null) {
      return null;
    }
    return await getNotificationsList(rawNotifications.data!.docs, reference);
  }

  Future<List<NotificationModel>?> loadMoreNotification({
    required Query<Map<String, dynamic>> reference,
  }) async {
    var rawRef = reference.startAfterDocument(lastVisibleNotification);
    mainVm.printYellow(
        NotificationModel.fromJson(lastVisibleNotification.data())
            .notificationId);
    var rawNotifications = await firestoreService.getQuery(rawRef);
    if (rawNotifications.error != null || rawNotifications.data == null) {
      return null;
    }
    return await getNotificationsList(rawNotifications.data!.docs, reference);
  }

  Future<List<NotificationModel>?> getNotificationsList(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
    Query<Map<String, dynamic>> ref,
  ) async {
    List<NotificationModel> notifications = [];
    int i = 0;
    var rawData = await firestoreService.getQuery(ref);
    if (rawData.error != null) return null;
    for (var doc in docs) {
      i++;
      if (docs.length == i) {
        lastVisibleNotification = docs[docs.length - 1];
      }
      var notificationModel = NotificationModel.fromJson(doc.data());
      notifications.add(notificationModel);
    }
    return notifications;
  }
}
