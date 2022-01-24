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

  Future getInformations(String authorId) async {
    userModel = (await firebaseManager.getAUserInformation(authorId))!;
    postModel = (await firebaseManager.getPostInformations(
      null,
      documentSnapshot: postViewModel.sharedPostRef,
    ))!;
    var likeCount = await firebaseService.getCollection(
      postViewModel.sharedPostRef.collection(firebaseConstants.postLikersText),
    );
    var commentCount = await firebaseService.getCollection(
      postViewModel.sharedPostRef
          .collection(firebaseConstants.postCommentsText),
    );
    await getStatusInformations();
    if (likeCount.error != null) {
      postModel.likeCount = 0;
    }
    postModel.likeCount = likeCount.data!.size;
    if (commentCount.error != null) {
      postModel.commentCount = 0;
    }
    postModel.commentCount = commentCount.data!.size;
  }

  Future<void> getStatusInformations() async {
    var postViewsCount = await postViewModel.postStatusInformationsManager
        .getPostViews(postViewModel.sharedPostRef);
    var postClicksCount = await postViewModel.postStatusInformationsManager
        .getPostClicked(postViewModel.sharedPostRef);
    var profileVisitsCount = await postViewModel.postStatusInformationsManager
        .getProfileVisits(postViewModel.sharedPostRef);
    var interactionCount = await postViewModel.postStatusInformationsManager
        .getInteractions(postViewModel.sharedPostRef);
    postStatusInformationsModel = PostStatusInformationsModel(
      views: postViewsCount,
      interactions: interactionCount,
      postClicks: postClicksCount,
      profileVisits: profileVisitsCount,
    );
  }
}
