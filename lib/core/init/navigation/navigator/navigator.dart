import 'package:flutter/material.dart';
import '../../../constants/navigation/navigation_constants.dart';
import '../service/navigation_service.dart';

class PushToPage {
  static final PushToPage _instance = PushToPage._init();
  static PushToPage get instance => _instance;
  PushToPage._init();

  void mainPage() => NavigationService.instance
      .navigateToPage(path: NavigationConstans.MAIN_VIEW, data: null);

  void forgotPasswordPage() => NavigationService.instance.navigateToPage(
      path: NavigationConstans.FORGOT_PASSWORD_VIEW, data: null);

  void addPostPage() => NavigationService.instance
      .navigateToPage(path: NavigationConstans.ADD_POST_VIEW, data: null);

  void navigateToCustomPage(Widget page, {bool animate = true}) =>
      NavigationService.instance.customNavigateToPage(page, animate: animate);
}
