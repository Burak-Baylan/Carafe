import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../pages/main/model/like_model.dart';
import '../../../../pages/main/model/post_model.dart';
import '../../base/firebase_base.dart';

class FirebasePostManager extends FirebaseBase {
  static FirebasePostManager? _instance;
  static FirebasePostManager get instance =>
      _instance = _instance == null ? FirebasePostManager._init() : _instance!;
  FirebasePostManager._init();

  late String lastPostId;

  var numberOfPostsToBeUploadedAtOnce = 0;

  Future<List<PostModel>> getPosts() async {
    var ref = firebaseConstants.postsCreatedDescending;
    var dataList = await ref
        .limit(firebaseConstants.numberOfPostsToBeUploadedAtOnce)
        .get();
    return getModels(dataList);
  }

  Future<List<PostModel>> loadMorePost() async {
    var lastVisibleRef = await firestore
        .collection(firebaseConstants.postsText)
        .where(firebaseConstants.postIdText, isEqualTo: lastPostId)
        .limit(firebaseConstants.numberOfPostsToBeUploadedAtOnce)
        .get();
    var lastVisible = lastVisibleRef.docs[lastVisibleRef.size - 1];
    var dataList = await firestore
        .collection(firebaseConstants.postsText)
        .orderBy(firebaseConstants.createdAtText, descending: true)
        .startAfterDocument(lastVisible)
        .limit(firebaseConstants.numberOfPostsToBeUploadedAtOnce)
        .get();
    return getModels(dataList);
  }

  List<PostModel> getModels(QuerySnapshot<Map<String, dynamic>> dataList) {
    List<PostModel> models = [];
    int i = 0;
    for (var doc in dataList.docs) {
      i++;
      var data = PostModel.fromJson(doc.data());
      models.add(data);
      if (dataList.docs.length == i) {
        lastPostId = data.postId;
      }
    }
    return models;
  }

  Future likePost(
    String postId,
    Timestamp currentTime,
    String likeId,
  ) async {
    await firebaseManager.increaseField(
      documentReference: firebaseConstants.postDocRef(postId),
      fieldName: firebaseConstants.likeCountText,
    );
    String userId = authService.userId.toString();
    Map<String, dynamic> json =
        LikeModel(authorId: userId, createdAt: currentTime).toJson();
    var ref = firebaseConstants.allPostsCollectionRef
        .doc(postId)
        .collection(firebaseConstants.postLikersText)
        .doc(userId);
    firebaseService.addDocument(ref, json);
  }

  Future unlikePost(String postId, String userId) async {
    var postsDocRef = firebaseConstants.postDocRef(postId);
    await firebaseManager.decraseField(
      documentReference: postsDocRef,
      fieldName: firebaseConstants.likeCountText,
    );
    var response = await firebaseService.deleteDocument(
        firebaseConstants.postLikesCollectionRef(postId).doc(userId));
    if (response.errorMessage != null) {
      await firebaseManager.increaseField(
        documentReference: postsDocRef,
        fieldName: firebaseConstants.likeCountText,
      );
    }
  }

  Future<bool> userLikeState(String postId, String userId) async {
    var doc = await firebaseConstants.userLikeStatusPath(postId, userId).get();
    return doc.docs.isEmpty;
  }
}
