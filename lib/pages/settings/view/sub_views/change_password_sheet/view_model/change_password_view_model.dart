import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../core/alerts/loading_alert_dialog.dart';
import '../../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../../core/error/custom_error.dart';
import '../../../../../authenticate/authenticate_view.dart';
part 'change_password_view_model.g.dart';

class ChangePasswordViewModel = _ChangePasswordViewModelBase
    with _$ChangePasswordViewModel;

abstract class _ChangePasswordViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;

  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  LoadingAlertDialog loadingDialog = LoadingAlertDialog.instance;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String get oldPasswordText => oldPasswordController.text;
  String get newPasswordText => newPasswordController.text;

  String? errorMessage;
  UserCredential? userCredential;

  Future<void> change() async {
    if (!(formKey.currentState!.validate())) {
      return;
    }
    showAreYouSureAlert();
  }

  AuthCredential get authCredential {
    String email = auth.currentUser!.email!;
    String password = oldPasswordText;
    return EmailAuthProvider.credential(email: email, password: password);
  }

  void clearUserCredential() => userCredential = null;

  void showLoadingDialog() => loadingDialog.show(context!);
  void dismissLoadingDialog() => loadingDialog.dismiss();

  Future<void> showSuccessAlert({String? message}) async {
    await showAlert(
      'Success',
      'Password changed successfully. Please login again to continue.',
      context: context!,
      disableNegativeButton: true,
    ).then((value) async => signOut());
  }

  Future<void> signOut() async {
    await userManager.removeUserToken();
    await auth.signOut();
    pushAndRemoveAll(page: AuthenticateView());
  }

  Future<void> showAreYouSureAlert() async {
    await showAlert(
      'Message',
      'Are you sure you want to change your password.',
      context: context!,
      positiveButtonText: 'Yes',
      onPressedPositiveButton: () => updatePassword(),
      negativeButtonText: 'Cancel',
    );
  }

  Future<void> updatePassword() async {
    showLoadingDialog();
    clearUserCredential();
    await reauthenticate();
    if (userCredential?.user == null) {
      dismissLoadingDialog();
      showErrorAlert(message: errorMessage);
      return;
    }
    var response = await updateUserPassword();
    if (response.errorMessage != null) {
      dismissLoadingDialog();
      showErrorAlert(message: response.errorMessage);
    } else {
      dismissLoadingDialog();
      await showSuccessAlert();
    }
  }

  Future<CustomError> updateUserPassword() async {
    var response = await userManager.updateUserPassword(newPasswordText);
    return response;
  }

  Future<void> reauthenticate() async {
    try {
      userCredential =
          await auth.currentUser!.reauthenticateWithCredential(authCredential);
    } on FirebaseException catch (e) {
      errorMessage = e.message;
    }
  }

  Future<void> showErrorAlert({String? message}) async {
    await showAlert(
      'Error',
      message ?? 'Something went wrong. Please try again.',
      context: context!,
      disableNegativeButton: true,
    );
  }
}
