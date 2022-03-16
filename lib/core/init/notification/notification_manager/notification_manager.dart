import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../../../main.dart';
import '../../../../pages/main/model/notification_model.dart';
import '../../../../pages/main/model/post_model.dart';
import '../../../../pages/main/view/sub_views/post_widget/full_screen_post_view/full_screen_post_view.dart';
import '../../../../pages/profile/view/profile_view/profile_view.dart';
import '../../../firebase/firestore/manager/notifciation_firestore_manager/notification_firestore_manager.dart';
import '../notification_sender.dart';
import '../show_notification.dart';
import 'helpers/click_handler.dart';

class NotificationManager {
  late FirebaseMessaging _messaging;
  NotificationSender notificationSender = NotificationSender();
  NotificationFirestoreManager notificationFirestoreManager =
      NotificationFirestoreManager();
  NotificationClickHandler clickHandler = NotificationClickHandler();

  Future<void> messaging(BuildContext context) async {
    _messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await requestPermission();

    var status = settings.authorizationStatus;

    if (status == AuthorizationStatus.authorized) {
      listenTokenRefresh();
      listenInitialNotification();
      listenWhenNotKilled();
      listenWhenAppIsOpen(context);
    }
  }

  //* When app is open.
  void listenWhenAppIsOpen(BuildContext context) {
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        showNotification(event, context);
      }
    });
  }

  //* If app is killed and clicked the notification.
  Future<void> listenInitialNotification() async {
    var initMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initMessage != null) {
      var notificationModel = NotificationModel.fromJson(initMessage.data);
      await notificationFirestoreManager.markAsRead(
        notificationModel.receiverUserId!,
        notificationModel.notificationId,
      );
      clickHandler.clicked(notificationModel);
    }
  }

  //* If app is not killed and clicked the notificaiton.
  void listenWhenNotKilled() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      var notificationModel = NotificationModel.fromJson(event.data);
      await notificationFirestoreManager.markAsRead(
        notificationModel.receiverUserId!,
        notificationModel.notificationId,
      );
      clickHandler.clicked(notificationModel);
    });
  }

  Future<void> send({
    required String? toToken,
    required String title,
    required String toUserId,
    required String message,
    required String postPath,
    required NotificationType notificationType,
    String? postId,
  }) async {
    await notificationSender.send(
      toToken: toToken,
      title: title,
      message: message,
      notificationType: notificationType,
      postId: postId,
      toUserId: toUserId,
      postPath: postPath,
    );
  }

  void showNotification(RemoteMessage event, BuildContext context) {
    var notification = event.notification;
    String? title = notification!.title;
    if (title == null || title == '') {
      title = notification.body;
    }
    var notificationModel = NotificationModel.fromJson(event.data);
    String? type = notificationModel.type;
    ShowNotification.show(
      context: context,
      title: title,
      onClickTrailing: () => notificationAlertClicked(event),
      type: type,
    );
  }

  void listenTokenRefresh() {
    FirebaseMessaging.instance.onTokenRefresh.listen(
      (token) => mainVm.userManager.updateUserToken(token),
    );
  }

  Future<NotificationSettings> requestPermission() async {
    var settings = _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );
    return settings;
  }

  Future<void> notificationAlertClicked(RemoteMessage event) async {
    var notificationModel = NotificationModel.fromJson(event.data);
    String? postPath = notificationModel.postPath;
    if (postPath != null) {
      await notificationFirestoreManager.markAsRead(
        notificationModel.receiverUserId!,
        notificationModel.notificationId,
      );
      var type = notificationModel.type;
      if (type == 'like' || type == 'comment') {
        var ref = mainVm.firestore.doc(postPath);
        var postModel = await mainVm.firebaseManager
            .getPostInformations(null, reference: ref);
        navigateToFullScreenPost(postModel!);
      } else if (type == 'follow') {
        var userId = notificationModel.senderUserId;
        if (userId == null) return;
        navigateToProfileView(userId);
      }
    }
  }

  void navigateToFullScreenPost(PostModel postModel) {
    mainVm.customNavigateToPage(
      page: FullScreenPostView(postModel: postModel),
      animate: true,
    );
  }

  void navigateToProfileView(String userId) {
    mainVm.customNavigateToPage(
      page: ProfileView(userId: userId),
      animate: true,
    );
  }
}

enum NotificationType {
  followNotification,
  likeNotification,
  commentNotifcation
}
