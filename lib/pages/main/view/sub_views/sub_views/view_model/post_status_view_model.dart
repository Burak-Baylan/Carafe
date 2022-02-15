import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../authenticate/model/user_model.dart';
import '../../../../model/post_model.dart';
import '../../../../model/post_status_informations_model.dart';
import '../../post_widget/post_widget/view_model/post_view_model.dart';
part 'post_status_view_model.g.dart';

class PostStatusViewModel = _PostStatusViewModelBase with _$PostStatusViewModel;

abstract class _PostStatusViewModelBase extends BaseViewModel with Store {
  late PostModel postModel;
  late UserModel userModel;
  late PostViewModel postViewModel;
  late PostStatusInformationsModel postStatusInformationsModel;

  @override
  BuildContext? context;

  @override
  setContext(BuildContext context) => this.context = context;

  setViewModel(PostViewModel postViewModel) {
    this.postViewModel = postViewModel;
  }

  Future<void> getInformations(String authorId) async {
    userModel = (await firebaseManager.getAUserInformation(authorId))!;
    postModel = (await firebaseManager.getPostInformations(
      null,
      documentSnapshot: postViewModel.currentPostRef,
    ))!;
    var likeCount = await postViewModel.postManager
        .getPostLikeCount(postViewModel.currentPostRef);
    var commentCount = await postViewModel.postManager
        .getPostCommentsCount(postViewModel.currentPostRef);
    await getStatusInformations();
    postModel.likeCount = likeCount;
    postModel.commentCount = commentCount;
  }

  Future<void> getStatusInformations() async {
    var postViewsCount = await postViewModel.postStatusInformationsManager
        .getPostViews(postViewModel.currentPostRef);
    var postClicksCount = await postViewModel.postStatusInformationsManager
        .getPostClicked(postViewModel.currentPostRef);
    var profileVisitsCount = await postViewModel.postStatusInformationsManager
        .getProfileVisits(postViewModel.currentPostRef);
    var interactionCount = await postViewModel.postStatusInformationsManager
        .getInteractions(postViewModel.currentPostRef);
    postStatusInformationsModel = PostStatusInformationsModel(
      views: postViewsCount,
      interactions: interactionCount,
      postClicks: postClicksCount,
      profileVisits: profileVisitsCount,
    );
  }
}
