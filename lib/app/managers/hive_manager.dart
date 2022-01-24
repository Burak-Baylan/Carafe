import 'package:Carafe/core/hive/hive_constants.dart';
import 'package:Carafe/main.dart';

import '../../core/hive/hive_helper.dart';

class HiveManager {
  static HiveHelper hiveHelper = HiveHelper.instance;

  static Future<bool> get getPostWidgetViewType async =>
      await hiveHelper.getData<bool>(
        HiveConstants.BOX_APP_PREFERENCES,
        HiveConstants.KEY_POST_VIEW_TYPE_PREFERENCE,
        defaultValue: true,
      ) ??
      true;

  static Future<List<String>> get getUserFollowingUsersIds async =>
      await hiveHelper.getData<List<String>>(
        HiveConstants.BOX_USER_INFORMATIONS,
        HiveConstants.KEY_USER_FOLLOWING_USERS_IDS,
        defaultValue: [],
      ) ??
      [];

  static Future<void> addFromUserFollowingUserIds(
      String followingUserId) async {
    mainVm.followingUsersIds.add(followingUserId);
    await hiveHelper.putData(
      HiveConstants.BOX_USER_INFORMATIONS,
      HiveConstants.KEY_USER_FOLLOWING_USERS_IDS,
      mainVm.followingUsersIds,
    );
  }

  static Future deleteFollowingUserIdFromFollowingUserIds(
    String followingUserId,
  ) async {}

  static Future addFollowingUserIdFromFollowingUserIds(
    String followingUserId,
  ) async {
    await hiveHelper.deleteData(
      HiveConstants.BOX_USER_INFORMATIONS,
      HiveConstants.KEY_USER_FOLLOWING_USERS_IDS,
    );
  }
}
