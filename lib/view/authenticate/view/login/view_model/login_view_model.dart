// ignore_for_file: override_on_non_overriding_member

import 'package:Carafe/core/constants/navigation/navigation_constants.dart';
import 'package:Carafe/core/firebase/auth/authentication/response/authentication_response.dart';
import 'package:Carafe/core/firebase/auth/authentication/service/firebase_auth_service.dart';
import 'package:Carafe/core/init/navigation/service/navigation_service.dart';
import 'package:Carafe/core/widgets/custom_alert_dialog.dart';
import 'package:Carafe/view/authenticate/view/login/model/login_model.dart';
import 'package:Carafe/view/authenticate/view_model/base_authentication_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase extends IAuthenticationViewModel with Store {

  BuildContext? context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passworController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @observable
  bool emailTextInputLock = false;
  @observable
  bool passwordTextInputLock = false;

  @override
  setContext(BuildContext context) => this.context = context;

  @action
  loginControl() async {
    if (!formKey.currentState!.validate()) {
      changeInputState();
      return;
    }
    removeTextInputFocus();
    await _login();
    changeInputState();
  }

  _login() async {
    _initializeCredenticial();
    await FirebaseAuthService.instance
        .login(LoginModel(email: email, password: password))
        .then((value) {
      _responseControl(value);
    });
  }

  _initializeCredenticial() {
    email = emailController.text.trim();
    password = passworController.text.trim();
  }

  _responseControl(AuthnenticationResponse response) async {
    if (response.error != null) {
      _showAlert(
        "Error",
        response.error!.message.toString(),
        disablePositiveButton: true,
      );
      return;
    }
    _emailValidateControl();
  }

  _emailValidateControl() async {
    if (isEmailVerified) {
      NavigationService.instance.navigateToPage(
        path: NavigationConstans.MAIN_VIEW,
        data: null,
      );
    } else {
      _showAlert(
        "Error",
        "Email not verified. Please verified your email.",
        positiveButtonText: "Send mail",
        negativeButtonText: "Cancel",
        onPressedPositiveButton: () async {
          await sendVerificationMail();
          await auth.signOut();
        },
      );
    }
  }

  @override
  @action
  changeTabIndex(int index) => authVm.changeTabIndex(index);

  @action
  changeInputState() {
    emailTextInputLock = !emailTextInputLock;
    passwordTextInputLock = !passwordTextInputLock;
  }

  @action
  removeTextInputFocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  _showAlert(
    String title,
    String message, {
    bool disableNegativeButton = false,
    bool disablePositiveButton = false,
    String? positiveButtonText,
    String? negativeButtonText,
    Function? onPressedPositiveButton,
  }) =>
      CustomAlertDialog(
        context: context!,
        title: title,
        message: message,
        disableNegativeButton: disableNegativeButton,
        disablePositiveButton: disablePositiveButton,
        positiveButtonText: positiveButtonText,
        onPressedPositiveButton: onPressedPositiveButton,
        negativeButtonText: negativeButtonText ?? "Confirm",
      ).show();
}
