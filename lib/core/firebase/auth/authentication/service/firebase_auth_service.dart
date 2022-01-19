import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../pages/authenticate/view/login/model/login_model.dart';
import '../../../../data/custom_data.dart';
import '../../../../error/custom_error.dart';
import '../../../base/firebase_base.dart';

class FirebaseAuthService extends FirebaseBase {
  static FirebaseAuthService? _instance;
  static FirebaseAuthService get instance =>
      _instance = _instance == null ? FirebaseAuthService._init() : _instance!;
  FirebaseAuthService._init();

  User? get currentUser => auth.currentUser;
  String? get username => currentUser?.displayName;
  String? get ppUrl => currentUser?.photoURL;
  String? get userId => currentUser?.uid;
  String? get email => currentUser?.email;
  bool? get isEmailValid => currentUser?.emailVerified;

  Future<CustomData<UserCredential>> login(LoginModel loginModel) async {
    try {
      UserCredential? userCredential = await auth.signInWithEmailAndPassword(
        email: loginModel.email!,
        password: loginModel.password!,
      );
      return CustomData<UserCredential>(userCredential, null);
    } on FirebaseException catch (e) {
      return CustomData<UserCredential>(null, CustomError(e.message));
    }
  }

  Future<CustomData<UserCredential>> signup(LoginModel loginModel) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: loginModel.email!,
        password: loginModel.password!,
      );
      await userCredential.user!.updateDisplayName(loginModel.username);
      return CustomData<UserCredential>(userCredential, null);
    } on FirebaseException catch (e) {
      return CustomData<UserCredential>(null, CustomError(e.message));
    }
  }

  Future<CustomError> deleteUser(User user) async {
    try {
      await user.delete();
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<CustomError> sendPasswordResetEmail(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }

  Future<void> sendVerificationEmail() async =>
      await currentUser?.sendEmailVerification();
}
