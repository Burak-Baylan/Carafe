import '../../../../../pages/main/model/post_save_model.dart';
import '../../../base/firebase_base.dart';

class PostSaveManager extends FirebaseBase {
  static PostSaveManager? _instance;
  static PostSaveManager get instance =>
      _instance = _instance == null ? PostSaveManager._init() : _instance!;
  PostSaveManager._init();

  Future<bool> savePost(PostSaveModel saveModel) async {
    var ref = firebaseConstants
        .userDocRef(saveModel.userId)
        .collection(firebaseConstants.userSavedPostsText)
        .doc(saveModel.postId);
    var response = await firebaseService.addDocument(ref, saveModel.toJson());
    if (response.errorMessage != null) return false;
    return true;
  }

  Future<bool> unsavePost(PostSaveModel saveModel) async {
    var ref = firebaseConstants
        .userDocRef(saveModel.userId)
        .collection(firebaseConstants.userSavedPostsText)
        .doc(saveModel.postId);
    var response = await firebaseService.deleteDocument(ref);
    if (response.errorMessage != null) return false;
    return true;
  }
}
