// ignore_for_file: overridden_fields

import 'package:Carafe/core/data/custom_data.dart';
import 'package:Carafe/core/extensions/string_extensions.dart';
import 'package:Carafe/pages/authenticate/view/login/model/login_model.dart';
import 'package:Carafe/pages/authenticate/view_model/base_authentication_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'sginup_view_model.g.dart';

class SignupViewModel = _SignupViewModelBase with _$SignupViewModel;

abstract class _SignupViewModelBase extends IAuthenticationViewModel
    with Store {
  @override
  BuildContext? context;

  FocusNode displayNameFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passworController = TextEditingController();
  String? displayName;
  String? username;
  String? email;
  String? password;

  @observable
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @observable
  bool displayNameLock = false;
  @observable
  bool usernameLock = false;
  @observable
  bool emailLock = false;
  @observable
  bool passwordLock = false;

  @override
  setContext(BuildContext context) => this.context = context;

  @action
  Future<dynamic> signupControl(SignupViewModel viewModel) async {
    changeInputState();
    if (!formKey.currentState!.validate()) {
      changeInputState();
      return;
    }
    initializeCredenticial();
    await _signup(viewModel);
    changeInputState();
    removeTextInputFocus();
  }

  Future _signup(SignupViewModel viewModel) async {
    CustomData<UserCredential> authenticationResponse =
        await authService.signup(
      LoginModel(
        email: email,
        password: password,
        username: username,
        displayName: displayName,
      ),
    );
    await registerUser.register(authenticationResponse, viewModel);
  }

  initializeCredenticial() {
    displayName = displayNameController.text;
    username = usernameController.text;
    email = emailController.text;
    password = passworController.text;
  }

  clearAllTextInputs() {
    displayNameController.clear();
    usernameController.clear();
    emailController.clear();
    passworController.clear();
  }

  @override
  @action
  changeTabIndex(int index) => authVm.changeTabIndex(index);

  @action
  removeTextInputFocus() {
    displayNameFocusNode.unfocus();
    usernameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  @action
  changeInputState() {
    displayNameLock = !displayNameLock;
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

  String? displayNameValidator(String? text) {
    if (text == null || text.isEmpty) {
      return "Display Name cannot be empty";
    }
    if (!text.isDisplayNameValid) {
      return "Display Name characters can be only alphabets, numbers, or underscores.";
    }
    if (text.length < 6) {
      return "Display Name cannot be less than 6 characters";
    }
    if (text.length > 15) {
      return "Display Name cannot be greater than 15 characters";
    }
    return null;
  }

  showSignupSuccessAlert() => showAlert(
        "Success",
        "Signup successful. Please verify your email.",
        context: context!,
        onPressedPositiveButton: () => changeTabIndex(0),
        disableNegativeButton: true,
      );
}
