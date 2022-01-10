import 'package:flutter/material.dart';
import '../../../../../../core/alerts/alert_dialog/demonstrator/custom_alert_dialog_demonstrator.dart';
import '../../../../../../core/extensions/context_extensions.dart';

class AddPostAlertDialogHelper {
  showQuitAlert(BuildContext context) =>
      CustomAlerDialogDemonstrator.instance.show(
        "Remove Post",
        "Are you sure you want to delete your post and exit.",
        context: context,
        negativeButtonText: "Cancel",
        positiveButtonText: "Exit",
        onPressedPositiveButton: () => context.pop,
      );

  putImageErrorAlert(BuildContext context) =>
      CustomAlerDialogDemonstrator.instance.show(
        "Message",
        "You can only select 4 image.\nIf you want, you can delete one of the photos you have uploaded.",
        context: context,
        disableNegativeButton: true,
      );

  postSharingErrorAlert(BuildContext context, String message) =>
      CustomAlerDialogDemonstrator.instance.show(
        "Error",
        message,
        context: context,
        negativeButtonText: "Cancel",
        positiveButtonText: "Exit",
        onPressedPositiveButton: () => context.pop,
      );
}
