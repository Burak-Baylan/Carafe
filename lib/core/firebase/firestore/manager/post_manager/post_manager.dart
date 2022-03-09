import 'package:Carafe/core/firebase/firestore/manager/post_manager/liked_and_saved_posts_getter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../main.dart';
import '../../../../../pages/main/model/pinned_post_model.dart';
import '../../../../../pages/main/model/post_model.dart';
import '../../../../../pages/main/model/post_save_model.dart';
import '../../../../data/custom_data.dart';
import '../../../../error/custom_error.dart';
import '../../../base/firebase_base.dart';

class FirebasePostManager extends FirebaseBase {
  static FirebasePostManager get instance => FirebasePostManager();

  QueryDocumentSnapshot<Map<String, dynamic>>? lastVisiblePost;

  Query<Map<String, dynamic>> get allPostsRef =>
      firebaseConstants.postsCreatedDescending;

  LikedAndSavedPostsGetter likedPostsGetter = LikedAndSavedPostsGetter();

  Future<CustomData<List<PostModel>>> getPosts({
    Query<Map<String, dynamic>>? ref,
  }) async {
    var rawData = await firebaseService.getQuery(ref ?? getPostsRef);
    return prepareData(rawData);
  }

  Future<CustomData<List<PostModel>>> loadMorePost(
      {Query<Map<String, dynamic>>? ref}) async {
    if (lastVisiblePost == null) return errorData;
    var rawData = await firebaseService.getQuery(
        ref?.startAfterDocument(lastVisiblePost!) ?? loadMorePostsRef);
    return prepareData(rawData);
  }

  Query<Map<String, dynamic>> get getPostsRef => allPostsRef
      .limit(firebaseConstants.numberOfPostsToBeReceiveAtOnce)
      .where(firebaseConstants.authorIdText,
          whereIn:
              mainVm.followingUsersIds.isEmpty ? [] : mainVm.followingUsersIds)
      .where(firebaseConstants.isPostDeletedText, isEqualTo: false);

  Query<Map<String, dynamic>> get loadMorePostsRef => allPostsRef
      .startAfterDocument(lastVisiblePost!)
      .where(firebaseConstants.authorIdText, whereIn: mainVm.followingUsersIds)
      .limit(firebaseConstants.numberOfPostsToBeReceiveAtOnce)
      .where(firebaseConstants.isPostDeletedText, isEqualTo: false);

  List<PostModel> getModels(QuerySnapshot<Map<String, dynamic>> dataList) {
    List<PostModel> models = [];
    int i = 0;
    for (var doc in dataList.docs) {
      i++;
      var data = PostModel.fromJson(doc.data());
      models.add(data);
      if (dataList.docs.length == i) {
        lastVisiblePost = dataList.docs[dataList.docs.length - 1];
      }
    }
    return models;
  }

  Future<bool> likePost(DocumentReference docRef, Timestamp currentTime,
          String postId) async =>
      await postLikeManager.likePost(docRef, currentTime, postId);

  Future<bool> unlikePost(
          DocumentReference docRef, String userId, String postId) async =>
      await postLikeManager.unlikePost(docRef, postId);

  Future<bool> savePost(PostSaveModel postSaveModel) async =>
      await postSaveManager.savePost(postSaveModel);

  Future<bool> unsavePost(PostSaveModel postSaveModel) async =>
      await postSaveManager.unsavePost(postSaveModel);

  Future<bool> userLikeState(DocumentReference docRef, String userId) async {
    var doc = await firebaseConstants.userLikeStatusPath(docRef, userId).get();
    return doc.docs.isEmpty;
  }

  Future<bool> userPostSaveState(String postId, String userId) async {
    var doc = await firebaseConstants.userSaveStatusPath(postId, userId).get();
    return doc.docs.isEmpty;
  }

  Future<CustomData<bool>> userPinnedPostState(
      String postOwnerId, String postId) async {
    var path = firebaseConstants.userPinnedPostControlRef(postOwnerId, postId);
    var data = await firebaseService.getQuery(path);
    if (data.error != null) return CustomData(null, CustomError(""));
    if (data.data!.docs.isEmpty) {
      return CustomData(true, null);
    } else {
      return CustomData(false, null);
    }
  }

  Future<bool> pinPostToProfile(
      Timestamp currentTime, PostModel postModel) async {
    var userId = auth.currentUser!.uid;
    var ref = firebaseConstants.userPinnedPostCollectionRef(userId).doc(userId);
    var pinnedPostModel = PinnedPostModel(
      authorId: userId,
      createdAt: currentTime,
      postId: postModel.postId,
      pinnedPostPath: postModel.postPath,
    );
    var savePostResponse =
        await firebaseService.addDocument(ref, pinnedPostModel.toJson());
    if (savePostResponse.errorMessage != null) return false;
    return true;
  }

  Future<bool> unpinPostFromProfile() async {
    var userId = auth.currentUser!.uid;
    var ref = firebaseConstants.userPinnedPostDocRef(userId);
    var response = await firebaseService.deleteDocument(ref);
    if (response.errorMessage != null) return false;
    return true;
  }

  CustomData<List<PostModel>> prepareData(CustomData rawData) {
    if (rawData.error != null) {
      return errorData;
    } else {
      return CustomData(getModels(rawData.data), null);
    }
  }

  Future<void> addToPostCollection(DocumentReference ref, Object? data) async =>
      await firestoreService.addDocument(ref, data);

  Future<CustomError> delete(DocumentReference postRef) async =>
      await postDeleter.delete(postRef);

  Future<int> getPostCommentsCount(DocumentReference postRef) async {
    var response = await firebaseService
        .getQuery(firebaseConstants.allUndeletedCommentsCollection(postRef));
    if (response.error != null) {
      return 0;
    }
    return response.data!.size;
  }

  Future<int> getPostLikeCount(DocumentReference ref) async {
    var response = await firebaseService
        .getCollection(ref.collection(firebaseConstants.postLikersText));
    if (response.error != null) {
      return 0;
    }
    return response.data!.size;
  }

  CustomData<List<PostModel>> get errorData =>
      CustomData(null, CustomError("Something went wrong. Please try again."));
}
