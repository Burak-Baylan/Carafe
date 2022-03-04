import 'package:Carafe/core/base/view_model/base_view_model.dart';
import 'package:Carafe/core/firebase/firestore/manager/post_manager/post_manager.dart';
import 'package:Carafe/pages/main/model/post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'category_view_model.g.dart';

class CategoryViewModel = _CategoryViewModelBase with _$CategoryViewModel;

abstract class _CategoryViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;

  void setCategoryName(String categoryName) => this.categoryName = categoryName;

  late String categoryName;

  FirebasePostManager postManager = FirebasePostManager.instance;

  @observable
  List<PostModel> posts = [];

  ScrollController controller = ScrollController();

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
  void openScrollable() =>
      changePostsScrollable(const AlwaysScrollableScrollPhysics());

  bool canMorePostsUpload = true;

  void lockCanUploadMorePost() => canMorePostsUpload = false;
  void openCanUploadMorePost() => canMorePostsUpload = true;

  void initializeValues() {
    controller.addListener(() async {
      if (!canMorePostsUpload) return;
      if (controller.offset >= controller.position.maxScrollExtent) {
        lockScrollable();
        await loadMorePosts();
        openScrollable();
      }
    });
  }

  late Query<Map<String, dynamic>>? ref;

  Query<Map<String, dynamic>> get getPostRef =>
      firebaseConstants.postsCreatedDescending
          .where(firebaseConstants.isPostDeletedText, isEqualTo: false)
          .where(firebaseConstants.categoryText, isEqualTo: categoryName);

  @action
  Future<void> getPosts() async {
    openCanUploadMorePost();
    lockScrollable();
    ref = getPostRef;
    var rawData = await postManager.getPosts(ref: ref);
    if (rawData.error != null) return;
    posts = rawData.data!;
    openScrollable();
  }

  @action
  Future<void> loadMorePosts() async {
    var postsData = await postManager.loadMorePost(ref: ref);
    if (postsData.error == null) {
      for (var comment in postsData.data!) {
        posts.add(comment);
      }
      var loadedPosts = postsData.data!;
      loadMoreCommentsLockControl(loadedPosts.length);
    }
  }

  void loadMoreCommentsLockControl(int size) {
    if (size < firebaseConstants.numberOfPostsToBeReceiveAtOnce) {
      lockCanUploadMorePost();
    }
  }
}
