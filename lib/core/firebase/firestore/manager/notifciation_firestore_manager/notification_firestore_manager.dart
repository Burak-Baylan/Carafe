import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../main.dart';
import '../../../../../pages/main/model/error_model.dart';
import '../../../../../pages/main/model/notification_model.dart';
import '../../../base/firebase_base.dart';

class NotificationFirestoreManager with FirebaseBase {
  Timestamp get currentTime => mainVm.currentTime;

  Future<void> sendError({
    required String errorMessage,
    String? errorCode,
  }) async {
    var docId = currentTime.toDate().toString();
    var errorModel =
        getErrorModel(errorMessage: errorMessage, errorCode: errorCode);
    var ref = firebaseConstants.httpErrorsCollection.doc(docId);
    await firebaseService.addDocument(ref, errorModel.toJson());
  }

  ErrorModel getErrorModel({
    required String errorMessage,
    String? errorCode,
  }) {
    return ErrorModel(
      userId: authService.userId,
      errorCode: errorCode,
      errorMessage: errorMessage,
      createdAt: currentTime,
    );
  }

  Future<void> sendNotificationToUserFirestore(
    String userId,
    NotificationModel notificationModel,
  ) async {
    var data = getMap(notificationModel);
    var notificationId = notificationModel.notificationId;
    var ref = getNotificationRef(userId, notificationId);
    var response = await firebaseService.addDocument(ref, data);
    if (response.errorMessage != null) {
      await sendError(errorMessage: response.errorMessage!);
    }
    return;
  }

  Future<void> markAsRead(String userId, String notificationId) async {
    var ref = getNotificationRef(userId, notificationId);
    await firebaseManager.update(ref, {'has_read': true});
  }

  DocumentReference<Map<String, dynamic>> getNotificationRef(
    String userId,
    String notificationId,
  ) {
    var collectionText = firebaseConstants.notificationsText;
    var ref = firebaseConstants.allUsersCollectionRef
        .doc(userId)
        .collection(collectionText)
        .doc(notificationId);
    return ref;
  }

  Map<String, dynamic> getMap(NotificationModel notificationModel) {
    return notificationModel.toJson();
  }
}
