import 'package:Carafe/core/error/custom_error.dart';
import 'package:Carafe/core/firebase/auth/model/user_model.dart';
import 'package:Carafe/core/firebase/base/firebase_base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserService extends FirebaseBase {
  static FirebaseUserService? _instance;
  static FirebaseUserService get instance =>
      _instance = _instance == null ? FirebaseUserService._init() : _instance!;
  FirebaseUserService._init();

  Future<CustomError> createUser(UserModel userModel) async {
    try {
      await firestore.collection("Users").doc(userModel.user!.uid).set({
        'uid': userModel.user!.uid,
        'username': userModel.username,
        'email': userModel.email,
        'profilePhotoUrl': userModel.profilePhotoUrl,
      });
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }
}
