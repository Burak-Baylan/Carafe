import 'package:Carafe/core/error/custom_error.dart';
import 'package:Carafe/core/firebase/auth/authentication/service/forgot_password_service.dart';
import 'package:Carafe/core/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'forgot_password_view_model.g.dart';

class ForgotPasswordViewModel = _ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase with Store {
  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode emailFocusNode = FocusNode();

  late BuildContext _context;

  setContext(BuildContext context) => _context = context;

  Future<void> sendPasswordResetMail() async {
    if (formKey.currentState!.validate()) {
      await ForgotPasswordService.instance
          .send(emailController.text)
          .then((value) => _responseControl(value));
    }
  }

  _responseControl(CustomError response) {
    if (response.errorMessage == null) {
      _successResponse();
    } else {
      _unseccessfulResponse(response.errorMessage!.toString());
    }
  }

  _successResponse() {
    emailController.clear();
    emailFocusNode.unfocus();
    _showAlert("Sent", "Email sent, please check your mailbox.");
  }

  _unseccessfulResponse(String message) {
    _showAlert("Error", message);
  }

  _showAlert(String title, String message) => CustomAlertDialog(
        context: _context,
        title: title,
        message: message,
        disableNegativeButton: true,
        positiveButtonText: "Confirm",
      ).show();
}
