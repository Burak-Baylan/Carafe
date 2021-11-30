import 'package:Carafe/core/error/custom_error.dart';
import 'package:Carafe/app/models/user_model.dart';
import 'package:Carafe/core/firebase/base/firebase_base.dart';
import 'package:Carafe/core/firebase/firestore/service/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserService extends FirebaseBase {
  static FirebaseUserService? _instance;
  static FirebaseUserService get instance =>
      _instance = _instance == null ? FirebaseUserService._init() : _instance!;
  FirebaseUserService._init();

  Future<CustomError> createUser(UserModel userModel) async {
    try {
      await firestore.collection("Users").doc(userModel.user.uid).set({
        'uid': userModel.user.uid,
        'profileDescription': userModel.profileDescription,
        'createdAt': userModel.createdAt,
        'profilePrivacy': userModel.profilePrivacy,
        'followersCount': userModel.followersCount,
        'followingCount': userModel.followingCount,
        'verified': userModel.verified,
        'profilePhotoBackgroundColor':
            userModel.profilePhotoBackgroundColor.toString(),
        'notifications': userModel.notifications,
      });
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomError> updateUser(UserModel userModel) async {
    try {
      await firestore.collection("Users").doc(userModel.user.uid).update({});
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomError> updateFollowersCount(UserModel userModel) async {
    try {
      var ref = firestore.collection("Users").doc(userModel.user.uid);
      await firebaseManager.increaseField(
        count: 1,
        documentReference: ref,
        fieldName: 'followersCount',
      );
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }
}
