import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/extensions/widget_extension.dart';
import '../../../model/post_model.dart';
import '../../main_screen.dart';

part 'home_view_model.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;

  @override
  setContext(BuildContext context) => this.context = context;
  @observable
  List<PostModel> posts = [];
  @observable
  Widget homeBody = Container();
  @observable
  ScrollPhysics? postsScrollable;
  @observable
  bool moreImageLoadingProgressState = false;
  
  @action
  changeHomeBody(Widget body) => homeBody = body;
  @action
  changePostsScrollable(ScrollPhysics? physics) => postsScrollable = physics;
  @action
  lockScrollable() =>
      changePostsScrollable(const NeverScrollableScrollPhysics());
  @action
  openScrollable() => changePostsScrollable(null);
  @action
  changeMoreImageLoadingProgressState() =>
      moreImageLoadingProgressState = !moreImageLoadingProgressState;

  ScrollController get scrollController {
    var controller = ScrollController();
    mainVm.homeViewPostsScrollController = controller;
    controller.addListener(() async {
      if (controller.offset >= controller.position.maxScrollExtent) {
        lockScrollable();
        await loadMorePosts();
        openScrollable();
      }
    });
    return controller;
  }

  bool scrollDirectionController(UserScrollNotification notification) {
    if (notification.direction == ScrollDirection.forward) {
      if (!mainVm.isFabVisible) mainVm.changeFabVisibility(true);
    } else if (notification.direction == ScrollDirection.reverse) {
      if (mainVm.isFabVisible) mainVm.changeFabVisibility(false);
    }
    return true;
  }

  @action
  Future<List<PostModel>> getPosts(Widget postBody) async {
    changeHomeBody(const CircularProgressIndicator().center);
    lockScrollable();
    posts.clear();
    posts = await firebasePostManger.getPosts();
    openScrollable();
    changeHomeBody(postBody);
    return posts;
  }

  Future<List<PostModel>> loadMorePosts() async {
    changeMoreImageLoadingProgressState();
    var postList = await firebasePostManger.loadMorePost();
    for (var post in postList) {
      posts.add(post);
    }
    changeMoreImageLoadingProgressState();
    return posts;
  }
}
