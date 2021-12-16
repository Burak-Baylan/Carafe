import 'package:Carafe/core/firebase/firestore/manager/post_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobx/mobx.dart';

import '../../../../../core/base/view_model/base_view_model.dart';
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
  int fullScreenImageIndex = 0;

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
  changeFullScreenImageIndex(int index) => fullScreenImageIndex = index;

  @action
  changePostsScrollable(ScrollPhysics? physics) => postsScrollable = physics;

  @action
  lockScrollable() => changePostsScrollable(const NeverScrollableScrollPhysics());

  @action
  openScrollable() => changePostsScrollable(null);

  @action
  changeMoreImageLoadingProgressState() =>
      moreImageLoadingProgressState = !moreImageLoadingProgressState;

  ScrollController get scrollController {
    var controller = ScrollController();
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
  Future<List<PostModel>> getPosts() async {
    lockScrollable();
    posts.clear();
    posts = await firebasePostManger.getPosts();
    openScrollable();
    return posts;
  }
  
FirebaseAuth get auth => FirebaseAuth.instance;
  Future<List<PostModel>> loadMorePosts() async {
    changeMoreImageLoadingProgressState();
    var postsHere = await firebasePostManger.loadMorePost();
    for (var element in postsHere) {
      posts.add(element);
    }
    changeMoreImageLoadingProgressState();
    return posts;
  }
}
