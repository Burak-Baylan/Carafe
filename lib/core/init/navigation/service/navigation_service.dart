// ignore_for_file: prefer_function_declarations_over_variables
import 'package:Carafe/core/extensions/int_extensions.dart';
import 'package:Carafe/core/init/navigation/route/custom_page_route.dart';
import 'package:Carafe/core/init/navigation/service/INavigationService.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class NavigationService extends INavigationService {
  static final NavigationService _instance = NavigationService._init();
  static NavigationService get instance => _instance;
  NavigationService._init();

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final removeAllRoutes = (Route<dynamic> route) => false;

  @override
  Future<void> navigateToPage({
    required String path,
    required Object? data,
  }) async =>
      await navigatorKey.currentState!.pushNamed(path, arguments: data);

  Future<void> replacePageNamed({
    required String path,
    required Object? data,
  }) async =>
      await navigatorKey.currentState!
          .pushReplacementNamed(path, arguments: data);

  void customNavigateToPage(Widget page, {bool animate = true}) async {
    await navigatorKey.currentState!.push(
      animate
          ? PageTransition(
              child: page,
              type: PageTransitionType.rightToLeftWithFade,
              duration: 200.durationMilliseconds,
              reverseDuration: 200.durationMilliseconds)
          : MaterialPageRoute(builder: (context) => page),
    );
  }

  void replacePage(Widget page, {bool animate = true}) {
    navigatorKey.currentState!.pushReplacement(
      animate
          ? CustomPageRoute(child: page)
          : MaterialPageRoute(builder: (context) => page),
    );
  }

  void pushAndRemoveAll(Widget page, {bool animate = true}) {
    navigatorKey.currentState!.pushAndRemoveUntil(
      animate
          ? CustomPageRoute(child: page)
          : MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  @override
  Future<void> navigateToPageClear({
    required String path,
    required Object data,
  }) async {
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(path, removeAllRoutes, arguments: data);
  }
}
