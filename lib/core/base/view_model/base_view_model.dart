import 'package:flutter/cupertino.dart';

import '../../firebase/auth/authentication/service/firebase_auth_service.dart';
import '../../firebase/firestore/service/firebase_user_service.dart';
import '../../helpers/colorful_print.dart';
import '../../init/navigation/service/navigation_service.dart';
import '../../widgets/custom_alert_dialog.dart';

abstract class BaseViewModel {
  BuildContext? context;
  setContext(BuildContext context);
  FirebaseAuthService authService = FirebaseAuthService.instance;
  FirebaseUserService userService = FirebaseUserService.instance;

  navigateToPage({required String path, required Object? data}) {
    NavigationService.instance.navigateToPage(
      path: path,
      data: data,
    );
  }

  showAlert(
    String title,
    String message, {
    required BuildContext context,
    bool disableNegativeButton = false,
    bool disablePositiveButton = false,
    String? positiveButtonText,
    String? negativeButtonText,
    Function? onPressedPositiveButton,
    Function? onPressedNegativeButton,
  }) =>
      CustomAlertDialog(
        context: context,
        title: title,
        message: message,
        disableNegativeButton: disableNegativeButton,
        disablePositiveButton: disablePositiveButton,
        positiveButtonText: positiveButtonText,
        onPressedPositiveButton: onPressedPositiveButton,
        onPressedNegativeButton: onPressedNegativeButton,
        negativeButtonText: negativeButtonText ?? "Confirm",
      ).show();

  showBottomSheetWith2Action(
    BuildContext context, {
    required String actionOneText,
    required String actionTwoText,
    required Function() actionOnePressed,
    required Function() actionTwoPressed,
  }) =>
      showCupertinoModalPopup(
        context: context,
        builder: (context) => CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                actionOnePressed();
                Navigator.of(context, rootNavigator: true).pop("Discard");
              },
              child: Text(actionOneText),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                actionTwoPressed();
                Navigator.of(context, rootNavigator: true).pop("Discard");
              },
              child: Text(actionTwoText),
            )
          ],
        ),
      );

  printYellow(String text) => ColorfulPrint.yellow(text);

  printRed(String text) => ColorfulPrint.red(text);

  printGreen(String text) => ColorfulPrint.green(text);
}
