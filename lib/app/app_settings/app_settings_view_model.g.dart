// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AppSettingsViewModel on _AppSettingsViewModelBase, Store {
  final _$appThemeAtom = Atom(name: '_AppSettingsViewModelBase.appTheme');

  @override
  ThemeData get appTheme {
    _$appThemeAtom.reportRead();
    return super.appTheme;
  }

  @override
  set appTheme(ThemeData value) {
    _$appThemeAtom.reportWrite(value, super.appTheme, () {
      super.appTheme = value;
    });
  }

  final _$_AppSettingsViewModelBaseActionController =
      ActionController(name: '_AppSettingsViewModelBase');

  @override
  dynamic changeTheme(Themes theme) {
    final _$actionInfo = _$_AppSettingsViewModelBaseActionController
        .startAction(name: '_AppSettingsViewModelBase.changeTheme');
    try {
      return super.changeTheme(theme);
    } finally {
      _$_AppSettingsViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
appTheme: ${appTheme}
    ''';
  }
}
