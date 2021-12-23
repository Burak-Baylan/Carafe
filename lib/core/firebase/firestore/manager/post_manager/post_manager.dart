import 'package:Carafe/core/firebase/firestore/manager/post_manager/save_manager.dart';
import 'package:Carafe/pages/main/model/like_model.dart';
import 'package:Carafe/pages/main/model/post_save_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../../pages/main/model/post_model.dart';
import '../../../base/firebase_base.dart';

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

  Future<bool> likePost(String postId, Timestamp currentTime) async =>
      await postLikeManager.likePost(postId, currentTime);

  Future<bool> unlikePost(String postId, String userId) async =>
      await postLikeManager.unlikePost(postId, userId);

  Future<bool> savePost(
    String postId,
    String userId,
    Timestamp currentTime,
  ) async {
    var saveModel = PostSaveModel(
      savedAt: currentTime,
      userId: userId,
      postId: postId,
    );
    return await postSaveManager.savePost(saveModel);
  }

  Future<bool> unsavePost(
    String postId,
    String userId,
    Timestamp currentTime,
  ) async {
    var saveModel = PostSaveModel(
      savedAt: currentTime,
      userId: userId,
      postId: postId,
    );
    return await postSaveManager.unsavePost(saveModel);
  }

  Future<bool> userLikeState(String postId, String userId) async {
    var doc = await firebaseConstants.userLikeStatusPath(postId, userId).get();
    return doc.docs.isEmpty;
  }

  Future<bool> userPostSaveState(String postId, String userId) async {
    var doc = await firebaseConstants.userSaveStatusPath(postId, userId).get();
    return doc.docs.isEmpty;
  }
}
