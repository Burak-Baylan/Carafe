import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../core/data/custom_data.dart';
import '../../../../../core/helpers/email_verification_sender_dialog.dart';
import '../../../../../main.dart';
import '../../../../main/view/home/view/sub_views/home_view/home_view.dart';
import '../../../view_model/base_authentication_view_model.dart';
import '../../forgot_password/view/forgot_password_view.dart';
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
    if (authService.isEmailValid!) {
      await mainVm.startApp();
      customReplacePage(page: const HomeView(), animate: true);
    } else {
      showEmailVerificationSenderDialog(
        context!,
        onPressedPositiveButton: () async {
          await authService.sendVerificationEmail();
          await auth.signOut();
        },
        onPressedNegativeButton: () => auth.signOut(),
      ).then((value) => auth.signOut());
    }
  }

  void navigateToForgorPasswordPage() {
    customNavigateToPage(
      page: ForgotPasswordView(),
      animate: true,
    );
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
