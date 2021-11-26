import 'package:Carafe/core/error/custom_error.dart';
import 'package:Carafe/core/firebase/base/firebase_base.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordService extends FirebaseBase {
  static ForgotPasswordService? _instance;
  static ForgotPasswordService get instance => _instance =
      _instance == null ? ForgotPasswordService._init() : _instance!;
  ForgotPasswordService._init();

  Future<CustomError> send(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return CustomError(null);
    } on FirebaseException catch (e) {
      return CustomError(e.message);
    }
  }
}
