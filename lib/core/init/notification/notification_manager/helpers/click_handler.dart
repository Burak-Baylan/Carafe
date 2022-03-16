import '../../../../../main.dart';
import '../../../../../pages/main/model/notification_model.dart';
import '../../../../../pages/main/model/post_model.dart';
import '../../../../../pages/main/view/sub_views/post_widget/full_screen_post_view/full_screen_post_view.dart';
import '../../../../../pages/profile/view/profile_view/profile_view.dart';
import '../../../../firebase/base/firebase_base.dart';

class NotificationClickHandler with FirebaseBase {
  late NotificationModel notificationModel;

  Future<void> clicked(NotificationModel notificationModel) async {
    this.notificationModel = notificationModel;
    var type = notificationModel.type;
    String? postId = notificationModel.postId;
    if (postId == null) return;
    switch (type) {
      case 'like':
        await postNotificationCase();
        break;
      case 'comment':
        await postNotificationCase();
        break;
      case 'follow':
        await followNotificationCase();
        break;
    }
  }

  void navigateToFullscreenPostView(PostModel postModel) {
    mainVm.customNavigateToPage(
      page: FullScreenPostView(postModel: postModel),
      animate: true,
    );
  }

  Future<void> navigateToProfileView(String userId) async {
    mainVm.customNavigateToPage(
      page: ProfileView(userId: userId),
      animate: true,
    );
  }

  Future<void> postNotificationCase() async {
    var ref = firestore.doc(notificationModel.postPath!);
    var postModel =
        await firebaseManager.getPostInformations(null, reference: ref);
    if (postModel != null) {
      navigateToFullscreenPostView(postModel);
    }
  }

  Future<void> followNotificationCase() async {
    var userId = notificationModel.senderUserId;
    if (userId == null) return;
    navigateToProfileView(userId);
  }
}
