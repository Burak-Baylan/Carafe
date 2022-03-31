import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../../../../app/notification/notification_sender_by_type.dart';
import '../../../../main.dart';
import '../../../../pages/authenticate/model/follow_user_model.dart';
import '../../../../pages/authenticate/model/user_model.dart';
import '../../../../pages/main/model/pinned_post_model.dart';
import '../../../../pages/main/model/post_model.dart';
import '../../../../pages/main/model/verification_request_model.dart';
import '../../../data/custom_data.dart';
import '../../../error/custom_error.dart';
import '../../base/firebase_base.dart';

class FirebaseUserManager extends FirebaseBase {
  static FirebaseUserManager? _instance;
  static FirebaseUserManager get instance =>
      _instance = _instance == null ? FirebaseUserManager._init() : _instance!;
  FirebaseUserManager._init();

  String get currentUserId => authService.userId!;
  NotificationSenderByType notificatSender = NotificationSenderByType();

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

  Future<CustomData<PostModel>> userPinnedPost(String userId) async {
    var pinnedPostRef = firebaseConstants.userPinnedPostDocRef(userId);
    var pinnedPostData = await firebaseService.getDocument(pinnedPostRef);
    if (pinnedPostData.error != null || pinnedPostData.data?.data() == null) {
      return CustomData(null, CustomError('Something went wrong'));
    }
    var pinnedPostModel = PinnedPostModel.fromJson(
        pinnedPostData.data!.data() as Map<String, dynamic>);
    var rawPostData = await firebaseService
        .getDocument(firestore.doc(pinnedPostModel.pinnedPostPath));
    if (rawPostData.error != null || rawPostData.data?.data() == null) {
      return CustomData(null, CustomError('Something went wrong'));
    }
    var postData = rawPostData.data!.data() as Map<String, dynamic>;
    PostModel postModel = PostModel.fromJson(postData);
    if (postModel.isPostDeleted != null && (postModel.isPostDeleted!)) {
      return CustomData(null, CustomError('Pinned post deleted'));
    }
    return CustomData(postModel, null);
  }

  Future<CustomData<bool>> followingState(String followingUserId) async {
    var path = firebaseConstants.userFollowingControlRef(
        currentUserId, followingUserId);
    var data = await firebaseService.getQuery(path);
    if (data.error != null) return CustomData(null, CustomError(""));
    if (data.data!.docs.isEmpty) {
      return CustomData(false, null);
    } else {
      return CustomData(true, null);
    }
  }

  Future<bool> followUser(UserModel userModel, Timestamp currentTime) async {
    var userId = userModel.userId;
    var followersUserFollowingRef =
        firebaseConstants.userFollowingCollectionRef(currentUserId).doc(userId);
    var followingUserFollowersRef =
        firebaseConstants.userFollowersCollectionRef(userId).doc(currentUserId);
    var data = FollowUserModel(
      followerUserId: currentUserId,
      followingUserId: userId,
      followedAt: currentTime,
    ).toJson();
    mainVm.addToFollowing(userId);
    var response =
        await firebaseService.addDocument(followersUserFollowingRef, data);
    var response2 =
        await firebaseService.addDocument(followingUserFollowersRef, data);
    if (response.errorMessage != null || response2.errorMessage != null) {
      await unfollowUser(userId);
      return false;
    }
    await notificatSender.sendFollowNotification(userModel: userModel);
    return true;
  }

  Future<bool> unfollowUser(String unfollowingUserId) async {
    var unfollowerUserFollowingRef = firebaseConstants
        .userFollowingCollectionRef(currentUserId)
        .doc(unfollowingUserId);
    var unfollowingUserFollowersRef = firebaseConstants
        .userFollowersCollectionRef(unfollowingUserId)
        .doc(currentUserId);
    mainVm.removeFromFollowing(unfollowingUserId);
    var response =
        await firebaseService.deleteDocument(unfollowerUserFollowingRef);
    var response2 =
        await firestoreService.deleteDocument(unfollowingUserFollowersRef);
    if (response.errorMessage != null || response2.errorMessage != null) false;
    return true;
  }

  Future<int?> getCurrentUserFollowersCount() async =>
      await getAUserFollowersCount(currentUserId);

  Future<int?> getCurrentUserFollowingCount() async =>
      await getAUserFollowingCount(currentUserId);

  Future<int?> getAUserFollowersCount(String userId) async {
    var ref = firebaseConstants.userFollowersCollectionRef(userId);
    var data = await firebaseService.getCollection(ref);
    if (data.error != null) {
      return null;
    }
    return data.data!.size;
  }

  Future<int?> getAUserFollowingCount(String userId) async {
    var ref = firebaseConstants.userFollowingCollectionRef(userId);
    var data = await firebaseService.getCollection(ref);
    if (data.error != null) {
      return null;
    }
    return data.data!.size;
  }

  Future<bool> updateCurrentUserDisplayName(String newDisplayName) async =>
      updateAField(
          fieldName: firebaseConstants.displayNameText, value: newDisplayName);

  Future<bool> updateCurrentUserDescription(String newDescription) async =>
      updateAField(
          fieldName: firebaseConstants.profileDescriptionText,
          value: newDescription);

  Future<bool> updateCurrentUserWebsite(String newWebsiteUrl) async =>
      await updateAField(
          fieldName: firebaseConstants.websiteText, value: newWebsiteUrl);

  Future<bool> updateCurrentUserBirthDate(Timestamp date) async =>
      await updateAField(
        fieldName: firebaseConstants.birthDateText,
        value: date,
      );

  Future<bool> updateUserProfilePhoto(File image) async {
    String path = "users/$currentUserId/profilePhoto/pp";
    var photoUploadResponse = await storageService.upload(path, image);
    if (photoUploadResponse.errorMessage != null) {
      return false;
    }
    var imageLink = await storageService.getDownloadUrl(path);
    if (imageLink == null) {
      await storageService.delete(path);
      return false;
    }
    var fileUpdateResponse = await updateAField(
        fieldName: firebaseConstants.ppUrlText, value: imageLink);
    if (!fileUpdateResponse) {
      await storageService.delete(path);
      return false;
    }
    return true;
  }

  Future<List<String>?> getFollowingUsersIds() async {
    List<String> followingUsersIds = [];
    var ref = firebaseConstants.userFollowingCollectionRef(authService.userId!);
    var rawData = await firebaseService.getCollection(ref);
    if (rawData.error != null) return null;
    followingUsersIds.add(authService.userId!);
    for (var doc in rawData.data!.docs) {
      var data = FollowUserModel.fromJson(doc.data());
      followingUsersIds.add(data.followingUserId);
    }
    mainVm.updateFollowingUserIds(followingUsersIds);
    return followingUsersIds;
  }

  Future<bool> updateAField({
    required String fieldName,
    required Object? value,
  }) async {
    var ref = firebaseConstants.allUsersCollectionRef.doc(currentUserId);
    var response =
        await firebaseService.updateDocument(ref, {fieldName: value});
    if (response.errorMessage != null) {
      return false;
    }
    return true;
  }

  Future<String?> getUserCurrentToken() async {
    var userModel = await firebaseManager.getAUserInformation(currentUserId);
    return userModel?.token;
  }

  Future<String?> getUserToken() async {
    return await FirebaseMessaging.instance.getToken();
  }

  Future<bool> updateUserToken(String? token) async {
    String? newToken;
    if (token != null) {
      newToken = token;
    }
    newToken = await getUserToken();
    if (newToken == null) return false;
    String tokenText = firebaseConstants.tokenText;
    bool response = await updateAField(fieldName: tokenText, value: newToken);
    return response;
  }

  Future<bool> removeUserToken() async {
    String tokenText = firebaseConstants.tokenText;
    bool response = await updateAField(fieldName: tokenText, value: null);
    return response;
  }

  Future<bool> getUserNotificationStatus(String userId) async {
    UserModel? userModel = await firebaseManager.getAUserInformation(userId);
    if (userModel == null) return true;
    return userModel.notifications;
  }

  Future<bool> updateUserNotificationStatus(bool value) async {
    var response = await updateAField(
      fieldName: firebaseConstants.notificationsText,
      value: value,
    );
    return response;
  }

  Future<bool> openUserNotificaitons() async {
    var response = await updateUserNotificationStatus(true);
    return response;
  }

  Future<bool> closeUserNotifications() async {
    var response = await updateUserNotificationStatus(false);
    return response;
  }

  Future<CustomError> sendVerificationRequest() async {
    var ref = firebaseConstants.verificationRequestsRef.doc(currentUserId);
    var model = VerificationRequestModel(
      authorId: currentUserId,
      createdAt: mainVm.currentTime,
    );
    var jsonData = model.toJson();
    var response = await firebaseService.addDocument(ref, jsonData);
    return response;
  }
}
