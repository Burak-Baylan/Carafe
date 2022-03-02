import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../core/constants/navigation/navigation_constants.dart';
import '../../../../../core/data/custom_data.dart';
import '../../../../../main.dart';
import '../../../view_model/base_authentication_view_model.dart';
import '../model/login_model.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase extends IAuthenticationViewModel with Store {
  @override
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
  void setContext(BuildContext context) => this.context = context;

  @action
  Future<void> loginControl() async {
    changeInputState();
    if (!formKey.currentState!.validate()) {
      changeInputState();
      return;
    }
    removeTextInputFocus();
    await _login();
    changeInputState();
  }

  Future<void> _login() async {
    _initializeCredenticial();
    await authService
        .login(LoginModel(email: email, password: password))
        .then((value) async {
      await _responseControl(value);
    });
  }

  void _initializeCredenticial() {
    email = emailController.text.trim();
    password = passworController.text.trim();
  }

  Future<void> _responseControl(CustomData<UserCredential> response) async {
    if (response.error != null) {
      showAlert(
        "Error",
        response.error!.errorMessage.toString(),
        context: context!,
        disablePositiveButton: true,
      );
      return;
    }
    await _emailValidateControl();
  }

  Future<void> _emailValidateControl() async {
    await mainVm.startApp();
    //replacePage(path: NavigationConstans.MAIN_VIEW, data: null);
    //return;

    if (authService.isEmailValid!) {
      //await FirebaseManager.instance.getFollowingUsersIds();
      await mainVm.startApp();
      replacePage(path: NavigationConstans.MAIN_VIEW, data: null);
    } else {
      showAlert(
        "Error",
        "Email not verified. Please verified your email.",
        context: context!,
        positiveButtonText: "Send mail",
        negativeButtonText: "Cancel",
        onPressedPositiveButton: () async {
          await authService.sendVerificationEmail();
          await auth.signOut();
        },
        onPressedNegativeButton: () => auth.signOut(),
      ).then((value) => auth.signOut());
    }
  }

  @override
  @action
  void changeTabIndex(int index) => authVm.changeTabIndex(index);

  @action
  void changeInputState() {
    emailTextInputLock = !emailTextInputLock;
    passwordTextInputLock = !passwordTextInputLock;
  }

  @action
  void removeTextInputFocus() {
    emailFocusNode.unfocus();
    passwordFocusNode.unfocus();
  }
}
