import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../app/constants/app_constants.dart';
import '../../../../core/base/view_model/base_view_model.dart';
import '../../../../core/firebase/firestore/manager/post_manager/post_manager.dart';
import '../../../../main.dart';
import '../../../main/model/post_model.dart';
part 'explore_view_model.g.dart';

class ExploreViewModel = _ExploreViewModelBase with _$ExploreViewModel;

abstract class _ExploreViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;

  ScrollController scrollController = ScrollController();

  void initializeValues() {
    mainVm.exploreViewPostsScrollController = scrollController;
  }

  FirebasePostManager postManager = FirebasePostManager.instance;

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

  List<PostModel>? technologyPosts = [];
  List<PostModel>? softwarePosts = [];
  List<PostModel>? gamesPosts = [];
  List<PostModel>? advicesPosts = [];
  List<PostModel>? enterprisePosts = [];

  Query<Map<String, dynamic>> getRef(String categoryName) =>
      firebaseConstants.postsCreatedDescending
          .limit(10)
          .where(firebaseConstants.isPostDeletedText, isEqualTo: false)
          .where(firebaseConstants.categoryText, isEqualTo: categoryName);

  Future<void> getAllPosts() async {
    lockScrollable();
    gamesPosts = await getPosts(PostContstants.GAMES);
    softwarePosts = await getPosts(PostContstants.SOFTWARE);
    advicesPosts = await getPosts(PostContstants.ADVICES);
    enterprisePosts = await getPosts(PostContstants.ENTERPRISE);
    technologyPosts = await getPosts(PostContstants.TECHNOLOGY);
    openScrollable();
  }

  @action
  Future<List<PostModel>?> getPosts(String categoryName) async {
    var ref = getRef(categoryName);
    var rawData = await postManager.getPosts(ref: ref);
    if (rawData.error != null) return null;
    return rawData.data!;
  }
}
