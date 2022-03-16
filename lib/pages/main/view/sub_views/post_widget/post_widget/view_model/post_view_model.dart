import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../../../core/firebase/firestore/manager/post_manager/post_manager.dart';
import '../../../../../../authenticate/model/user_model.dart';
import '../../../../../model/post_model.dart';
import '../../../../../model/post_save_model.dart';
import 'helpers/post_status_informations_manager.dart';
import 'helpers/post_view_model_navigators.dart';
part 'post_view_model.g.dart';

class PostViewModel = _PostViewModelBase with _$PostViewModel;

abstract class _PostViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) {
    this.context = context;
    postManager = firebasePostManager;
  }

  setPostModel(PostModel postModel) => this.postModel = postModel;
  @observable
  UserModel? userModel;
  @observable
  IconData likeIcon = Icons.favorite_rounded;
  @observable
  IconData postSaveIcon = Icons.bookmark_outline;
  @observable
  List<PostModel> comments = [];
  @observable
  bool isPostDeleted = false;
  @observable
  ScrollPhysics? commentsScrollable;
  @action
  void changeCommentsScrollable(ScrollPhysics? physics) =>
      commentsScrollable = physics;
  @action
  void lockScrollable() =>
      changeCommentsScrollable(const NeverScrollableScrollPhysics());
  @action
  void openScrollable() => changeCommentsScrollable(null);
  bool canUploadMoreComments = true;
  late PostModel postModel;
  bool likeLock = false;
  bool saveLock = false;
  IconData unlikedIcon = Icons.favorite_border_rounded;
  IconData likedIcon = Icons.favorite_outlined;
  IconData unsavedIcon = Icons.bookmark_outline;
  IconData savedIcon = Icons.bookmark_outlined;
  late DocumentReference currentPostRef;
  late FirebasePostManager postManager;
  PostViewModelNavigators postViewModelNavigators = PostViewModelNavigators();
  var postStatusInformationsManager = PostStatusInformationsManager();

  void changeLikeLockState() => likeLock = !likeLock;
  void changePostSaveLockState() => saveLock = !saveLock;

  Query<Map<String, dynamic>> get commentsRef => currentPostRef
      .collection(firebaseConstants.postCommentsText)
      .orderBy(firebaseConstants.createdAtText, descending: true)
      .where(firebaseConstants.isPostDeletedText, isEqualTo: false)
      .limit(firebaseConstants.numberOfCommentsToBeReceiveAtOnce);

  Query<Map<String, dynamic>> postCommentsRawRef() =>
      firebaseConstants.aPostCommentsRef(postModel.postPath).where(
            firebaseConstants.isPostDeletedText,
            isEqualTo: false,
          );

  CollectionReference<Map<String, dynamic>> postLikesRef() =>
      firebaseConstants.aPostLikesRef(postModel.postPath);

  Future<void> initializeValues() async {
    currentPostRef = firestore.doc(postModel.postPath);
    await findPostOwnerUser();
  }

  @action
  Future<void> findPostOwnerUser() async =>
      userModel = await firebaseManager.getAUserInformation(postModel.authorId);

  @action
  Future<void> findLikeIcon() async {
    if (!(await getUserLikeState)) {
      likeIcon = likedIcon;
    } else {
      likeIcon = unlikedIcon;
    }
  }

  @action
  Future<void> findPostSaveIcon() async {
    if (!(await getUserPostSaveState)) {
      postSaveIcon = savedIcon;
    } else {
      postSaveIcon = unsavedIcon;
    }
  }

  Future<bool> get getUserLikeState async =>
      await postManager.userLikeState(currentPostRef, authService.userId!);

  Future<bool> get getUserPostSaveState async => await postManager
      .userPostSaveState(postModel.postId, authService.userId!);

  @action
  Future like() async {
    if (likeLock) return;
    changeLikeLockState();
    if (await getUserLikeState) {
      likeIcon = likedIcon;
      bool isPostLiked = await postManager.likePost(
          currentPostRef, currentTime, postModel.postId);
      await sendLikeNotification();
      if (!isPostLiked) likeIcon = unlikedIcon;
    } else {
      likeIcon = unlikedIcon;
      bool isPostUnliked = await postManager.unlikePost(
          currentPostRef, authService.userId!, postModel.postId);
      if (!isPostUnliked) likeIcon = likedIcon;
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
      sharedPostRef: currentPostRef.path,
    );
    if (await getUserPostSaveState) {
      postSaveIcon = savedIcon;
      var response = await postManager.savePost(model);
      if (!response) postSaveIcon = unsavedIcon;
    } else {
      postSaveIcon = unsavedIcon;
      var response = await postManager.unsavePost(model);
      if (!response) postSaveIcon = savedIcon;
    }
    changePostSaveLockState();
  }

  @action
  Future delete(bool isAComment) async {
    var deleteResponse = await postManager.delete(currentPostRef);
    if (deleteResponse.errorMessage != null) {
      showPostNotDeletedAlert();
      return;
    }
    isPostDeleted = true;
    showToast("Post deleted");
  }

  void showPostNotDeletedAlert() => showAlert(
        'Error Message1',
        'Post could not be deleted. Please try again.',
        context: context!,
      );

  DocumentReference findACommentPathFromComments(int index) => currentPostRef
      .collection(firebaseConstants.postCommentsText)
      .doc(comments[index].postId);

  void findCommentsPath(String postRef) =>
      currentPostRef = firestore.doc(postRef);

  ScrollController get scrollController {
    var controller = ScrollController();
    controller.addListener(() async {
      if (!canUploadMoreComments) return;
      if (controller.offset >= controller.position.maxScrollExtent) {
        lockScrollable();
        await loadMoreComments();
        openScrollable();
      }
    });
    return controller;
  }

  @action
  Future<List<PostModel>> getComments() async {
    openLoadMoreCommentsState();
    lockScrollable();
    comments.clear();
    var commentsData = await postManager.getPosts(ref: commentsRef);
    if (commentsData.error == null) {
      comments = commentsData.data!;
    }
    openScrollable();
    return comments;
  }

  @action
  Future<void> loadMoreComments() async {
    if (!canUploadMoreComments) return;
    lockScrollable();
    var commentData = await postManager.loadMorePost(ref: commentsRef);
    if (commentData.error == null && commentData.data != null) {
      var loadedComments = commentData.data!;
      loadMoreCommentsLockControl(loadedComments.length);
      for (var comment in loadedComments) {
        comments.add(comment);
      }
    }
    openScrollable();
    return;
  }

  void lockLoadMoreCommentsState() => canUploadMoreComments = false;
  void openLoadMoreCommentsState() => canUploadMoreComments = true;

  void loadMoreCommentsLockControl(int size) {
    if (size < firebaseConstants.numberOfCommentsToBeReceiveAtOnce) {
      lockLoadMoreCommentsState();
    }
  }

  Future<void> addToPostViews() async => await postStatusInformationsManager
      .addToPostViews(currentPostRef, currentTime);

  Future<void> addToPostClicked() async => await postStatusInformationsManager
      .addToPostClicked(currentPostRef, currentTime);

  Future<void> addToProfileVisits() async => await postStatusInformationsManager
      .addToProfileVisits(currentPostRef, currentTime);

  void onPressedImage(
    List<ImageProvider<Object>?> imageProviders,
    List<dynamic> imageUrls,
    int imageIndex,
    String imageTag,
  ) =>
      postViewModelNavigators.onPressedImage(
          imageProviders, imageUrls, imageIndex, imageTag, postModel);

  void navigateToPostStatus(PostViewModel postViewModel) =>
      postViewModelNavigators.navigateToPostStatus(postViewModel, postModel);

  void navigateToFullScreenPostView() => postViewModelNavigators
      .navigateToFullScreenPostView(postModel, currentPostRef);

  void navigateToReplyScreen({
    PostModel? postModel,
    DocumentReference<Object?>? postAddingRef,
  }) =>
      postViewModelNavigators.navigateToReplyScreen(
        postModel ?? this.postModel,
        postAddingRef ?? currentPostRef,
      );

  Future<void> sendLikeNotification() async {
    await notificationSender.sendLikeNotification(
      userModel: userModel!,
      postModel: postModel,
    );
  }
}
