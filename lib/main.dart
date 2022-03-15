import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:overlay_support/overlay_support.dart';
import 'app/app_settings/app_settings_view_model.dart';
import 'core/helpers/system_navigation_bar_helper.dart';
import 'core/hive/hive_helper.dart';
import 'core/init/navigation/route/navigation_route.dart';
import 'core/init/navigation/service/navigation_service.dart';
import 'pages/main/view_model/main_view_view_model.dart';

MainViewViewModel mainVm = MainViewViewModel();

main() {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.removeAfter(start);
  runApp(MyApp());
}

Future start(BuildContext context) async {
  mainVm.setContext(context);
  await HiveHelper.instance.initHive();
  await Firebase.initializeApp();
  await mainVm.startApp();
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  AppSettingsViewModel viewModel = AppSettingsViewModel();

  @override
  Widget build(BuildContext context) {
    SystemBottomNavigationBarHelper.lightBottomNavBar;
    return Observer(builder: (_) {
      return OverlaySupport(
        child: MaterialApp(
          navigatorKey: NavigationService.instance.navigatorKey,
          onGenerateRoute: NavigationRoute.instance.generateRoute,
          debugShowCheckedModeBanner: false,
          theme: viewModel.appTheme,
          home: mainVm.startingPage,
        ),
      );
    });
  }
}
