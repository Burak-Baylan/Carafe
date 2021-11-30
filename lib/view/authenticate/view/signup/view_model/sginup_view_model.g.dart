// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sginup_view_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SignupViewModel on _SignupViewModelBase, Store {
  final _$formKeyAtom = Atom(name: '_SignupViewModelBase.formKey');

  @override
  GlobalKey<FormState> get formKey {
    _$formKeyAtom.reportRead();
    return super.formKey;
  }

  @override
  set formKey(GlobalKey<FormState> value) {
    _$formKeyAtom.reportWrite(value, super.formKey, () {
      super.formKey = value;
    });
  }

  final _$usernameLockAtom = Atom(name: '_SignupViewModelBase.usernameLock');

  @override
  bool get usernameLock {
    _$usernameLockAtom.reportRead();
    return super.usernameLock;
  }

  @override
  set usernameLock(bool value) {
    _$usernameLockAtom.reportWrite(value, super.usernameLock, () {
      super.usernameLock = value;
    });
  }

  final _$emailLockAtom = Atom(name: '_SignupViewModelBase.emailLock');

  @override
  bool get emailLock {
    _$emailLockAtom.reportRead();
    return super.emailLock;
  }

  @override
  set emailLock(bool value) {
    _$emailLockAtom.reportWrite(value, super.emailLock, () {
      super.emailLock = value;
    });
  }

  final _$passwordLockAtom = Atom(name: '_SignupViewModelBase.passwordLock');

  @override
  bool get passwordLock {
    _$passwordLockAtom.reportRead();
    return super.passwordLock;
  }

  @override
  set passwordLock(bool value) {
    _$passwordLockAtom.reportWrite(value, super.passwordLock, () {
      super.passwordLock = value;
    });
  }

  final _$signupControlAsyncAction =
      AsyncAction('_SignupViewModelBase.signupControl');

  @override
  Future<dynamic> signupControl(SignupViewModel viewModel) {
    return _$signupControlAsyncAction.run(() => super.signupControl(viewModel));
  }

  final _$_SignupViewModelBaseActionController =
      ActionController(name: '_SignupViewModelBase');

  @override
  void changeTabIndex(int index) {
    final _$actionInfo = _$_SignupViewModelBaseActionController.startAction(
        name: '_SignupViewModelBase.changeTabIndex');
    try {
      return super.changeTabIndex(index);
    } finally {
      _$_SignupViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic removeTextInputFocus() {
    final _$actionInfo = _$_SignupViewModelBaseActionController.startAction(
        name: '_SignupViewModelBase.removeTextInputFocus');
    try {
      return super.removeTextInputFocus();
    } finally {
      _$_SignupViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeInputState() {
    final _$actionInfo = _$_SignupViewModelBaseActionController.startAction(
        name: '_SignupViewModelBase.changeInputState');
    try {
      return super.changeInputState();
    } finally {
      _$_SignupViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formKey: ${formKey},
usernameLock: ${usernameLock},
emailLock: ${emailLock},
passwordLock: ${passwordLock}
    ''';
  }
}
