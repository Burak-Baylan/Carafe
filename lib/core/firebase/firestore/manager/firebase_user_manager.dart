import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../pages/authenticate/model/user_model.dart';
import '../../../../pages/main/model/post_model.dart';
import '../../../data/custom_data.dart';
import '../../../error/custom_error.dart';
import '../../base/firebase_base.dart';

class FirebaseUserManager extends FirebaseBase {
  static FirebaseUserManager? _instance;
  static FirebaseUserManager get instance =>
      _instance = _instance == null ? FirebaseUserManager._init() : _instance!;
  FirebaseUserManager._init();

  Future<CustomError> createUser(UserModel userModel) async {
    var customError = await firebaseService.addDocument(
      firestore.collection(firebaseConstants.usersText).doc(userModel.userId),
      userModel.toJson(),
    );
    return customError;
  }

  Future<CustomError> updateUser(UserModel userModel) async => firebaseService
      .updateDocument(firebaseConstants.userDocRef(userModel.userId), {});

  Future<CustomError> updateFollowersCount(UserModel userModel) async {
    try {
      var ref = firebaseConstants.userDocRef(userModel.userId);
      await firebaseManager.increaseField(
        count: 1,
        documentReference: ref,
        fieldName: firebaseConstants.followersCount,
      );
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomData<String>> userPinnedPostId(String userId) async {
    var customPostModelData = await userPinnedPost(userId);
    if (customPostModelData.error != null) {
      return CustomData(null, CustomError('Something went wrong'));
    }
    return CustomData(customPostModelData.data!.postId, null);
  }

  Future<CustomData<PostModel>> userPinnedPost(String userId) async {
    var pinnedPostRef = firebaseConstants.userPinnedPostDocRef(userId);
    var pinnedPostData = await firebaseService.getDocument(pinnedPostRef);
    if (pinnedPostData.error != null) {
      return CustomData(null, CustomError('Something went wrong'));
    }
    var postIdData = firebaseService.getAField<String>(
        pinnedPostData.data!, firebaseConstants.postIdText);
    if (postIdData.error != null) {
      return CustomData(null, CustomError('Something went wrong'));
    }
    var rawPostData = await firebaseService.getDocument(
        firebaseConstants.allPostsCollectionRef.doc(postIdData.data));
    var postData = rawPostData.data!.data() as Map<String, dynamic>;
    PostModel postModel = PostModel.fromJson(postData);
    return CustomData(postModel, null);
  }
}
