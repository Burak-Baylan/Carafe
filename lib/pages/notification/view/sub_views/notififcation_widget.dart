import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/extensions/double_extensions.dart';
import '../../../../core/init/notification/notification_manager/notification_manager.dart';
import '../../../../main.dart';
import '../../../authenticate/model/user_model.dart';
import '../../../main/model/notification_model.dart';
import '../../../main/view/sub_views/post_widget/full_screen_post_view/full_screen_post_view.dart';
import '../../../main/view/sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../../../profile/view/profile_view/profile_view.dart';
import '../../../profile/view/profile_view/sub_widgets/place_holders/profile_view_profiile_photo_place_holder.dart';
import '../../view_model/notification_view_model.dart';

class NotificationsWidget extends StatefulWidget {
  NotificationsWidget({
    Key? key,
    required this.notificationVm,
    required this.notificationModel,
    this.extraWidget,
  }) : super(key: key);

  NotificationViewModel notificationVm;
  NotificationModel notificationModel;
  Widget? extraWidget;

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  late NotificationViewModel notificationVm;
  late NotificationModel notificationModel;
  late Future<UserModel?> future;
  late String title;
  late String? message;
  late NotificationType notificationType;

  double get getUserInformationLayoutWidth =>
      context.width -
      15 -
      10 -
      (context.width / 14) -
      (15.0.edgeIntesetsAll.left);

  @override
  void initState() {
    super.initState();
    notificationVm = widget.notificationVm;
    notificationModel = widget.notificationModel;
    future = notificationVm.firebaseManager
        .getAUserInformation(notificationModel.senderUserId!);
  }

  @override
  Widget build(BuildContext context) {
    _initNotificationInformations();
    return _buildSkeleton();
  }

  void _initNotificationInformations() {
    findNotificaitonType();
    findTitle();
    findMessage();
  }

  Widget _buildSkeleton() => InkWell(
        splashColor: Colors.transparent,
        onTap: () => navigateToProfile(),
        child: Container(
          padding: 15.0.edgeIntesetsAll,
          color: notificationModel.hasRead
              ? Colors.transparent
              : Colors.grey.shade200,
          child: buildIconAndLayout,
        ),
      );

  Widget get buildIconAndLayout => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon,
          10.0.sizedBoxOnlyWidth,
          _buildLayout(),
        ],
      );

  Widget _profilePhoto() => FutureBuilder<UserModel?>(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var userModel = snapshot.data;
            return _buildProfilePhoto(userModel);
          }
          return SizedBox(
            width: context.width / 10,
            height: context.width / 10,
            child: ProfileViewProfilePhotoPlaceHolder(),
          );
        },
      );

  Widget _buildProfilePhoto(UserModel? userModel) => PostProfilePhoto(
        imageUrl: userModel?.photoUrl,
        width: context.width / 10,
        height: context.width / 10,
        userId: userModel?.userId,
      );

  Widget _buildLayout() => SizedBox(
        width: getUserInformationLayoutWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _profilePhoto(),
            10.0.sizedBoxOnlyHeight,
            buildTitle,
            buildMessageText,
            widget.extraWidget != null ? widget.extraWidget! : Container(),
          ],
        ),
      );

  Widget get buildTitle => _buildText(
        text: title,
        fontSize: context.width / 23,
        fontWeight: FontWeight.bold,
        color: context.colorScheme.secondary,
      );

  Widget get buildMessageText => message != null
      ? _buildText(
          text: message!,
          fontSize: context.width / 24,
        )
      : Container();

  Widget get _buildIcon => Icon(
        findIcon,
        color: context.colorScheme.secondary,
        size: context.width / 14,
      );

  Future<void> navigateToProfile() async {
    String type = notificationModel.type!;
    switch (type) {
      case 'follow':
        navigateToProfileView();
        break;
      case 'like':
        navigateToFullScreenPostView();
        break;
      case 'comment':
        navigateToFullScreenPostView();
        break;
    }
  }

  IconData get findIcon {
    IconData icon = Icons.favorite_rounded;
    switch (notificationType) {
      case NotificationType.followNotification:
        icon = Icons.person_rounded;
        break;
      case NotificationType.likeNotification:
        icon = Icons.favorite_rounded;
        break;
      case NotificationType.commentNotifcation:
        icon = Icons.comment_rounded;
        break;
    }
    return icon;
  }

  void findTitle() {
    switch (notificationType) {
      case NotificationType.followNotification:
        title = notificationModel.message!;
        break;
      case NotificationType.likeNotification:
        title = notificationModel.title!;
        break;
      case NotificationType.commentNotifcation:
        title = notificationModel.title!;
        break;
    }
  }

  void findMessage() {
    switch (notificationType) {
      case NotificationType.followNotification:
        message = null;
        break;
      case NotificationType.likeNotification:
        message = notificationModel.message;
        break;
      case NotificationType.commentNotifcation:
        message = notificationModel.message;
        break;
    }
  }

  void findNotificaitonType() {
    String type = notificationModel.type!;
    switch (type) {
      case 'follow':
        notificationType = NotificationType.followNotification;
        break;
      case 'like':
        notificationType = NotificationType.likeNotification;
        break;
      case 'comment':
        notificationType = NotificationType.commentNotifcation;
        break;
    }
  }

  Widget _buildText({
    required String text,
    required double fontSize,
    Color? color,
    FontWeight? fontWeight,
  }) =>
      Text(
        text,
        style: context.theme.textTheme.headline6?.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          overflow: TextOverflow.ellipsis,
        ),
        maxLines: 10,
      );

  void navigateToFullScreenPostView() async {
    var ref = mainVm.firestore.doc(notificationModel.postPath!);
    var postModel =
        await mainVm.firebaseManager.getPostInformations(null, reference: ref);
    mainVm.customNavigateToPage(
      page: FullScreenPostView(postModel: postModel!),
      animate: true,
    );
  }

  void navigateToProfileView() {
    mainVm.customNavigateToPage(
      page: ProfileView(userId: notificationModel.senderUserId!),
      animate: true,
    );
  }
}
