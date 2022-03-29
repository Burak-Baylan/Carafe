import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../../app/constants/app_constants.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../core/extensions/double_extensions.dart';
import '../../../core/extensions/widget_extension.dart';
import '../../../core/widgets/small_circular_progress_indicator.dart';
import '../../../core/widgets/something_went_wrong_widget.dart';
import '../../../core/widgets/there_is_nothing_here_widget.dart';
import '../../../main.dart';
import '../../main/view/sub_views/post_widget/post_widget/sub_widgets/profile_photo.dart';
import '../view_model/notification_view_model.dart';
import 'sub_views/notififcation_widget.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView>
    with AutomaticKeepAliveClientMixin {
  NotificationViewModel notificationVm = NotificationViewModel();

  late Future<void> notificationFuture;

  @override
  void initState() {
    notificationFuture = notificationVm.getNotifications();
    notificationVm.setContext(context);
    notificationVm.initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      body: FutureBuilder(
        future: notificationFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (notificationVm.notifications.isEmpty) {
              return const ThereIsNothingHereWidget();
            }
            return buildPageSkeleton;
          }
          if (snapshot.hasError) {
            return const SomethingWentWrongWidget().center;
          }
          return const SmallCircularProgressIndicator().center;
        },
      ),
    );
  }

  Widget get buildPageSkeleton => RefreshIndicator(
        onRefresh: () => notificationVm.getNotifications(),
        child: SizedBox(
          width: context.width,
          height: context.height,
          child: getNotificationsListView,
        ),
      );

  Widget get getNotificationsListView => Observer(builder: (context) {
        return ListView.separated(
          physics: notificationVm.postsScrollable,
          itemCount: notificationVm.notifications.length,
          controller: notificationVm.scrollController,
          shrinkWrap: true,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) => buildNotificationItem(index),
        );
      });

  Widget buildNotificationItem(int index) {
    var model = notificationVm.notifications[index];
    if (!(model.hasRead)) {
      mainVm.markNotificationAsRead(model.notificationId);
    }
    return NotificationsWidget(
      notificationVm: notificationVm,
      notificationModel: model,
    );
  }

  AppBar get appBar {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColors.white,
      leading: appBarLeading,
      centerTitle: true,
      title: Text(
        "Notifications",
        style: context.theme.textTheme.headline6?.copyWith(
          fontSize: context.width / 25,
          fontWeight: FontWeight.bold,
          color: context.theme.colorScheme.primary,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.refresh,
            color: context.colorScheme.secondary,
          ),
          onPressed: () async {
            await notificationVm.getNotifications();
            setState(() {});
          },
        ),
      ],
      bottom: PreferredSize(
        preferredSize: Size(context.width, 1),
        child: const Divider(height: 1, thickness: 1),
      ),
    );
  }

  Widget get appBarLeading => Container(
        margin: 7.0.edgeIntesetsAll,
        child: Observer(
          builder: (_) => PostProfilePhoto(
            imageUrl: (mainVm.currentUserModel)?.photoUrl,
            onClicked: (_) => context.openDrawer,
          ),
        ),
      );

  @override
  bool get wantKeepAlive => true;
}
