import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../../../../../../core/firebase/firestore/manager/post_manager/post_manager.dart';
import '../../../../../../../../../authenticate/model/user_model.dart';
import '../../../../../../../../model/post_model.dart';
import '../../../../../../../../sub_views/report/view/report_view.dart';
import '../../../../view_model/post_view_model.dart';
part 'post_menu_view_model.g.dart';

class PostMenuViewModel = _PostMenuViewModelBase with _$PostMenuViewModel;

abstract class _PostMenuViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  setContext(BuildContext context) {
    this.context = context;
    postManager = firebasePostManager;
  }

  late PostModel postModel;
  late UserModel postOwnerUserModel;
  late PostViewModel postViewModel;
  setPostModel(PostModel postModel) => this.postModel = postModel;
  setUserModel(UserModel userModel) => postOwnerUserModel = userModel;
  setPostViewModel(PostViewModel postViewModel) =>
      this.postViewModel = postViewModel;

  late FirebasePostManager postManager;

  @observable
  String pinButtonText = 'Pin to profile';
  @observable
  String followButtonText = 'Follow';

  bool isItCurrentUserPost = false;
  bool thisPostPinnedToProfile = false;
  bool currentUserIsFollowingThePostOwner = false;

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
    var data = await postManager.userPinnedPostState(
        postOwnerUserModel.userId, postModel.postId);
    if (data.error != null) return false;
    if (data.data!) {
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
    var data = await userManager.followingState(postModel.authorId);
    if (data.error != null) return false;
    if (data.data!) {
      followButtonText = 'Unfollow';
      currentUserIsFollowingThePostOwner = true;
    } else {
      followButtonText = "Follow";
      currentUserIsFollowingThePostOwner = false;
    }
    return true;
  }

  void reportClicked(ReportType reportType) => customNavigateToPage(
        page: ReportView(
          reportType: reportType,
          userModel: postOwnerUserModel,
          postModel: postModel,
          viewModel: postViewModel,
        ),
        animate: true,
      );

  Future pinProfileClicked() async {
    if (thisPostPinnedToProfile) {
      await unpinFromProfile();
    } else {
      await pinToProfile();
    }
  }

  Future followUserClicked() async {
    if (currentUserIsFollowingThePostOwner) {
      await unfollowUser();
    } else {
      await followUser();
    }
  }

  Future pinToProfile() async {
    var response = await postManager.pinPostToProfile(currentTime, postModel);
    if (!response) showPostNotPinnedAlert();
    showPostPinnedSuccessfullyAlert();
  }

  Future unpinFromProfile() async {
    var response = await postManager.unpinPostFromProfile();
    if (!response) showPostNotUnpinnedAlert();
    showPostUnpinnedSuccessfullyAlert();
  }

  Future followUser() async {
    var response =
        await userManager.followUser(postOwnerUserModel, currentTime);
    if (!response) showFollowingUnsuccessAlert();
    showFollowingSuccessAlert();
  }

  Future unfollowUser() async {
    var response = await userManager.unfollowUser(postOwnerUserModel.userId);
    if (!response) showUnfollowingUnsuccessAlert();
    showUnfollowingSuccessAlert();
  }

  Future deletePost() async => showAlert(
        'Delete Post',
        'Are you sure you want to delete this post? You can\'t get it back.',
        context: context!,
        positiveButtonText: 'Delete',
        negativeButtonText: 'Cancel',
        onPressedPositiveButton: () => postViewModel.delete(postModel.replyed!),
      );

  void showPostPinnedSuccessfullyAlert() => showToast("Post pinned");

  void showPostNotPinnedAlert() => showToast("Could not be pinned");

  void showPostUnpinnedSuccessfullyAlert() => showToast("Post unpinned");

  void showPostNotUnpinnedAlert() => showToast("Could not be unpinned");

  void showFollowingSuccessAlert() =>
      showToast("You followed @${postOwnerUserModel.username}");

  void showFollowingUnsuccessAlert() => showToast("Could not be followed");

  void showUnfollowingSuccessAlert() =>
      showToast("You unfollowed @${postOwnerUserModel.username}");

  void showUnfollowingUnsuccessAlert() => showToast("Could not be unfollowed");
}
