import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../core/base/view_model/base_view_model.dart';
import '../../../../model/post_model.dart';
part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;

  @override
  setContext(BuildContext context) => this.context = context;

  setPostModel(PostModel postModel) => this.postModel = postModel;

  late PostModel postModel;

  @observable
  IconData likeIcon = Icons.favorite_outline;
  @observable
  IconData postSaveIcon = Icons.bookmark_outline;

  bool likeLock = false;
  bool saveLock = false;
  IconData unlikedIcon = Icons.favorite_outline;
  IconData likedIcon = Icons.favorite_outlined;
  IconData unsavedIcon = Icons.bookmark_outline;
  IconData savedIcon = Icons.bookmark_outlined;

  changeLikeLockState() => likeLock = !likeLock;

  changePostSaveLockState() => saveLock = !saveLock;

  @action
  findLikeIcon() async {
    if (!(await getUserLikeState)) {
      likeIcon = likedIcon;
    } else {
      likeIcon = unlikedIcon;
    }
  }

  @action
  findPostSaveIcon() async {
    if (!(await getUserPostSaveState)) {
      postSaveIcon = savedIcon;
    } else {
      postSaveIcon = unsavedIcon;
    }
  }

  Future<bool> get getUserLikeState async => await postManager.userLikeState(
        postModel.postId,
        authService.userId!,
      );

  Future<bool> get getUserPostSaveState async =>
      await postManager.userPostSaveState(
        postModel.postId,
        authService.userId!,
      );

  @action
  Future like() async {
    if (likeLock) return;
    changeLikeLockState();
    if (await getUserLikeState) {
      bool isPostLiked =
          await postManager.likePost(postModel.postId, currentTime);
      if (isPostLiked) likeIcon = likedIcon;
    } else {
      bool isPostUnliked =
          await postManager.unlikePost(postModel.postId, authService.userId!);
      if (isPostUnliked) likeIcon = unlikedIcon;
    }
    changeLikeLockState();
  }

  comment() async {}

  @action
  Future save() async {
    if (saveLock) return;
    changePostSaveLockState();
    if (await getUserPostSaveState) {
      await postManager.savePost(
          postModel.postId, authService.userId!, currentTime);
      postSaveIcon = savedIcon;
    } else {
      await postManager.unsavePost(
          postModel.postId, authService.userId!, currentTime);
      postSaveIcon = unsavedIcon;
    }
    changePostSaveLockState();
  }
}
