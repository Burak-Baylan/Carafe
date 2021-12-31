import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

extension ColorsExtension on Color {
  String get getString => toString().split('(0xff')[1].split(')')[0];
}

extension StatusBarColorExtension on Color {
  void get changeStatusBarColor => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: this));

  void get changeBottomNavBarColor => SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(systemNavigationBarColor: this));
}
