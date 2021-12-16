import 'package:Carafe/core/firebase/auth/email_verification/email_vericifaciton_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/base/view_model/base_view_model.dart';
import 'authenticate_view_model.dart';

abstract class IAuthenticationViewModel extends BaseViewModel {
  BuildContext? context;
  AuthenticateViewModel authVm = AuthenticateViewModel();
  EmailVerificationService emailVerificationService = EmailVerificationService();
  FirebaseAuth auth = FirebaseAuth.instance;
  void changeTabIndex(int index);
  @override
  setContext(BuildContext context);

  bool get isEmailVerified => emailVerificationService.isEmailValid;
  Future<void> sendVerificationMail() async => await emailVerificationService.sendVerificationMail;
}
