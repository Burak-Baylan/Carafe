import 'package:flutter/material.dart';

import '../../../../pages/authenticate/authenticate_view.dart';
import '../../../../pages/authenticate/view/forgot_password/view/forgot_password_view.dart';
import '../../../../pages/main/view/add_post/view/add_post_page.dart';
import '../../../../pages/main/view/main_screen.dart';
import '../../../constants/navigation/navigation_constants.dart';

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
      case NavigationConstans.ADD_POST_VIEW:
        return normalNavigate(AddPostPage());
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
