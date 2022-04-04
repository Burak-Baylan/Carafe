import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/error/custom_error.dart';
import '../../../../../core/alerts/alert_dialog/custom_alert_dialog.dart';
part 'forgot_password_view_model.g.dart';

class ForgotPasswordViewModel = _ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase extends BaseViewModel with Store {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();

  @override
  late BuildContext? context;
  @override
  setContext(BuildContext context) => this.context = context;

  Future<void> sendPasswordResetMail() async {
    if (formKey.currentState!.validate()) {
      await authService
          .sendPasswordResetEmail(emailController.text)
          .then((value) => _responseControl(value));
    }
  }

  void _responseControl(CustomError response) {
    if (response.errorMessage == null) {
      _successResponse();
    } else {
      _unseccessfulResponse(response.errorMessage!.toString());
    }
  }

  void _successResponse() {
    emailController.clear();
    emailFocusNode.unfocus();
    _showAlert("Sent", "Email sent, please check your mailbox.");
  }

  void _unseccessfulResponse(String message) => _showAlert("Error", message);

  void _showAlert(String title, String message) => CustomAlertDialog(
        context: context!,
        title: title,
        message: message,
        disableNegativeButton: true,
        positiveButtonText: "Confirm",
      ).show();
}
