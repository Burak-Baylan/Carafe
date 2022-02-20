// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AppColors {
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  static final Color primary = Color(0xffD57E7E);
  static final Color secondary = Color(0xff316B83);
  static final Color backGroundGrey = Color(0xfff1f3f8);
  static final Color correctGreen = Color(0xffb7c575);
  static final Color placeHolderGray = Colors.grey.shade300;
}

class AppConstants {
  static const APP_NAME = "Carafe";
  static const LOCALE = "en";
}

class PostContstants {
  static const MAX_POST_TEXT_LENGTH = 300;
  static const WARNING_POST_TEXT_LENGTH = 250;

  static const WARNING_LENGTH_COLOR = Colors.orangeAccent;
  static const MAX_LENGTH_COLOR = Colors.redAccent;

  static const String ALL = "All";
  static const String TECHNOLOGY = "Technology";
  static const String SOFTWARE = "Software";
  static const String GAMES = "Games";
  static const String ADVICES = "Advices";
  static const String ENTERPRISE = "Enterprise";
  static const String PINNED_POST = "Pinned Post";

  static const IconData TECHNOLOGY_ICON = Icons.phone_android_outlined;
  static const IconData SOFTWARE_ICON = Icons.laptop_mac_outlined;
  static const IconData GAMES_ICON = Icons.games_outlined;
  static const IconData ADVICES_ICON = Icons.book_outlined;
  static const IconData ENTERPRISE_ICON = Icons.attach_money_outlined;
  static const IconData PINNED_POST_ICON = Icons.push_pin_sharp;
}
