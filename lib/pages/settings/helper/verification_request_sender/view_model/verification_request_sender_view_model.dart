import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import '../../../../../core/base/view_model/base_view_model.dart';
import '../../../../../core/extensions/context_extensions.dart';
part 'verification_request_sender_view_model.g.dart';

class VerificationSenderViewModel = VerificationSenderViewModelBase
    with _$VerificationSenderViewModel;

abstract class VerificationSenderViewModelBase extends BaseViewModel
    with Store {
  @override
  BuildContext? context;
  @override
  void setContext(BuildContext context) => this.context = context;

  TextEditingController textController = TextEditingController();

  Future<void> sendVerificationRequest() async {
    showAlert(
      'Message',
      'Are you sure you want to send verification request.',
      context: context!,
      positiveButtonText: 'Send',
      negativeButtonText: 'Cancel',
      onPressedPositiveButton: () {
        sendRequest();
        context!.pop;
      },
    );
  }

  Future<void> sendRequest() async {
    var response = await userManager.sendVerificationRequest();
    if (response.errorMessage != null) {
      showVerificationNotASendAlert();
      return;
    }
    showVerificationSentAlert();
  }

  Future<void> showVerificationSentAlert() async {
    await showAlert(
      'Successful',
      'Verification request sent. We will contant you shortly.',
      context: context!,
      disableNegativeButton: true,
    );
  }

  Future<void> showVerificationNotASendAlert() async {
    showAlert(
      'Error',
      'Verification request couldn\'t sent. Please try again.',
      context: context!,
      disableNegativeButton: true,
    );
  }
}
