// ignore_for_file: prefer_function_declarations_over_variables

import 'package:Carafe/core/init/navigation/service/INavigationService.dart';
import 'package:flutter/cupertino.dart';

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
  }) async {
    await navigatorKey.currentState!.pushNamed(path, arguments: data);
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
