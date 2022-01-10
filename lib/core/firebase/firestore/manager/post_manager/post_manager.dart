import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../pages/main/model/pinned_post_model.dart';
import '../../../../../pages/main/model/post_model.dart';
import '../../../../../pages/main/model/post_save_model.dart';
import '../../../../data/custom_data.dart';
import '../../../../error/custom_error.dart';
import '../../../base/firebase_base.dart';

class FirebasePostManager extends FirebaseBase {
  static FirebasePostManager? _instance;
  static FirebasePostManager get instance =>
      _instance = _instance == null ? FirebasePostManager._init() : _instance!;
  FirebasePostManager._init();

  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisiblePost;

  Query<Map<String, dynamic>> get allPostsRef =>
      firebaseConstants.postsCreatedDescending;

  var numberOfPostsToBeUploadedAtOnce = 0;

  Future<List<PostModel>> getPosts() async {
    var dataList = await allPostsRef
        .limit(firebaseConstants.numberOfPostsToBeUploadedAtOnce)
        .get();
    return getModels(dataList);
  }

  Future<List<PostModel>> loadMorePost() async {
    var dataList = await allPostsRef
        .startAfterDocument(lastVisiblePost)
        .limit(firebaseConstants.numberOfPostsToBeUploadedAtOnce)
        .get();
    return getModels(dataList);
  }

  List<PostModel> getModels(QuerySnapshot<Map<String, dynamic>> dataList,
      {bool isAComment = false}) {
    List<PostModel> models = [];
    int i = 0;
    for (var doc in dataList.docs) {
      i++;
      var data = PostModel.fromJson(doc.data());
      models.add(data);
      if (dataList.docs.length == i) {
        if (isAComment) {
          lastVisibleComment = dataList.docs[dataList.docs.length - 1];
        } else {
          lastVisiblePost = dataList.docs[dataList.docs.length - 1];
        }
      }
    }
    return models;
  }

  Future<bool> likePost(
          DocumentReference docRef, Timestamp currentTime) async =>
      await postLikeManager.likePost(docRef, currentTime);

  Future<bool> unlikePost(DocumentReference docRef, String userId) async =>
      await postLikeManager.unlikePost(docRef);

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

  Future<bool> pinPostToProfile(Timestamp currentTime, String postId) async {
    var userId = auth.currentUser!.uid;
    var ref = firebaseConstants.userPinnedPostCollectionRef(userId).doc(userId);
    var pinnedPostModel = PinnedPostModel(
        authorId: userId, createdAt: currentTime, postId: postId);
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

  QueryDocumentSnapshot<Map<String, dynamic>>? lastVisibleComment;

  //! service
  Future<CustomData<List<PostModel>>> getComments(
      CollectionReference<Map<String, dynamic>> postCommentsRef) async {
    firebaseConstants.getCommentsWithLimit(postCommentsRef);
    CustomData rawData = await firebaseService
        .getQuery(firebaseConstants.getCommentsWithLimit(postCommentsRef));
    return prepareData(rawData);
  }

  Future<CustomData<List<PostModel>>> loadMoreComment(
      DocumentReference postCommentsRef) async {
    if (lastVisibleComment == null) return CustomData(null, CustomError(""));
    CustomData rawData = await firebaseService.getQuery(
        firebaseConstants.getCommentsWithLimitStartAfterDocumentsRef(
            lastVisibleComment, postCommentsRef));
    return prepareData(rawData);
  }

  CustomData<List<PostModel>> prepareData(CustomData rawData) {
    if (rawData.error != null) {
      return CustomData(null, CustomError(rawData.error!.errorMessage));
    } else {
      return CustomData(getModels(rawData.data, isAComment: true), null);
    }
  }
}
