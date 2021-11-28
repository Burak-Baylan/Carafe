import 'package:Carafe/core/firebase/base/firebase_base.dart';
class EmailVerificationService extends FirebaseBase{
  bool get isEmailValid => auth.currentUser!.emailVerified;
  Future<void> get sendVerificationMail async => await auth.currentUser!.sendEmailVerification();
}