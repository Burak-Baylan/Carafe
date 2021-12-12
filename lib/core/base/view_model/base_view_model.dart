import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import '../../firebase/auth/authentication/service/firebase_auth_service.dart';
import '../../firebase/firestore/manager/firebase_user_manager.dart';
import '../../firebase/firestore/service/firebase.dart';
import '../../firebase/storage/service/firebase_storage_service.dart';
import '../../helpers/colorful_print.dart';
import '../../helpers/dominant_color_getter.dart';
import '../../init/navigation/service/navigation_service.dart';
import '../../widgets/custom_alert_dialog.dart';

abstract class BaseViewModel {
  BuildContext? context;
  setContext(BuildContext context);
  FirebaseAuthService authService = FirebaseAuthService.instance;
  FirebaseUserManager userService = FirebaseUserManager.instance;

  FirestoreService firestoreService = FirestoreService.instance;
  FirebaseStorageService storageService = FirebaseStorageService.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Timestamp currentTime = Timestamp.now();

  Future<Color?> getDominantColor(File image) async =>
      await DominantColorGetter.getColor(image);

  navigateToPage({required String path, required Object? data}) =>
      NavigationService.instance.navigateToPage(path: path, data: data);

  replacePage({required String path, required Object? data}) =>
      NavigationService.instance.replacePageNamed(path: path, data: data);

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

  printYellow(String text) => ColorfulPrint.yellow(text);

  printRed(String text) => ColorfulPrint.red(text);

  printGreen(String text) => ColorfulPrint.green(text);

  get getRandomId => const Uuid().v4();
}
