import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/base/view_model/base_view_model.dart';
import '../../../core/firebase/firestore/manager/notifciation_firestore_manager/notifications_getter.dart';
import '../../../main.dart';
import '../../main/model/notification_model.dart';
part 'notification_view_model.g.dart';

class NotificationViewModel = _NotificationViewModelBase
    with _$NotificationViewModel;

abstract class _NotificationViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  List<NotificationModel> notifications = [];

  int get numberOfNotificationsToBeReceiveAtOnce =>
      firebaseConstants.numberOfNotificationsToBeReceiveAtOnce;

  Query<Map<String, dynamic>> get userNotifications =>
      firebaseConstants.userNotificationsWithLimitAndOrderBy;

  late ScrollController scrollController;

  void initValues() {
    scrollController = ScrollController();
    mainVm.notificationsViewPostsScrollController = scrollController;
    scrollController.addListener(() async {
      if (!canMorePostsUpload) return;
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        lockScrollable();
        await loadMoreNotifications();
        openScrollable();
      }
    });
  }

  @observable
  ScrollPhysics? postsScrollable;
  @observable
  @action
  void changePostsScrollable(ScrollPhysics physics) =>
      postsScrollable = physics;
  @action
  void lockScrollable() =>
      changePostsScrollable(const NeverScrollableScrollPhysics());
  @action
  openScrollable() =>
      changePostsScrollable(const AlwaysScrollableScrollPhysics());

  NotificationsGetter notificationsGetter = NotificationsGetter();

  bool canMorePostsUpload = true;

  void lockCanUploadMorePost() => canMorePostsUpload = false;
  void openCanUploadMorePost() => canMorePostsUpload = true;

  @action
  Future<void> getNotifications() async {
    List<NotificationModel> backupList = [];
    lockScrollable();
    backupList.addAll(notifications);
    notifications.clear();
    var newNotifications = await notificationsGetter.getNotifications(
        reference: userNotifications);
    if (newNotifications == null) {
      notifications.addAll(backupList);
      openScrollable();
      return;
    }
    notifications = newNotifications;
    await notificationsReadControl();
    mainVm.closeNotificationIndicator();
    openScrollable();
  }

  Future<void> notificationsReadControl() async {
    for (var notification in notifications) {
      if (!(notification.hasRead)) {
        await notificationManager.markAsRead(notification.notificationId);
      }
    }
  }

  @action
  Future<void> loadMoreNotifications() async {
    lockScrollable();
    var newNotifications = await notificationsGetter.loadMoreNotification(
      reference: userNotifications,
    );
    if (newNotifications == null) return;
    notifications.addAll(newNotifications);
    loadMoreNotificationsLockControl(newNotifications.length);
    openScrollable();
  }

  void loadMoreNotificationsLockControl(int size) {
    if (size < numberOfNotificationsToBeReceiveAtOnce) {
      lockCanUploadMorePost();
    }
  }
}
