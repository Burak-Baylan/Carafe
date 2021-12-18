import 'package:flutter/material.dart';

import '../../../core/base/view_model/base_view_model.dart';
import 'authenticate_view_model.dart';

abstract class IAuthenticationViewModel extends BaseViewModel {
  @override
  BuildContext? context;
  void changeTabIndex(int index);
  @override
  setContext(BuildContext context);

  AuthenticateViewModel authVm = AuthenticateViewModel();

  bool get isEmailVerified => authService.isEmailValid!;
  Future<void> sendVerificationMail() async =>
      await authService.sendVerificationEmail(authService.currentUser!);
}
