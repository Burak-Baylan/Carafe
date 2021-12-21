import 'package:Carafe/pages/authenticate/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../error/custom_error.dart';
import '../../base/firebase_base.dart';

class FirebaseUserManager extends FirebaseBase {
  static FirebaseUserManager? _instance;
  static FirebaseUserManager get instance =>
      _instance = _instance == null ? FirebaseUserManager._init() : _instance!;
  FirebaseUserManager._init();

  Future<CustomError> createUser(UserModel userModel) async {
    try {
      await firebaseService.addDocument(
        firestore.collection(firebaseConstants.usersText).doc(userModel.userId),
        userModel.toJson(),
      );
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
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
}
