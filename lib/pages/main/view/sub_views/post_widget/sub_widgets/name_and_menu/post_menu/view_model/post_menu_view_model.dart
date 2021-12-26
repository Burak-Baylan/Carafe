import 'package:Carafe/core/base/view_model/base_view_model.dart';
import 'package:Carafe/core/firebase/firestore/manager/firebase_user_manager.dart';
import 'package:Carafe/pages/authenticate/model/user_model.dart';
import 'package:Carafe/pages/main/model/pinned_post_model.dart';
import 'package:Carafe/pages/main/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'post_menu_view_model.g.dart';

class PostMenuViewModel = _PostMenuViewModelBase with _$PostMenuViewModel;

abstract class _PostMenuViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  setContext(BuildContext context) => this.context = context;

  late PostModel postModel;
  late UserModel userModel;
  setPostModel(PostModel postModel) => this.postModel = postModel;
  setUserModel(UserModel userModel) => this.userModel = userModel;

  @observable
  String pinButtonText = 'Pin to profile';
  @observable
  String followButtonText = 'Follow';

  bool isItCurrentUserPost = false;
  bool thisPostPinnedToProfile = false;

  void findPostOwner() {
    if (postModel.authorId == auth.currentUser!.uid) {
      isItCurrentUserPost = true;
      return;
    }
    isItCurrentUserPost = false;
  }

  @observable
  @action
  Future<bool> findPinButtonActionAndText() async {
    var path = firebaseConstants.userPinnedPostControlRef(
        userModel.userId, postModel.postId);
    var data = await firebaseService.getQuery(path);
    if (data.error != null) return false;
    if (data.data!.docs.isEmpty) {
      pinButtonText = "Pin to profile";
      thisPostPinnedToProfile = false;
    } else {
      pinButtonText = "Unpin from profile";
      thisPostPinnedToProfile = true;
    }
    return true;
  }

  @action
  Future<bool> findFollowButtonActionAndText() async {
    var path = firebaseConstants.userFollowingControlRef(
        authService.userId!, postModel.authorId);
    var data = await firebaseService.getQuery(path);
    printRed(data.data!.docs.length.toString());
    if (data.error != null) return false;
    if (data.data!.docs.isEmpty) {
      followButtonText = 'Follow';
    } else {
      followButtonText = "Unfollow";
    }
    return true;
  }

  Future pinProfileClicked() async {
    if (thisPostPinnedToProfile) {
      await unpinFromProfile();
    } else {
      await pinToProfile();
    }
  }

  void showPostPinnedSuccessfullyAlert() => showAlert('Success', 'Post pinned.',
      context: context!, disableNegativeButton: true);

  void showPostNotPinnedAlert() => showAlert(
      'Error', 'An error occured while pinning the post. Please try again.',
      context: context!, disableNegativeButton: true);

  void showPostUnpinnedSuccessfullyAlert() =>
      showAlert('Success', 'Post unpinned.',
          context: context!, disableNegativeButton: true);

  void showPostNotUnpinnedAlert() => showAlert(
      'Error', 'An error occured while unpinning the post. Please try again.',
      context: context!, disableNegativeButton: true);

  Future pinToProfile() async {
    var response =
        await postManager.pinPostToProfile(currentTime, postModel.postId);
    if (!response) showPostNotPinnedAlert();
    showPostPinnedSuccessfullyAlert();
  }

  Future unpinFromProfile() async {
    var response = await postManager.unpinPostFromProfile();
    if (!response) showPostNotUnpinnedAlert();
    showPostUnpinnedSuccessfullyAlert();
  }
}
