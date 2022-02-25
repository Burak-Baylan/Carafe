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

  Map<String, dynamic> _getLikeJson(
          DocumentReference ref, Timestamp currentTime, String postId) =>
      LikeModel(
              authorId: userId,
              postId: postId,
              createdAt: currentTime,
              likedPostRefPath: ref.path)
          .toJson();

  Future<bool> likePost(
    DocumentReference docRef,
    Timestamp currentTime,
    String postId,
  ) async {
    userId = authService.userId.toString();
    await _incraseLike(docRef);
    Map<String, dynamic> likeJson = _getLikeJson(docRef, currentTime, postId);
    var addRespones =
        await firebaseService.addDocument(_likeRef(docRef), likeJson);
    await firebaseService.addDocument(
        firebaseConstants.currentUserLikedPostsCollectionRef.doc(postId),
        likeJson);
    return await _controlResponse(addRespones, _likeRef(docRef));
  }

  Future<bool> _controlResponse(
      CustomError response, DocumentReference ref) async {
    if (response.errorMessage != null) {
      var deleteResponse = await _deleteLikeFromFirebase(ref);
      if (deleteResponse.errorMessage == null) await _decraseLike(ref);
      return false;
    }
    return true;
  }

  Future<bool> unlikePost(DocumentReference ref, String postId) async {
    userId = authService.userId.toString();
    await _decraseLike(ref);
    await firebaseService.deleteDocument(
        firebaseConstants.currentUserLikedPostsCollectionRef.doc(postId));
    var deleteResponse = await _deleteLikeFromFirebase(ref);
    if (deleteResponse.errorMessage != null) {
      await _incraseLike(ref);
      return false;
    }
    return true;
  }

  DocumentReference _likeRef(DocumentReference docRef) =>
      firebaseConstants.postLikesCollectionRef(docRef).doc(userId);

  Future<CustomError> _deleteLikeFromFirebase(DocumentReference docRef) async =>
      await firebaseService.deleteDocument(
          firebaseConstants.postLikesCollectionRef(docRef).doc(userId));

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
