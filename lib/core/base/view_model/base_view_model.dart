import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../extensions/double_extensions.dart';
import '../../firebase/base/firebase_base.dart';
import '../../helpers/colorful_print.dart';
import '../../helpers/image_colors_getter.dart';
import '../../init/navigation/service/navigation_service.dart';
import '../../widgets/custom_alert_dialog.dart';

abstract class BaseViewModel with FirebaseBase {
  BuildContext? context;
  setContext(BuildContext context);

  Timestamp currentTime = Timestamp.now();

  ImageColorsGetter imageColorsGetter = ImageColorsGetter();

  navigateToPage({required String path, required Object? data}) =>
      NavigationService.instance.navigateToPage(path: path, data: data);
  replacePage({required String path, required Object? data}) =>
      NavigationService.instance.replacePageNamed(path: path, data: data);

  customNavigateToPage({required Widget page, bool animate = false}) =>
      NavigationService.instance.customNavigateToPage(page, animate: animate);
  customReplacePage({required Widget page, bool animate = false}) =>
      NavigationService.instance.replacePage(page, animate: animate);

  bottomToTopAnimation(Widget child, Animation<double> animation) =>
      SlideTransition(
        child: child,
        position: Tween<Offset>(begin: 1.0.offsetY, end: 0.0.offsetXY)
            .animate(animation),
      );

  showAlert(
    String title,
    String message, {
    required BuildContext context,
    bool disableNegativeButton = false,
    bool disablePositiveButton = false,
    String? positiveButtonText,
    String? negativeButtonText = 'Confirm',
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
        negativeButtonText: negativeButtonText,
      ).show();

  printYellow(String text) => ColorfulPrint.yellow(text);

  printRed(String text) => ColorfulPrint.red(text);

  printGreen(String text) => ColorfulPrint.green(text);

  get getRandomId => const Uuid().v4();
}
