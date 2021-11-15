// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthenticateViewModel on _AuthenticateViewModelBase, Store {
  final _$headerImageAtom =
      Atom(name: '_AuthenticateViewModelBase.headerImage');

  @override
  String get headerImage {
    _$headerImageAtom.reportRead();
    return super.headerImage;
  }

  @override
  set headerImage(String value) {
    _$headerImageAtom.reportWrite(value, super.headerImage, () {
      super.headerImage = value;
    });
  }

  final _$_AuthenticateViewModelBaseActionController =
      ActionController(name: '_AuthenticateViewModelBase');

  @override
  dynamic changeHeaderImage(int index) {
    final _$actionInfo = _$_AuthenticateViewModelBaseActionController
        .startAction(name: '_AuthenticateViewModelBase.changeHeaderImage');
    try {
      return super.changeHeaderImage(index);
    } finally {
      _$_AuthenticateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeTabIndex(int index) {
    final _$actionInfo = _$_AuthenticateViewModelBaseActionController
        .startAction(name: '_AuthenticateViewModelBase.changeTabIndex');
    try {
      return super.changeTabIndex(index);
    } finally {
      _$_AuthenticateViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
headerImage: ${headerImage}
    ''';
  }
}
