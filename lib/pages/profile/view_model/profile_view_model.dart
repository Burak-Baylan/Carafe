import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../core/base/view_model/base_view_model.dart';
import '../../authenticate/model/user_model.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;

  @override
  setContext(BuildContext context) => this.context = context;

  setUserId(String userId) => this.userId = userId;

  late String userId;
  late int followersCount;
  late int followingCount;
  late UserModel? userModel;

  @observable
  bool? isUserFollowing;

  @observable
  bool profileOwner = false;

  Future<bool> initializeInformations() async {
    userModel = await firebaseManager.getAUserInformation(userId);
    await getFollowingAndFollowersCount();
    if (userModel == null) {
      return false;
    }
    return true;
  }

  @action
  Future followButtonClicked() async {
    if (isUserFollowing == null || isUserFollowing!) {
      showUnfollowAlert();
    } else {
      followUser();
    }
  }

  @action
  Future followUser() async {
    await userManager.followUser(userId, currentTime);
    isUserFollowing = true;
  }

  @action
  Future unfollowUser() async {
    await userManager.unfollowUser(userId);
    isUserFollowing = false;
  }

  showUnfollowAlert() => showAlert(
        'Unfollow ${userModel!.username}?',
        'Are you sure you want to unfollow @${userModel!.username}',
        context: context!,
        positiveButtonText: 'Unfollow',
        negativeButtonText: 'Cancel',
        onPressedPositiveButton: () async => await unfollowUser(),
      );

  Future getFollowingAndFollowersCount() async {
    var followersCount = 0;
    var followingCount = 0;
    if (userId == authService.userId) {
      //* User's own profile
      followersCount = await userManager.getCurrentUserFollowersCount() ?? 0;
      followingCount = await userManager.getCurrentUserFollowingCount() ?? 0;
      profileOwner = true;
    } else {
      followersCount = await userManager.getAUserFollowersCount(userId) ?? 0;
      followingCount = await userManager.getAUserFollowingCount(userId) ?? 0;
      isUserFollowing = (await userManager.followingState(userId)).data;
      profileOwner = false;
    }
    userModel!.followersCount = followersCount;
    userModel!.followingCount = followingCount;
  }
}
