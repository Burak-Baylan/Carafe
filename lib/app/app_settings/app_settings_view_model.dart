import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:Carafe/app/enums/app_theme_enums.dart';
import 'package:Carafe/core/init/theme/app_themes.dart';
part 'app_settings_view_model.g.dart';

class AppSettingsViewModel = _AppSettingsViewModelBase
    with _$AppSettingsViewModel;

abstract class _AppSettingsViewModelBase with Store {
  @observable
  ThemeData appTheme = AppThemes.instance.lightTheme;

  @action
  changeTheme(Themes theme) {
    switch (theme) {
      case Themes.LIGHT:
        appTheme = AppThemes.instance.lightTheme;
        break;
      case Themes.DARK:
        appTheme = AppThemes.instance.darkTheme;
        break;
      case Themes.APP_THEME:
        appTheme = AppThemes.instance.myTheme;
        break;
    }
  }
}
