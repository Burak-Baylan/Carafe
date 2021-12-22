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

  bool likeLock = false;
  IconData unlikedIcon = Icons.favorite_outline;
  IconData likedIcon = Icons.favorite_outlined;

  changeLikeLockState() => likeLock = !likeLock;

  @action
  findLikeIcon() async {
    if (!(await getUserLikeState)) {
      likeIcon = likedIcon;
    } else {
      likeIcon = unlikedIcon;
    }
  }

  Future<bool> get getUserLikeState async => await postManager.userLikeState(
        postModel.postId,
        authService.userId!,
      );

  @action
  Future like() async {
    if (likeLock) return;
    changeLikeLockState();
    if (await getUserLikeState) {
      await postManager.likePost(postModel.postId, currentTime, getRandomId);
      likeIcon = likedIcon;
    } else {
      await postManager.unlikePost(postModel.postId, authService.userId!);
      likeIcon = unlikedIcon;
    }
    changeLikeLockState();
  }

  comment() async {}
}
