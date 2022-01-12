import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemBottomNavigationBarHelper {
  static void get lightBottomNavBar =>
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ));
}
