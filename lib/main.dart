import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:Carafe/app/app_settings/app_settings_view_model.dart';
import 'package:Carafe/view/authenticate/authenticate_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  AppSettingsViewModel viewModel = AppSettingsViewModel();

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: viewModel.appTheme,
        home: AuthenticateView(),
      );
    });
  }
}
