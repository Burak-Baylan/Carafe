import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../pages/main/model/post_model.dart';
import '../../../../../pages/main/model/post_save_model.dart';
import '../../../base/firebase_base.dart';

class FirebasePostManager extends FirebaseBase {
  static FirebasePostManager? _instance;
  static FirebasePostManager get instance =>
      _instance = _instance == null ? FirebasePostManager._init() : _instance!;
  FirebasePostManager._init();

  late QueryDocumentSnapshot<Map<String, dynamic>> lastVisiblePost;

  Query<Map<String, dynamic>> get allPostsRef => firebaseConstants.postsCreatedDescending;

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
