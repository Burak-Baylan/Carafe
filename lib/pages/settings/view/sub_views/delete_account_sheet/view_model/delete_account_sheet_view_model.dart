import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../../core/alerts/loading_alert_dialog.dart';
import '../../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../../main.dart';
import '../../../../../authenticate/authenticate_view.dart';
import '../../../../../authenticate/model/user_model.dart';
part 'delete_account_sheet_view_model.g.dart';

class DeleteAccountViewModel = DeleteAccountViewModelBase
    with _$DeleteAccountViewModel;

abstract class DeleteAccountViewModelBase extends BaseViewModel with Store {
  @override
  BuildContext? context;

  @override
  void setContext(BuildContext context) => this.context = context;

  LoadingAlertDialog loadingDialog = LoadingAlertDialog.instance;

  TextEditingController controller = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String get currentPasswordText => controller.text;

  UserCredential? userCredential;
  String? errorMessage;

  AuthCredential get authCredential {
    String email = auth.currentUser!.email!;
    String password = currentPasswordText;
    return EmailAuthProvider.credential(email: email, password: password);
  }

  UserModel get currentUserModel => mainVm.currentUserModel!;

  Future<void> delete() async {
    if (!(formKey.currentState!.validate())) {
      return;
    }
    areYouSureAlert();
  }

  void areYouSureAlert() {
    showAlert(
      'Are You Sure?',
      'Are you sure you want to delete your account forever.',
      context: context!,
      positiveButtonText: 'Yes',
      negativeButtonText: 'No',
      onPressedPositiveButton: () => deleteAccount(),
    );
  }

  Future<void> deleteAccount() async {
    showLoadingDialog();
    await reauthenticate();
    if (errorMessage != null) {
      closeLoadingDialog();
      showErrorAlert(errorMessage);
      return;
    }
    var firestoreResponse = await userManager.deleteUserFirestore();
    if (firestoreResponse.errorMessage != null) {
      closeLoadingDialog();
      showErrorAlert(firestoreResponse.errorMessage);
      return;
    }
    var authResponse = await userManager.deleteUserAuth();
    if (authResponse.errorMessage != null) {
      await userManager.createUser(currentUserModel);
      closeLoadingDialog();
      showErrorAlert(authResponse.errorMessage);
      return;
    }
    closeLoadingDialog();
    showSuccessAlert();
  }

  void showLoadingDialog() {
    loadingDialog.show(context!);
  }

  void closeLoadingDialog() {
    loadingDialog.dismiss();
  }

  Future<void> reauthenticate() async {
    try {
      userCredential =
          await auth.currentUser!.reauthenticateWithCredential(authCredential);
    } on FirebaseException catch (e) {
      errorMessage = e.message;
    }
  }

  Future<void> showSuccessAlert() async {
    await showAlert(
      'Success',
      'Your account has been deleted forever.',
      context: context!,
      disableNegativeButton: true,
    ).then((value) async {
      await auth.signOut();
      pushAndRemoveAll(page: AuthenticateView());
    });
  }

  Future<void> showErrorAlert(String? message) async {
    await showAlert(
      'Error',
      message ?? 'Something went wrong. Please try again.',
      context: context!,
      disableNegativeButton: true,
    );
  }
}
