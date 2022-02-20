import 'package:flutter/material.dart';
import '../custom_alert_dialog.dart';

class CustomAlerDialogDemonstrator {
  static CustomAlerDialogDemonstrator? _instance;
  static CustomAlerDialogDemonstrator get instance => _instance =
      _instance == null ? CustomAlerDialogDemonstrator._init() : _instance!;
  CustomAlerDialogDemonstrator._init();

  show(
    String title,
    String message, {
    required BuildContext context,
    bool disableNegativeButton = false,
    bool disablePositiveButton = false,
    String? positiveButtonText,
    String? negativeButtonText = 'Confirm',
    Function? onPressedPositiveButton,
    Function? onPressedNegativeButton,
    double? borderRadius,
    bool dismissible = true,
  }) {
    CustomAlertDialog(
      context: context,
      title: title,
      message: message,
      disableNegativeButton: disableNegativeButton,
      disablePositiveButton: disablePositiveButton,
      positiveButtonText: positiveButtonText,
      onPressedPositiveButton: onPressedPositiveButton,
      onPressedNegativeButton: onPressedNegativeButton,
      negativeButtonText: negativeButtonText,
      borderRadius: borderRadius,
      dismissible: dismissible,
    ).show();
  }
}
