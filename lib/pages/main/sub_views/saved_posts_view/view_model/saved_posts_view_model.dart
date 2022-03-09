import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/firebase/firestore/manager/post_manager/liked_and_saved_posts_getter.dart';
import '../../../../../core/firebase/firestore/manager/post_manager/post_manager.dart';
import '../../../model/post_model.dart';
part 'saved_posts_view_model.g.dart';

class SavedPostsViewModel = _SavedPostsViewModelBase with _$SavedPostsViewModel;

abstract class _SavedPostsViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;
  List<PostModel> savedPosts = [];

  FirebasePostManager postManager = FirebasePostManager.instance;
  LikedAndSavedPostsGetter likedPostsGetter = LikedAndSavedPostsGetter();

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

  void lockCanUploadMorePost() => canMorePostsUpload = false;
  void openCanUploadMorePost() => canMorePostsUpload = true;

  @observable
  bool showExploreWidget = false;

  Query<Map<String, dynamic>> get savedPostsRef =>
      firebaseConstants.getCurrentUserSavedPostWithLimitAndDescending;

  bool canMorePostsUpload = true;

  ScrollController get scrollController {
    var controller = ScrollController();
    controller.addListener(() async {
      if (!canMorePostsUpload) return;
      if (controller.offset >= controller.position.maxScrollExtent) {
        lockScrollable();
        await loadMoreSavedPosts();
        openScrollable();
      }
    });
    return controller;
  }

  @action
  Future<List<PostModel>?> getSavedPosts() async {
    lockScrollable();
    var savedPosts = await likedPostsGetter.getSavedPosts(savedPostsRef);
    if (savedPosts == null || savedPosts.isEmpty) {
      return null;
    }
    this.savedPosts = savedPosts;
    openScrollable();
    return savedPosts;
  }

  Future<void> loadMoreSavedPosts() async {
    var savedPosts = await likedPostsGetter.getMoreSavedPosts();
    if (savedPosts == null) {
      return;
    }
    for (var savedPosts in savedPosts) {
      this.savedPosts.add(savedPosts);
    }
    loadMoreCommentsLockControl(savedPosts.length);
  }

  void loadMoreCommentsLockControl(int size) {
    if (size < firebaseConstants.numberOfPostsToBeReceiveAtOnce) {
      lockCanUploadMorePost();
    }
  }
}
