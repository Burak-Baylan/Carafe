import 'package:flutter/material.dart';
import '../../../../../../core/alerts/alert_dialog/custom_alert_dialog.dart';
import '../../../../../../core/extensions/context_extensions.dart';

class AddPostAlertDialogHelper {
  Future<void> showQuitAlert(BuildContext context) async => CustomAlertDialog(
        title: "Remove Post",
        message: "Are you sure you want to delete your post and exit.",
        context: context,
        negativeButtonText: "Cancel",
        positiveButtonText: "Exit",
        onPressedPositiveButton: () => context.pop,
      ).show();

  void putImageErrorAlert(BuildContext context) => CustomAlertDialog(
        title: "Message",
        message:
            "You can only select 4 image.\nIf you want, you can delete one of the photos you have uploaded.",
        context: context,
        disableNegativeButton: true,
      ).show();

  void postSharingErrorAlert(BuildContext context, String message) =>
      CustomAlertDialog(
        title: "Error",
        message: message,
        context: context,
        negativeButtonText: "Cancel",
        positiveButtonText: "Exit",
        onPressedPositiveButton: () => context.pop,
      ).show();
}
