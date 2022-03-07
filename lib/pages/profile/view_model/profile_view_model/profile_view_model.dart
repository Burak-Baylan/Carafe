import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../core/base/view_model/base_view_model.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../core/firebase/firestore/manager/post_manager/post_manager.dart';
import '../../../authenticate/model/user_model.dart';
import '../../../main/model/post_model.dart';
import '../../view/edit_profile_view/edit_profile_view.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  setContext(BuildContext context) => this.context = context;
  setUserId(String userId) => this.userId = userId;
  late String userId;
  @observable
  UserModel? userModel;
  ScrollController listViewController = ScrollController();
  double get statusBarHeight => context!.statusBarHeight;
  @observable
  double height = 0;
  @observable
  bool tabBarVisibility = false;
  @action
  changeTabBarVisibility() => tabBarVisibility = !tabBarVisibility;
  @action
  updateHeight(double height) => this.height = height;
  @observable
  bool? isUserFollowing;
  @observable
  bool profileOwner = false;
  @observable
  ScrollPhysics? cartPhysics = const AlwaysScrollableScrollPhysics();
  List<PostModel> userPosts = [];
  List<DocumentReference<Map<String, dynamic>>?> userPostsRefs = [];
  late FirebasePostManager postManager;
  @observable
  PostModel? pinnedPost;

  @observable
  int followersCount = 0;
  @observable
  int followingCount = 0;
  @observable
  String? ppUrl;
  @observable
  String username = '';
  @observable
  String displayName = '';
  @observable
  String? description;
  @observable
  String? website;
  @observable
  Timestamp? birthDate;
  ScrollController postListController = ScrollController();
  bool canMorePostsUpload = true;

  void lockCanUploadMorePost() => canMorePostsUpload = false;
  void openCanUploadMorePost() => canMorePostsUpload = true;

  @action
  Future<bool> initializeInformations() async {
    postManager = firebasePostManager;
    userModel = await firebaseManager.getAUserInformation(userId);
    if (userModel == null) {
      return false;
    }
    ppUrl = userModel!.photoUrl;
    username = userModel!.username;
    displayName = userModel!.displayName;
    description = userModel!.profileDescription;
    website = userModel?.website;
    birthDate = userModel?.birthDate;
    await getFollowingAndFollowersCount();
    prepareScrollListener();
    return true;
  }

  Future<void> refreshPage() async {
    var response = await initializeInformations();
    if (!response) return;
    await userPostsFuture();
  }

  @action
  Future<void> followButtonClicked(ProfileViewModel profileViewModel) async {
    if (profileOwner) {
      customNavigateToPage(
        page: EditProfileView(profileViewModel: profileViewModel),
        animate: true,
      );
      return;
    }
    if (isUserFollowing == null || isUserFollowing!) {
      showUnfollowAlert();
    } else {
      followUser();
    }
  }

  @action
  Future<void> followUser() async {
    await userManager.followUser(userId, currentTime);
    isUserFollowing = true;
    followersCount++;
  }

  @action
  Future<void> unfollowUser() async {
    await userManager.unfollowUser(userId);
    isUserFollowing = false;
    followersCount--;
  }

  @observable
  int userPostsLength = 0;

  lockScrollable() => cartScrollable(const NeverScrollableScrollPhysics());
  openScrollable() => cartScrollable(const AlwaysScrollableScrollPhysics());
  @action
  cartScrollable(ScrollPhysics? physics) => cartPhysics = physics;

  bool checkIfSameWithPinnedPost(String checkingPostId) =>
      pinnedPost != null && checkingPostId == pinnedPost!.postId;

  Future<void> userPostsFuture() async {
    await getUserPinnedPost();
    await getUserPosts();
  }

  void prepareScrollListener() {
    postListController.addListener(() async {
      if (!canMorePostsUpload) return;
      if (postListController.offset >=
          postListController.position.maxScrollExtent) {
        lockScrollable();
        await getMorePosts();
        openScrollable();
      }
    });
  }

  Future<void> getUserPosts() async {
    userPosts.clear();
    userPostsLength = 0;
    userPostsRefs.clear();
    openCanUploadMorePost();
    var rawData = await postManager.getPosts(
        ref: firebaseConstants.getAUsersPostRef(userId));
    if (rawData.error != null) {
    } else {
      for (var doc in rawData.data!) {
        userPosts.add(doc);
      }
    }
    userPostsLength = userPosts.length + 1;
  }

  Future<void> getMorePosts() async {
    var rawData = await postManager.loadMorePost(
      ref: firebaseConstants.getAUsersPostRef(userId),
    );
    if (rawData.error != null) {
    } else {
      for (var doc in rawData.data!) {
        userPosts.add(doc);
      }
    }
    var loadedPosts = rawData.data!;
    loadMoreCommentsLockControl(loadedPosts.length);
    userPostsLength = userPosts.length + 1;
  }

  @action
  Future<PostModel?> getUserPinnedPost() async {
    var postData = await userManager.userPinnedPost(userModel!.userId);
    if (postData.error != null || postData.data == null) {
      pinnedPost = null;
      return null;
    }
    var pinnedPostModel = postData.data;
    pinnedPost = pinnedPostModel;
    return pinnedPostModel;
  }

  void showUnfollowAlert() => showAlert(
        'Unfollow ${userModel!.username}?',
        'Are you sure you want to unfollow @${userModel!.username}',
        context: context!,
        positiveButtonText: 'Unfollow',
        negativeButtonText: 'Cancel',
        onPressedPositiveButton: () async => await unfollowUser(),
      );

  Future<void> getFollowingAndFollowersCount() async {
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
    this.followersCount = followersCount;
    this.followingCount = followingCount;
  }

  void loadMoreCommentsLockControl(int size) {
    if (size < firebaseConstants.numberOfPostsToBeReceiveAtOnce) {
      lockCanUploadMorePost();
    }
  }
}
