// ignore_for_file: overridden_fields

import 'package:Carafe/core/extensions/string_extensions.dart';
import 'package:Carafe/core/firebase/auth/authentication/response/authentication_response.dart';
import 'package:Carafe/core/firebase/auth/authentication/service/firebase_auth_service.dart';
import 'package:Carafe/core/widgets/custom_alert_dialog.dart';
import 'package:Carafe/view/authenticate/view/login/model/login_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:Carafe/view/authenticate/view_model/base_authentication_view_model.dart';
part 'sginup_view_model.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase extends IAuthenticationViewModel
    with Store {
  @override
  BuildContext? context;

  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passworController = TextEditingController();
  String? username;
  String? email;
  String? password;

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @observable
  bool usernameLock = false;
  @observable
  bool emailLock = false;
  @observable
  bool passwordLock = false;

  @override
  setContext(BuildContext context) => this.context = context;

  @action
  Future<dynamic> signupControl() async {
    _changeInputState();
    if (!formKey.currentState!.validate()) {
      _changeInputState();
      return;
    }
    _removeTextInputFocus();
    await _signup();
    _changeInputState();
  }

  _signup() async {
    _initializeCredenticial();
    await FirebaseAuthService.instance
        .signup(LoginModel(email: email, password: password))
        .then((value) {
      _responseControl(value);
    });
  }

  _initializeCredenticial() {
    username = usernameController.text;
    email = emailController.text;
    password = passworController.text;
  }

  _responseControl(AuthnenticationResponse value) {
    if (value.error != null) {
      _showAlert("Error", value.error!.message.toString(), false);
      return;
    }
    _clearAllTextInputs();
    _showAlert("Success", "Signup successful. Please verify your email.", true);
    value.user!.sendEmailVerification();
  }

  _clearAllTextInputs() {
    usernameController.clear();
    emailController.clear();
    passworController.clear();
  }

  _showAlert(String title, String message, bool changePage) =>
      CustomAlertDialog(
        context: context!,
        title: title,
        message: message,
        positiveButtonText: "Confirm",
        onPressedPositiveButton: () =>
            changePage == true ? changeTabIndex(0) : null,
        disableNegativeButton: true,
      ).show();

  @override
  @action
  changeTabIndex(int index) => authVm.changeTabIndex(index);

  @action
  _removeTextInputFocus() {
    usernameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  @action
  _changeInputState() {
    usernameLock = !usernameLock;
    emailLock = !emailLock;
    passwordLock = !passwordLock;
  }

  String? usernameValidator(String? text) {
    if (text == null || text.isEmpty) {
      return "Username cannot be empty";
    }
    if (!text.isUsernameValid) {
      return "Username characters can be only alphabets, numbers, or underscores.";
    }
    if (text.length < 5) {
      return "Username cannot be less than 5 characters";
    }
    if (text.length > 16) {
      return "Username cannot be greater than 16 characters";
    }
    return null;
  }
}
