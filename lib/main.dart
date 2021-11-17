import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'app/app_settings/app_settings_view_model.dart';
import 'core/init/navigation/route/navigation_route.dart';
import 'core/init/navigation/service/navigation_service.dart';
import 'view/authenticate/authenticate_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  AppSettingsViewModel viewModel = AppSettingsViewModel();

  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return Observer(builder: (_) {
      return MaterialApp(
        navigatorKey: NavigationService.instance.navigatorKey,
        onGenerateRoute: NavigationRoute.instance.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: viewModel.appTheme,
        home: AuthenticateView(),
      );
    });
  }
}
