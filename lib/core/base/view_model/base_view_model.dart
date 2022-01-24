import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../alerts/alert_dialog/demonstrator/custom_alert_dialog_demonstrator.dart';
import '../../extensions/double_extensions.dart';
import '../../firebase/base/firebase_base.dart';
import '../../helpers/colorful_print.dart';
import '../../helpers/image_colors_getter.dart';
import '../../helpers/no_internet_alert_dialog.dart';
import '../../helpers/random_id.dart';
import '../../hive/hive_helper.dart';
import '../../init/navigation/service/navigation_service.dart';

abstract class BaseViewModel with FirebaseBase {
  BuildContext? context;
  setContext(BuildContext context);

  Timestamp get currentTime => Timestamp.now();

  ImageColorsGetter imageColorsGetter = ImageColorsGetter();
  HiveHelper hiveHelper = HiveHelper.instance;

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

  showToast(String message) => Fluttertoast.showToast(msg: message);

  showNoInternetAlert(BuildContext context) =>
      NoInternetAlertDialog.show(context);

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
    double? borderRadius,
  }) =>
      CustomAlerDialogDemonstrator.instance.show(
        title,
        message,
        context: context,
        disableNegativeButton: disableNegativeButton,
        disablePositiveButton: disablePositiveButton,
        negativeButtonText: negativeButtonText,
        positiveButtonText: positiveButtonText,
        onPressedNegativeButton: onPressedNegativeButton,
        onPressedPositiveButton: onPressedPositiveButton,
        borderRadius: borderRadius,
      );

  printYellow(String text) => ColorfulPrint.yellow(text);

  printRed(String text) => ColorfulPrint.red(text);

  printGreen(String text) => ColorfulPrint.green(text);

  get randomId => getRandomId();
}
