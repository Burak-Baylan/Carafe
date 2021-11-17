import 'package:Carafe/core/constants/navigation/navigation_constants.dart';
import 'package:Carafe/view/authenticate/authenticate_view.dart';
import 'package:Carafe/view/authenticate/view/forgot_password/view/forgot_password_view.dart';
import 'package:Carafe/view/main/view/main_screen.dart';
import 'package:flutter/material.dart';

class NavigationRoute {
  static final NavigationRoute _instance = NavigationRoute._init();
  static NavigationRoute get instance => _instance;
  NavigationRoute._init();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstans.MAIN_VIEW:
        return normalNavigate(MainScreen());
      case NavigationConstans.FORGOT_PASSWORD_VIEW:
        return normalNavigate(ForgotPasswordView());
      default:
    }
    return MaterialPageRoute(
      builder: (context) => AuthenticateView(),
    );
  }

  MaterialPageRoute normalNavigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}
