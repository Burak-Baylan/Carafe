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
  void setContext(BuildContext context) => this.context = context;

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

  Future<void> _signup(SignupViewModel viewModel) async {
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

  void initializeCredenticial() {
    displayName = displayNameController.text;
    username = usernameController.text;
    email = emailController.text;
    password = passworController.text;
  }

  void clearAllTextInputs() {
    displayNameController.clear();
    usernameController.clear();
    emailController.clear();
    passworController.clear();
  }

  @override
  @action
  void changeTabIndex(int index) => authVm.changeTabIndex(index);

  @action
  void removeTextInputFocus() {
    displayNameFocusNode.unfocus();
    usernameFocusNode.unfocus();
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }

  @action
  void changeInputState() {
    displayNameLock = !displayNameLock;
    usernameLock = !usernameLock;
    emailLock = !emailLock;
    passwordLock = !passwordLock;
  }

  String? usernameValidator(String? text) => text?.usernameValidator;

  String? displayNameValidator(String? text) => text?.displayNameValidator;

  void showSignupSuccessAlert() => showAlert(
        "Success",
        "Signup successful. Please verify your email.",
        context: context!,
        onPressedPositiveButton: () => changeTabIndex(0),
        disableNegativeButton: true,
      );
}
