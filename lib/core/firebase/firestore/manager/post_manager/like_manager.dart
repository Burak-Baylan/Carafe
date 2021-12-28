import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../pages/main/model/like_model.dart';
import '../../../../error/custom_error.dart';
import '../../../base/firebase_base.dart';

class PostLikeManager extends FirebaseBase {
  static PostLikeManager? _instance;
  static PostLikeManager get instance =>
      _instance = _instance == null ? PostLikeManager._init() : _instance!;
  PostLikeManager._init();

  late String userId;
  late String postId;

  Map<String, dynamic> _getLikeJson(Timestamp currentTime) =>
      LikeModel(authorId: userId, createdAt: currentTime).toJson();

  Future<bool> likePost(String postId, Timestamp currentTime) async {
    userId = authService.userId.toString();
    this.postId = postId;
    var postsDocRef = firebaseConstants.postDocRef(postId);
    await _incraseLike(postsDocRef);
    Map<String, dynamic> json = _getLikeJson(currentTime);
    var addRespones = await firebaseService.addDocument(_likeRef, json);
    return await _controlResponse(addRespones, _likeRef);
  }

  Future<bool> _controlResponse(
      CustomError response, DocumentReference ref) async {
    if (response.errorMessage != null) {
      var deleteResponse = await _deleteLikeFromFirebase();
      if (deleteResponse.errorMessage == null) await _decraseLike(ref);
      return false;
    }
    return true;
  }

  Future<bool> unlikePost(String postId, String userId) async {
    userId = authService.userId.toString();
    this.postId = postId;
    var postsDocRef = firebaseConstants.postDocRef(postId);
    await _decraseLike(postsDocRef);
    var deleteResponse = await _deleteLikeFromFirebase();
    if (deleteResponse.errorMessage != null) {
      await _incraseLike(postsDocRef);
      return false;
    }
    return true;
  }

  DocumentReference get _likeRef => firebaseConstants.allPostsCollectionRef
      .doc(postId)
      .collection(firebaseConstants.postLikersText)
      .doc(userId);

  Future<CustomError> _deleteLikeFromFirebase() async =>
      await firebaseService.deleteDocument(
          firebaseConstants.postLikesCollectionRef(postId).doc(userId));

  Future _decraseLike(DocumentReference ref) async =>
      await firebaseManager.decraseField(
        documentReference: ref,
        fieldName: firebaseConstants.likeCountText,
      );

  Future _incraseLike(DocumentReference ref) async =>
      await firebaseManager.increaseField(
        documentReference: ref,
        fieldName: firebaseConstants.likeCountText,
      );
}
