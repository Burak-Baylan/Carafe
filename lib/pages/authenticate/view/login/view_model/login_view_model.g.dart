// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginViewModel on _LoginViewModelBase, Store {
  final _$emailTextInputLockAtom =
      Atom(name: '_LoginViewModelBase.emailTextInputLock');

  @override
  bool get emailTextInputLock {
    _$emailTextInputLockAtom.reportRead();
    return super.emailTextInputLock;
  }

  @override
  set emailTextInputLock(bool value) {
    _$emailTextInputLockAtom.reportWrite(value, super.emailTextInputLock, () {
      super.emailTextInputLock = value;
    });
  }

  final _$passwordTextInputLockAtom =
      Atom(name: '_LoginViewModelBase.passwordTextInputLock');

  @override
  bool get passwordTextInputLock {
    _$passwordTextInputLockAtom.reportRead();
    return super.passwordTextInputLock;
  }

  @override
  set passwordTextInputLock(bool value) {
    _$passwordTextInputLockAtom.reportWrite(value, super.passwordTextInputLock,
        () {
      super.passwordTextInputLock = value;
    });
  }

  final _$loginControlAsyncAction =
      AsyncAction('_LoginViewModelBase.loginControl');

  @override
  Future<void> loginControl() {
    return _$loginControlAsyncAction.run(() => super.loginControl());
  }

  final _$_LoginViewModelBaseActionController =
      ActionController(name: '_LoginViewModelBase');

  @override
  void changeTabIndex(int index) {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.changeTabIndex');
    try {
      return super.changeTabIndex(index);
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeInputState() {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.changeInputState');
    try {
      return super.changeInputState();
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTextInputFocus() {
    final _$actionInfo = _$_LoginViewModelBaseActionController.startAction(
        name: '_LoginViewModelBase.removeTextInputFocus');
    try {
      return super.removeTextInputFocus();
    } finally {
      _$_LoginViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
emailTextInputLock: ${emailTextInputLock},
passwordTextInputLock: ${passwordTextInputLock}
    ''';
  }
}
