import 'package:Carafe/core/firebase/auth/authentication/service/base/base_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
class EmailVerificationService{
  FirebaseAuth auth = FirebaseAuth.instance;
  bool get isEmailValid => auth.currentUser!.emailVerified;
  Future<void> get sendVerificationMail async => await auth.currentUser!.sendEmailVerification();
}