import 'package:flutter/material.dart';
import 'package:Carafe/app/constants/constants_colors.dart';

class AppThemes {
  static AppThemes? _instance;
  static AppThemes get instance =>
      _instance = _instance == null ? AppThemes._init() : _instance!;
  AppThemes._init();

  ThemeData get lightTheme => ThemeData(
      primaryColor: AppColors.primary,
      colorScheme: ColorScheme(
        primary: AppColors.primary,
        primaryVariant: Colors.white,
        secondary: Colors.white,
        secondaryVariant: Colors.white,
        surface: Colors.black,
        background: Colors.white,
        error: Colors.redAccent,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: AppColors.primary, // TextInput altındaki çizgi rengi
        onBackground: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black)));

  ThemeData get darkTheme => ThemeData(
        primaryColor: Colors.greenAccent,
        colorScheme: const ColorScheme(
          primary: Colors.black,
          primaryVariant: Colors.black,
          secondary: Colors.black,
          secondaryVariant: Colors.black,
          surface: Colors.black,
          background: Colors.black,
          error: Colors.black,
          onPrimary: Colors.black,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.black,
          brightness: Brightness.light,
        ),
      );

  ThemeData get myTheme => ThemeData(
      primaryColor: Colors.black,
      colorScheme: const ColorScheme(
        primary: Colors.black,
        primaryVariant: Colors.black,
        secondary: Colors.black,
        secondaryVariant: Colors.black,
        surface: Colors.black,
        background: Colors.black,
        error: Colors.black,
        onPrimary: Colors.black,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onBackground: Colors.black,
        onError: Colors.black,
        brightness: Brightness.light,
      ),
      inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black)));
}
