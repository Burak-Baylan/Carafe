import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/firebase/firestore/manager/post_manager/post_manager.dart';
import '../../../../main/model/post_model.dart';
import '../../../view_model/profile_view_model/profile_view_model.dart';
part 'users_profile_other_shares_page_view_model.g.dart';

class UsersProfileOtherSharesPageViewModel = _UsersProfileOtherSharesPageViewModelBase
    with _$UsersProfileOtherSharesPageViewModel;

abstract class _UsersProfileOtherSharesPageViewModelBase extends BaseViewModel
    with Store {
  @override
  BuildContext? context;
  @override
  setContext(BuildContext context) => this.context = context;

  setProfileModel(ProfileViewModel profileViewModel) =>
      profileVm = profileViewModel;

  late Query<Map<String, dynamic>> userMediaPostsRef;
  late Query<Map<String, dynamic>> userLikedPostsRef;
  late ProfileViewModel profileVm;
  late FirebasePostManager mediaPostsPostManager;
  late FirebasePostManager likedPostsPostManager;
  ScrollController mediaPostsScrollController = ScrollController();
  ScrollController likedPostsScrollController = ScrollController();
  @observable
  ScrollPhysics? mediaPostsScrollPhysics;
  @observable
  ScrollPhysics? likedPostsScrollPhysics;
  List<PostModel> mediaPosts = [];
  List<PostModel> likedPosts = [];

  bool canUploadMoreLikedPosts = true;
  bool canUploadMoreMedialPosts = true;

  void lockCanUploadMoreLikedPostsUpload() => canUploadMoreLikedPosts = false;
  void openCanUploadMoreLikedPostsUpload() => canUploadMoreLikedPosts = true;

  void lockCanUploadMoreMediaPostsUpload() => canUploadMoreMedialPosts = false;
  void openCanUploadMoreMediaPostsUpload() => canUploadMoreMedialPosts = true;

  void initializeViewModel() {
    mediaPostsPostManager = firebaseConstants.firebasePostManager;
    likedPostsPostManager = firebaseConstants.firebasePostManager;
    userMediaPostsRef =
        firebaseConstants.aUsersMediaPostsRef(profileVm.userModel!.userId);
    userLikedPostsRef =
        firebaseConstants.userLikedPostsCollectionRefWithLimitAndDescending(
            profileVm.userModel!.userId);
    initializeScrollControllers();
  }

  void initializeScrollControllers() {
    likedPostsScrollController.addListener(() async {
      if (!canUploadMoreLikedPosts) return;
      if (likedPostsScrollController.offset >=
          likedPostsScrollController.position.maxScrollExtent) {
        await getMoreLikedPosts();
      }
    });
    mediaPostsScrollController.addListener(() async {
      if (!canUploadMoreMedialPosts) return;
      if (mediaPostsScrollController.offset >=
          mediaPostsScrollController.position.maxScrollExtent) {
        await getMoreMediaPosts();
      }
    });
  }

  PostModel getMediaPost(int index) => mediaPosts[index];
  PostModel getLikedPost(int index) => likedPosts[index];

  DocumentReference<Map<String, dynamic>>? getPostRef(String? postPath) =>
      postPath != null ? firestore.doc(postPath) : null;

  @action
  void changeMediaPostsPhysics(ScrollPhysics physics) =>
      mediaPostsScrollPhysics = physics;
  @action
  void lockMediaPostsPhysics() =>
      changeMediaPostsPhysics(const NeverScrollableScrollPhysics());
  @action
  void openMediaPostsPhysics() =>
      changeMediaPostsPhysics(const AlwaysScrollableScrollPhysics());

  @action
  void changeLikedPostsPhysics(ScrollPhysics physics) =>
      likedPostsScrollPhysics = physics;
  @action
  void lockLikedPostsPhysics() =>
      changeLikedPostsPhysics(const NeverScrollableScrollPhysics());
  @action
  void openLikedPostsPhysics() =>
      changeLikedPostsPhysics(const AlwaysScrollableScrollPhysics());

  Future<void> getMediaPosts() async {
    lockMediaPostsPhysics();
    openCanUploadMoreMediaPostsUpload();
    var rawMediaPosts =
        await mediaPostsPostManager.getPosts(ref: userMediaPostsRef);
    if (rawMediaPosts.error != null || rawMediaPosts.data == null) {
      return;
    }
    mediaPosts = rawMediaPosts.data!;
    openMediaPostsPhysics();
  }

  Future<void> getMoreMediaPosts() async {
    lockMediaPostsPhysics();
    var rawMediaPosts =
        await mediaPostsPostManager.loadMorePost(ref: userMediaPostsRef);
    if (rawMediaPosts.error != null || rawMediaPosts.data == null) {
      return;
    }
    for (var post in rawMediaPosts.data!) {
      mediaPosts.add(post);
    }
    loadMoreMediaPostsLockControl(rawMediaPosts.data!.length);
    openMediaPostsPhysics();
  }

  @action
  Future<void> getLikedPosts() async {
    lockLikedPostsPhysics();
    openCanUploadMoreLikedPostsUpload();
    var postsList = await likedPostsPostManager.likedPostsGetter
        .getLikedPosts(userLikedPostsRef);
    if (postsList == null) {
      openLikedPostsPhysics();
      return;
    }
    likedPosts.clear();
    likedPosts = postsList;
    openLikedPostsPhysics();
  }

  @action
  Future<void> getMoreLikedPosts() async {
    lockLikedPostsPhysics();
    var postsList =
        await likedPostsPostManager.likedPostsGetter.getMoreLikedPosts();
    if (postsList == null) {
      openLikedPostsPhysics();
      return;
    }
    for (var likedPost in postsList) {
      likedPosts.add(likedPost);
    }
    loadMoreLikedPostsLockControl(postsList.length);
    openLikedPostsPhysics();
  }

  void loadMoreLikedPostsLockControl(int size) =>
      size < firebaseConstants.numberOfPostsToBeReceiveAtOnce
          ? lockCanUploadMoreLikedPostsUpload()
          : null;

  void loadMoreMediaPostsLockControl(int size) =>
      size < firebaseConstants.numberOfPostsToBeReceiveAtOnce
          ? lockCanUploadMoreMediaPostsUpload()
          : null;
}
