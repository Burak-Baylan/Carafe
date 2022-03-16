import '../../../main.dart';
import '../../../pages/main/model/notification_model.dart';
import '../../firebase/firestore/manager/notifciation_firestore_manager/notification_firestore_manager.dart';
import '../../http/http_service.dart';
import 'notification_manager/notification_manager.dart';

class NotificationSender {
  NotificationFirestoreManager notificationFirestoreManager =
      NotificationFirestoreManager();

  final String postUrl = 'https://fcm.googleapis.com/fcm/send';

  late String? toToken;
  late String title;
  late String message;
  late NotificationType notificationType;
  late String? postId;
  late String toUserId;
  late String currentUserId;
  late String postPath;

  late NotificationModel notificationModel;

  Future<void> send({
    required String? toToken,
    required String title,
    required String message,
    required NotificationType notificationType,
    required String toUserId,
    required String postPath,
    String? postId,
  }) async {
    currentUserId = mainVm.currentUserModel!.userId;

    if (toUserId == currentUserId) {
      return;
    }

    this.toToken = toToken;
    this.postPath = postPath;
    this.title = title;
    this.message = message;
    this.notificationType = notificationType;
    this.postId = postId;
    this.toUserId = toUserId;

    notificationModel = getModel;

    await sendNotification();
    await sendNotificationToFirestore();
  }

  Future<void> sendNotification() async {
    var data = getData();

    var response =
        await HttpService.instance.post(data: data, postUrl: postUrl);

    if (response.statusCode != 200) {
      await notificationFirestoreManager.sendError(
        errorMessage: response.body,
        errorCode: response.statusCode.toString(),
      );
    }
    return;
  }

  Future<void> sendNotificationToFirestore() async {
    await notificationFirestoreManager.sendNotificationToUserFirestore(
      toUserId,
      notificationModel,
    );
  }

  Map<String, Object> getData() {
    var data = {
      'registration_ids': [toToken],
      'notification': {
        'title': title,
        'body': message,
        'priority': 'high',
      },
      'data': notificationModel.toJson()
    };
    return data;
  }

  NotificationModel get getModel {
    var type = getNotificationType(notificationType);
    var currentUserModel = mainVm.currentUserModel!;
    var notificationModel = NotificationModel(
      notificationId: mainVm.randomId,
      senderToken: currentUserModel.token!,
      senderUserId: currentUserId,
      postId: postId!,
      type: type,
      receiverToken: toToken!,
      receiverUserId: toUserId,
      postPath: postPath,
      message: message,
      title: title,
    );
    return notificationModel;
  }

  String getNotificationType(NotificationType type) {
    switch (type) {
      case NotificationType.followNotification:
        return 'follow';
      case NotificationType.likeNotification:
        return 'like';
      case NotificationType.commentNotifcation:
        return 'comment';
    }
  }
}
