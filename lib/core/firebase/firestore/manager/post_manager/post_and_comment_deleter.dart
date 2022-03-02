import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../error/custom_error.dart';
import '../../../base/firebase_base.dart';

class PostAndCommentDeleter with FirebaseBase {
  static PostAndCommentDeleter? _instance;
  static PostAndCommentDeleter get instance => _instance =
      _instance == null ? PostAndCommentDeleter._init() : _instance!;
  PostAndCommentDeleter._init();

  Future<CustomError> delete(
    DocumentReference postRef
  ) async {
    var deletePostResponse = await firebaseManager
        .update(postRef, {firebaseConstants.isPostDeletedText: true});

    if (deletePostResponse.errorMessage != null) {
      return deletePostResponse;
    }
    return CustomError(null);
  }
}
