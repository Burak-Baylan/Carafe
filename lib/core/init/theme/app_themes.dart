import 'package:flutter/material.dart';
import 'package:Carafe/app/constants/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemes {
  static AppThemes? _instance;
  static AppThemes get instance =>
      _instance = _instance == null ? AppThemes._init() : _instance!;
  AppThemes._init();

  ThemeData get lightTheme => ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme(
          primary: AppColors.primary,
          primaryVariant: AppColors.correctGreen,
          secondary: AppColors.secondary,
          secondaryVariant: AppColors.secondary,
          surface: Colors.black,
          background: AppColors.backGroundGrey,
          error: Colors.redAccent,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: AppColors.primary, //TextInput altındaki çizgi rengi
          onBackground: Colors.white,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: GoogleFonts.sourceSansPro().fontFamily,
            fontSize: 15,
          ),
          subtitle2: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              fontFamily: GoogleFonts.sourceSansPro().fontFamily,
              color: AppColors.secondary),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black),
        ),
      );

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
