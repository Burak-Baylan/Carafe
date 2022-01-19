import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../pages/authenticate/model/follow_user_model.dart';
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
    var userExistingControlResponse = await checkUsernameExisting(userModel);
    if (userExistingControlResponse.errorMessage != null) {
      return userExistingControlResponse;
    }
    var customError = await firebaseService.addDocument(
      firestore.collection(firebaseConstants.usersText).doc(userModel.userId),
      userModel.toJson(),
    );
    return customError;
  }

  Future<CustomError> checkUsernameExisting(UserModel userModel) async {
    var query = firebaseConstants.allUsersCollectionRef
        .where(firebaseConstants.usernameText, isEqualTo: userModel.username);
    var data = await firebaseService.getQuery(query);
    if (data.error != null) {
      return CustomError("An error occured. Please try again.");
    }
    if (data.data!.size > 0) {
      return CustomError('This username is already in use.');
    }
    return CustomError(null);
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

  Future<CustomData<bool>> followingState(String followingUserId) async {
    String currentUserId = authService.userId!;
    var path = firebaseConstants.userFollowingControlRef(
        currentUserId, followingUserId);
    var data = await firebaseService.getQuery(path);
    if (data.error != null) return CustomData(null, CustomError(""));
    if (data.data!.docs.isEmpty) {
      return CustomData(true, null);
    } else {
      return CustomData(false, null);
    }
  }

  Future<bool> followUser(String followingUserId, Timestamp currentTime) async {
    var currentUserId = authService.userId;
    var followUserRef = firebaseConstants
        .userFollowingCollectionRef(currentUserId!)
        .doc(followingUserId);
    var data = FollowUserModel(
            followerUserId: currentUserId,
            followingUserId: followingUserId,
            followedAt: currentTime)
        .toJson();
    var response = await firebaseService.addDocument(followUserRef, data);
    if (response.errorMessage != null) false;
    return true;
  }

  Future<bool> unfollowUser(String unfollowingUserId) async {
    var currentUserId = authService.userId;
    var unfollowUserRef = firebaseConstants
        .userFollowingCollectionRef(currentUserId!)
        .doc(unfollowingUserId);
    var response = await firebaseService.deleteDocument(unfollowUserRef);
    if (response.errorMessage != null) false;
    return true;
  }
}
