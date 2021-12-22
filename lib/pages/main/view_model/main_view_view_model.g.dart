// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_view_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MainViewViewModel on _MainViewViewModelBase, Store {
  final _$currentIndexAtom = Atom(name: '_MainViewViewModelBase.currentIndex');

  @override
  int get currentIndex {
    _$currentIndexAtom.reportRead();
    return super.currentIndex;
  }

  @override
  set currentIndex(int value) {
    _$currentIndexAtom.reportWrite(value, super.currentIndex, () {
      super.currentIndex = value;
    });
  }

  final _$isFabVisibleAtom = Atom(name: '_MainViewViewModelBase.isFabVisible');

  @override
  bool get isFabVisible {
    _$isFabVisibleAtom.reportRead();
    return super.isFabVisible;
  }

  @override
  set isFabVisible(bool value) {
    _$isFabVisibleAtom.reportWrite(value, super.isFabVisible, () {
      super.isFabVisible = value;
    });
  }

  final _$_MainViewViewModelBaseActionController =
      ActionController(name: '_MainViewViewModelBase');

  @override
  dynamic changeFabVisibility(bool visibility) {
    final _$actionInfo = _$_MainViewViewModelBaseActionController.startAction(
        name: '_MainViewViewModelBase.changeFabVisibility');
    try {
      return super.changeFabVisibility(visibility);
    } finally {
      _$_MainViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeIndex(int index) {
    final _$actionInfo = _$_MainViewViewModelBaseActionController.startAction(
        name: '_MainViewViewModelBase.changeIndex');
    try {
      return super.changeIndex(index);
    } finally {
      _$_MainViewViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentIndex: ${currentIndex},
isFabVisible: ${isFabVisible}
    ''';
  }
}
