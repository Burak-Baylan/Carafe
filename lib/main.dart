import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'app/app_settings/app_settings_view_model.dart';
import 'core/extensions/color_extensions.dart';
import 'core/extensions/context_extensions.dart';
import 'core/init/navigation/route/navigation_route.dart';
import 'core/init/navigation/service/navigation_service.dart';
import 'view/authenticate/authenticate_view.dart';
import 'view/main/view/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  AppSettingsViewModel viewModel = AppSettingsViewModel();

  @override
  Widget build(BuildContext context) {
    Colors.transparent.changeStatusBarColor;
    return Observer(builder: (_) {
      return MaterialApp(
        navigatorKey: NavigationService.instance.navigatorKey,
        onGenerateRoute: NavigationRoute.instance.generateRoute,
        debugShowCheckedModeBanner: false,
        theme: viewModel.appTheme,
        home: FutureBuilder(
          future: start(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                //errorScreen
                child: Text("ERROR: " + snapshot.error.toString()),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              snapshot.data;
              FirebaseAuth auth = FirebaseAuth.instance;
              return autoLoginControl(auth);
            }
            return Container(
              //splashScreen
              color: Colors.white,
              width: context.width,
              height: context.height,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      );
    });
  }

  Future<void>? start() async {
    await Firebase.initializeApp();
  }

  Widget autoLoginControl(FirebaseAuth auth) {
    if (auth.currentUser != null) {
      return const MainScreen();
    }
    return AuthenticateView();

  }
}
