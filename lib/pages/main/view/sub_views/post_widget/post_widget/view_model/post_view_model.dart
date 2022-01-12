import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../../../core/extensions/color_extensions.dart';
import '../../../../../../../core/helpers/status_bar_helper.dart';
import '../../../../../model/post_model.dart';
import '../../../../../model/post_save_model.dart';
import '../../../../add_post/view/add_post_page.dart';
import '../../../../home/view/sub_views/home_page_full_screen_image/home_page_full_screen_image.dart';
import '../../../../home/view_model/home_view_model.dart';
import '../../full_screen_post_view/full_screen_post_view.dart';

part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  setContext(BuildContext context) => this.context = context;
  setPostModel(PostModel postModel) => this.postModel = postModel;
  setHomeViewModel(HomeViewModel homeViewModel) =>
      this.homeViewModel = homeViewModel;
  @observable
  bool moreCommentsLoadingProgressState = false;
  @action
  changeMoreCommentsLoadingProgressState() =>
      moreCommentsLoadingProgressState = !moreCommentsLoadingProgressState;
  @observable
  ScrollPhysics? commentsScrollable;
  @action
  changeCommentsScrollable(ScrollPhysics? physics) =>
      commentsScrollable = physics;
  @action
  lockScrollable() =>
      changeCommentsScrollable(const NeverScrollableScrollPhysics());
  @action
  openScrollable() => changeCommentsScrollable(null);
  @observable
  IconData likeIcon = Icons.favorite_rounded;
  @observable
  IconData postSaveIcon = Icons.bookmark_outline;
  @observable
  List<PostModel> comments = [];
  bool canMoreCommentsUpload = true;
  int get commentsLength => comments.length;
  late PostModel postModel;
  bool likeLock = false;
  bool saveLock = false;
  IconData unlikedIcon = Icons.favorite_border_rounded;
  IconData likedIcon = Icons.favorite_outlined;
  IconData unsavedIcon = Icons.bookmark_outline;
  IconData savedIcon = Icons.bookmark_outlined;
  late HomeViewModel homeViewModel;
  late DocumentReference sharedPostRef;

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

  Future<bool> get getUserLikeState async =>
      await postManager.userLikeState(sharedPostRef, authService.userId!);

  Future<bool> get getUserPostSaveState async => await postManager
      .userPostSaveState(postModel.postId, authService.userId!);

  @action
  Future like() async {
    if (likeLock) return;
    changeLikeLockState();
    if (await getUserLikeState) {
      bool isPostLiked = await postManager.likePost(sharedPostRef, currentTime);
      if (isPostLiked) likeIcon = likedIcon;
    } else {
      bool isPostUnliked =
          await postManager.unlikePost(sharedPostRef, authService.userId!);
      if (isPostUnliked) likeIcon = unlikedIcon;
    }
    changeLikeLockState();
  }

  @action
  Future save() async {
    if (saveLock) return;
    changePostSaveLockState();
    var model = PostSaveModel(
      savedAt: currentTime,
      userId: authService.userId!,
      postId: postModel.postId,
      sharedPostRef: sharedPostRef.path,
    );
    if (await getUserPostSaveState) {
      await postManager.savePost(model);
      postSaveIcon = savedIcon;
    } else {
      await postManager.unsavePost(model);
      postSaveIcon = unsavedIcon;
    }
    changePostSaveLockState();
  }

  void onPressedImage(List<ImageProvider<Object>?> imageProviders,
      List<dynamic> imageUrls, int imageIndex) {
    if (imageProviders[imageUrls.length - 1] == null) return;
    StatusBarHelper.edgeToEdgeScreen();
    Colors.transparent.changeBottomNavBarColor;
    customNavigateToPage(
      page: HomePageFullScreenImage(
        imageProviders: imageProviders,
        imageUrls: imageUrls,
        imageIndex: imageIndex,
        imagesDominantColor: postModel.imagesDominantColors,
      ),
      animate: false,
    );
  }

  void navigateToFullScreenPostView(PostViewModel viewModel) =>
      customNavigateToPage(
        page: FullScreenPostView(
          postViewModel: viewModel,
          postModel: postModel,
          homeViewModel: homeViewModel,
          postRef: sharedPostRef,
        ),
        animate: true,
      );

  void navigateToReplyScreen({
    PostModel? postModel,
    DocumentReference<Object?>? postAddingRef,
  }) =>
      customNavigateToPage(
        page: AddPostPage(
          isAComment: true,
          postAddingReference: (postAddingRef ?? sharedPostRef)
              .collection(firebaseConstants.postCommentsText),
          replyingPostPostModel: postModel ?? this.postModel,
        ),
        animate: true,
      );

  DocumentReference findACommentPathFromComments(int index) => sharedPostRef
      .collection(firebaseConstants.postCommentsText)
      .doc(comments[index].postId);

  void findCommentsPath(DocumentReference<Object?>? postRef) {
    if (postRef == null) {
      sharedPostRef =
          firebaseConstants.allPostsCollectionRef.doc(postModel.postId);
    } else {
      sharedPostRef = postRef;
    }
  }

  @action
  Future<List<PostModel>> getComments() async {
    openLoadMoreCommentsState();
    lockScrollable();
    comments.clear();
    var commentsData = await firebasePostManger.getComments(
        sharedPostRef.collection(firebaseConstants.postCommentsText));
    if (commentsData.error == null) {
      comments = commentsData.data!;
    }
    openScrollable();
    return comments;
  }

  ScrollController get scrollController {
    var controller = ScrollController();
    controller.addListener(() async {
      if (!canMoreCommentsUpload || moreCommentsLoadingProgressState) return;
      if (controller.offset >= controller.position.maxScrollExtent) {
        lockScrollable();
        await loadMoreComments();
        openScrollable();
      }
    });
    return controller;
  }

  @action
  Future<void> loadMoreComments() async {
    if (!canMoreCommentsUpload || moreCommentsLoadingProgressState) return;
    changeMoreCommentsLoadingProgressState();
    lockScrollable();
    var commentData = await firebasePostManger.loadMoreComment(sharedPostRef);
    if (commentData.error == null) {
      loadMoreCommentsLockControl(commentData.data!.length);
      for (var comment in commentData.data!) {
        comments.add(comment);
      }
    }
    changeMoreCommentsLoadingProgressState();
    openScrollable();
    return;
  }

  lockLoadMoreCommentsState() => canMoreCommentsUpload = false;
  openLoadMoreCommentsState() => canMoreCommentsUpload = true;

  loadMoreCommentsLockControl(int size) {
    if (size < firebaseConstants.numberOfCommentsToBeUploadedAtOnce) {
      lockLoadMoreCommentsState();
    }
  }
}
