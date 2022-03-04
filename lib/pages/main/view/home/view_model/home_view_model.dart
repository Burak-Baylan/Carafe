import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/firebase/firestore/manager/post_manager/post_manager.dart';
import '../../../../../main.dart';
import '../../../model/post_model.dart';
part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;

  @override
  setContext(BuildContext context) {
    this.context = context;
    postManager = firebasePostManager;
  }

  @observable
  List<PostModel> posts = [];
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
  late FirebasePostManager postManager;

  bool canMorePostsUpload = true;

  void lockCanUploadMorePost() => canMorePostsUpload = false;
  void openCanUploadMorePost() => canMorePostsUpload = true;

  @observable
  bool showExploreWidget = false;

  void changeShowExploreWidgetState(bool state) => showExploreWidget = state;

  ScrollController get scrollController {
    var controller = ScrollController();
    mainVm.homeViewPostsScrollController = controller;
    controller.addListener(() async {
      if (!canMorePostsUpload) return;
      if (controller.offset >= controller.position.maxScrollExtent) {
        lockScrollable();
        await loadMorePosts();
        openScrollable();
      }
    });
    return controller;
  }

  @action
  Future<List<PostModel>> getPosts() async {
    lockScrollable();
    openCanUploadMorePost();
    changeShowExploreWidgetState(false);
    var postsData = await postManager.getPosts();
    if (postsData.error == null) {
      posts = postsData.data!;
    }
    openScrollable();
    return posts;
  }

  Future<List<PostModel>> loadMorePosts() async {
    var postsData = await postManager.loadMorePost();
    if (postsData.error == null) {
      for (var comment in postsData.data!) {
        posts.add(comment);
      }
      var loadedPosts = postsData.data!;
      changeShowExploreWidgetState(false);
      loadMoreCommentsLockControl(loadedPosts.length);
    }
    return posts;
  }

  void loadMoreCommentsLockControl(int size) {
    if (size < firebaseConstants.numberOfPostsToBeReceiveAtOnce) {
      lockCanUploadMorePost();
      changeShowExploreWidgetState(true);
    }
  }
}
