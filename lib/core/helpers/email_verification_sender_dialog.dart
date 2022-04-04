import 'package:flutter/material.dart';
import '../../main.dart';

Future<void> showEmailVerificationSenderDialog(
  BuildContext context, {
  Function? onPressedPositiveButton,
  Function? onPressedNegativeButton,
  String? title,
  String? message,
  String? positiveButtonText,
  String? negativeButtonText,
}) async {
  await mainVm.showAlert(
    title ?? "Message",
    message ?? "Email not verified. Please verify your email.",
    context: context,
    positiveButtonText: positiveButtonText ?? "Send mail",
    negativeButtonText: negativeButtonText ?? "Cancel",
    onPressedPositiveButton: () async {
      if (onPressedPositiveButton != null) {
        onPressedPositiveButton();
      }
    },
    onPressedNegativeButton: () {
      if (onPressedNegativeButton != null) {
        onPressedNegativeButton();
      }
    },
  );
}
