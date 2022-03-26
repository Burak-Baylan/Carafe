import '../../core/init/notification/notification_manager/notification_manager.dart';
import '../../main.dart';
import '../../pages/authenticate/model/user_model.dart';
import '../../pages/main/model/post_model.dart';

class NotificationSenderByType {
  NotificationManager notificationManager = NotificationManager();

  String get currentUserUsername => mainVm.currentUserModel!.username;

  Future<void> sendLikeNotification({
    required UserModel userModel,
    required PostModel postModel,
  }) async {
    await notificationManager.send(
      toToken: userModel.token,
      toUserId: postModel.authorId,
      title: '@$currentUserUsername liked your post.',
      message: postModel.text.toString(),
      notificationType: NotificationType.likeNotification,
      postId: postModel.postId,
      postPath: postModel.postPath,
    );
  }

  Future<void> sendCommentNotification({
    required String receiverUserToken,
    required PostModel postModel,
    required String toUserId,
  }) async {
    await notificationManager.send(
      toToken: receiverUserToken,
      toUserId: toUserId,
      title: '@$currentUserUsername commented on your post.',
      message: '@$currentUserUsername: ' + postModel.text.toString(),
      notificationType: NotificationType.commentNotifcation,
      postId: postModel.postId,
      postPath: postModel.postPath,
    );
  }

  Future<void> sendFollowNotification({required UserModel userModel}) async {
    await notificationManager.send(
      toToken: userModel.token,
      toUserId: userModel.userId,
      title: '',
      message: '@$currentUserUsername followed you.',
      notificationType: NotificationType.followNotification,
      postId: '',
      postPath: '',
    );
  }
}
