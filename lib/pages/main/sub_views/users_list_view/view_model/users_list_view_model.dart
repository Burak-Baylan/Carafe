import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../authenticate/model/user_model.dart';
import '../../../model/post_model.dart';
import '../../../view/sub_views/post_widget/full_screen_post_view/full_screen_post_view.dart';
import 'helper/users_list_manager.dart';
part 'users_list_view_model.g.dart';

class UsersListViewModel = _UsersListViewModelBase with _$UsersListViewModel;

abstract class _UsersListViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;

  @observable
  ScrollPhysics usersListScrollabe = const AlwaysScrollableScrollPhysics();

  ScrollController get scrollController {
    var controller = ScrollController();
    controller.addListener(() async {
      if (!canMorePostsUpload) return;
      if (controller.offset >= controller.position.maxScrollExtent) {
        lockScrollable();
        await loadMoreData();
        openScrollable();
      }
    });
    return controller;
  }

  void setUserListType(ListingType userListType) =>
      this.userListType = userListType;

  @action
  void changePostsScrollable(ScrollPhysics physics) =>
      usersListScrollabe = physics;
  @action
  void lockScrollable() =>
      changePostsScrollable(const NeverScrollableScrollPhysics());
  @action
  void openScrollable() =>
      changePostsScrollable(const AlwaysScrollableScrollPhysics());

  bool canMorePostsUpload = true;

  void lockCanUploadMorePost() => canMorePostsUpload = false;
  void openCanUploadMorePost() => canMorePostsUpload = true;

  List<UserModel> usersList = [];
  List<PostModel?> postModel = [];
  late ListingType userListType;

  late Query<Map<String, dynamic>> reference;

  void loadMoreCommentsLockControl(int size) {
    if (size < firebaseConstants.numberOfUsersSearchAtOnce) {
      lockCanUploadMorePost();
    }
  }

  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisibleUserDoc;

  UsersListManager usersListManager = UsersListManager.instance;

  @action
  Future<List<UserModel>> getData(Query<Map<String, dynamic>> ref) async {
    reference = ref;
    lockScrollable();
    openCanUploadMorePost();
    var usersModels = await usersListManager.getData(
      userListType: userListType,
      reference: reference,
    );
    usersList.clear();
    updateLists(usersModels);
    openScrollable();
    return usersList;
  }

  Future<void> loadMoreData() async {
    var usersModels = await usersListManager.loadMore();
    updateLists(usersModels);
  }

  void updateLists(List<UserModel>? userList) {
    if (userList != null) {
      for (var user in userList) {
        usersList.add(user);
      }
      if (userListType == ListingType.comments) {
        postModel = usersListManager.postModel;
      }
    }
  }

  void navigateToFullScreenView(PostModel postModel) => customNavigateToPage(
        page: FullScreenPostView(postModel: postModel),
        animate: true,
      );
}

enum ListingType {
  likes,
  comments,
  search,
  followingUsers,
  followerUsers,
  savedPosts
}
