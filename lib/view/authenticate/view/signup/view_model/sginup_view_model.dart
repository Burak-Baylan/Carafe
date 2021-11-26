// ignore_for_file: overridden_fields
import 'package:Carafe/core/error/custom_error.dart';
import 'package:Carafe/core/extensions/string_extensions.dart';
import 'package:Carafe/core/firebase/auth/authentication/response/authentication_response.dart';
import 'package:Carafe/core/firebase/auth/model/user_model.dart';
import 'package:Carafe/view/authenticate/view/login/model/login_model.dart';
import 'package:Carafe/view/authenticate/view_model/base_authentication_view_model.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

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
    _initializeCredenticial();
    await _signup();
    _changeInputState();
    _removeTextInputFocus();
  }

  _signup() async {
    AuthnenticationResponse authenticationResponse = await authService.signup(
        LoginModel(email: email, password: password, displayName: username));

    bool isResponseOkey = _authSignupResponseControl(authenticationResponse);

    if (isResponseOkey) {
      CustomError userCreateResponse = await userService.createUser(UserModel(
        user: authenticationResponse.user,
        email: email,
        username: username,
      ));
      bool isUserCrated = await _firebaseSignupResponseControl(
          userCreateResponse, authenticationResponse);

      if (isUserCrated) {
        await authService.sendVerificationEmail(authenticationResponse.user!);
        _showSignupSuccessAlert();
        _clearAllTextInputs();
      }
    }
  }

  _showSignupSuccessAlert() => showAlert(
        "Success",
        "Signup successful. Please verify your email.",
        context: context!,
        onPressedPositiveButton: () => changeTabIndex(0),
        disableNegativeButton: true,
      );

  Future<bool> _firebaseSignupResponseControl(
      CustomError response, AuthnenticationResponse authResponse) async {
    if (response.message == null) {
      return true;
    } else {
      await authService.deleteUser(authResponse.user!);
      showAlert("Error", response.message!,
          context: context!, disableNegativeButton: true);
      return false;
    }
  }

  bool _authSignupResponseControl(AuthnenticationResponse response) {
    if (response.error != null) {
      showAlert("Error", response.error!.message.toString(),
          context: context!, disableNegativeButton: true);
      return false;
    }
    return true;
  }

  _initializeCredenticial() {
    username = usernameController.text;
    email = emailController.text;
    password = passworController.text;
  }

  _clearAllTextInputs() {
    usernameController.clear();
    emailController.clear();
    passworController.clear();
  }

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
