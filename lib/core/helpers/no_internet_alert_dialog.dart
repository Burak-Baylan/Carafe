import 'package:Carafe/core/alerts/alert_dialog/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class NoInternetAlertDialog {
  static show(BuildContext context) => CustomAlertDialog(
        context: context,
        title: 'No Internet',
        message: "Connect failed. Please connect internet and try again.",
        disableNegativeButton: true,
        positiveButtonText: "Ok",
      ).show();
}
